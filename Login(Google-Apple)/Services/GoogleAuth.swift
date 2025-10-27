//
//  GoogleAuth.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 14/09/2025.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInButtonView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    /*
     Main body
     -The button for google sign in
     - We will have a google logo image
     - Text: Continue with Google
     - Style with padding, rounded corners, a border, and shadow
     */
    var body: some View {
        Button(action: handleSignIn) {
            HStack {
                Image("google_logo")
                    .resizable()
                    .frame(width: 24, height: 25)
                
                Text("Continue with Google")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 265, height: 64)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
    /*
     Retrueve the root view controller for Google Sign in UI Representation
     Fetches the firebase client ID
     Configures Google Sign In
     Updates log Status
     */
    private func handleSignIn (){
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("ERROR: No root view controller found")
            return
        }
        
        //retrieve teh firebase client id
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("ERROR; Could not retrieve Client ID from Firebase")
            return
        }
        
        //Configure google sign in with client id
        let config = GIDConfiguration(clientID:  clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //Initiate the Google Sign-In flow, present the UI on the root view controller
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            
            //handle errors during the sign in process
            if let error = error {
                print("Google Sign In Error: \(error.localizedDescription)")
                return
            }
            
            //extract user authentication info
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else {
                print("ERROR: No ID token received")
                return
            }
            
            //create a firebase authentication ccredential
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            //sign in the user to firebase with the generated credential
            Auth.auth().signIn(with: credential) { authResult, error in
                
                //handle errors when signing in
                if let error = error {
                    print("Firebase authentication error: \(error.localizedDescription)")
                    return
                }
                
                //retrueve and log the authenticated user's name (if its aaialbe
                guard let user = authResult?.user else { return }
                print("user signed in: \(user.displayName ?? "Unknown")")
                
                log_Status = true
                
            }
        }
        
    }
}
