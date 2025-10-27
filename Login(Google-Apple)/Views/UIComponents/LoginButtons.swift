//
//  LoginButtons.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//

//import SwiftUI
//import AuthenticationServices
//struct LoginButtons: View {
//    var type: LoginType
//    var body: some View {
//        switch type {
//        case.apple:
//            SignInWithAppleButton(.continue, onRequest: { _ in} , onCompletion: { _ in})
//                .signInWithAppleButtonStyle(.white)
//                .frame(height: 50)
//                .cornerRadius(8)
//                .padding(.horizontal)
//            
//            case .google:
//            Button {
//                
//            } label: {
//                HStack {
//                    Image("google")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 18, height: 18)
//                    Text(type.title)
//                        .font(Font.system(size: 17, weight: .medium))
//                        .foregroundColor(.black)
//                }
//                .frame(maxWidth: .infinity, minHeight: 50)
//                .padding(.horizontal, 16)
//                .background(.white)
//                .cornerRadius(8)
//                .padding(.horizontal)
//            }
//            
//        case.email:
//            Button{
//                
//            } label: {
//                
//            }
//            HStack(spacing: 10) {
//                Image(systemName: type.iconName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 18, height: 18)
//                    .foregroundColor(.white)
//                Text(type.title)
//                    .font(Font.system(size: 17, weight: .medium))
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity, minHeight: 50)
//            .padding(.horizontal, 16)
//            .background(.red)
//            .cornerRadius(8)
//            .padding(.horizontal)
//        }
//    }
//}
//
//#Preview {
//    LoginButtons(type: .email)
//}



import SwiftUI
import AuthenticationServices
import FirebaseAuth
import Firebase
import GoogleSignIn

struct LoginButtons: View {
    var type: LoginType
    @AppStorage("log_Status") var log_Status = false

    var body: some View {
        switch type {
        case .apple:
            SignInWithAppleButton(.continue, onRequest: { _ in }, onCompletion: { _ in })
                .signInWithAppleButtonStyle(.white)
                .frame(height: 50)
                .cornerRadius(8)
                .padding(.horizontal)

        case .google:
            Button {
                handleGoogleSignIn()
            } label: {
                HStack {
                    Image("google")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    Text(type.title)
                        .font(Font.system(size: 17, weight: .medium))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.horizontal, 16)
                .background(.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }

        case .email:
            NavigationLink {
                EmailLoginView()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: type.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                    Text(type.title)
                        .font(Font.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.horizontal, 16)
                .background(.red)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Google Sign In
    private func handleGoogleSignIn() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("ERROR: No root view controller found")
            return
        }

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("ERROR: Could not retrieve Client ID from Firebase")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google Sign In Error: \(error.localizedDescription)")
                return
            }

            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else {
                print("ERROR: No ID token received")
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase authentication error: \(error.localizedDescription)")
                    return
                }

                guard let user = authResult?.user else { return }
                print("✅ User signed in: \(user.displayName ?? "Unknown")")

                log_Status = true
            }
        }
    }
}
