//
//  AppleAuth.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 14/09/2025.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct SignInWithApple: View {
    
    @State private var currentNonce: String?
    
    @AppStorage("log_Status") var log_Status = false
    
    /*
     Main body:
     -Apple sign in button via SignInWithAppleButton
     -Configure Authentication requests
     -Handle sign in completion and update authentication state
     */
    var body: some View {
        SignInWithAppleButton(.continue, onRequest: { request in
            let nonce = AuthFile.randomNonceString() //calling upon a class
            currentNonce = nonce
            request.requestedScopes = [.fullName, .email]
            request.nonce = AuthFile.sha256(nonce)
            
        }, onCompletion: { result in
            switch result {
                
            case .success(let authResults):
                
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    
                    /*
                     Extract and verify teh authentication data
                     Retreive and decode the Apple ID token
                     */
                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A Login callback was received, but no login request was sent.")
                    }
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        fatalError("Invalid state: A Login callback was received, but no login request was sent.")
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    
                    let credential = OAuthProvider.appleCredential(
                        withIDToken: idTokenString,
                        rawNonce: nonce,
                        fullName: appleIDCredential.fullName
                    )
                    //sign in the user with Firebase using the Apple Credential
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if (error != nil) {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        
                        print("signged in")
                        
                        //update UI state upon successful sign in
                        withAnimation{
                            log_Status = true
                        }
                    }
                    
                    print("\(String(describing: Auth.auth().currentUser?.uid))")
                    
                default:
                    break
                        
                    }
                
            default:
                break
                    
                }
            }
        )
        //styling the button
        .font(.system(size: 20, weight: .semibold))
        .frame(width: 265, height: 64)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        )
        .padding(.horizontal)
            
        }
    }

/*
 Our utility function
 The AuthFile
 Computes a SHA-256 hash for aded security in authentication
 and creates a random nonce for Apple Authentication
 */

struct AuthFile {
    
    /*
     Generate a random string (nonce) used for authentication security
     -The nonce ensures authentation
     */
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess{
                    fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    /*
     Compute a SHA-256 hash of the input string
     */
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    
}
