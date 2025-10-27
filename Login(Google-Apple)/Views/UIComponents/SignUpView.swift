//
//  SignUpView.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//

import SwiftUI

struct SignUpView: View {
    @State var signUpViewModel = SignUpViewModel()
    var body: some View {
        VStack {
            Text("Create An Account")
                .font(.title)
                .fontWeight(.bold)
            
            Group {
                TextField("Name", text: $signUpViewModel.name)
                TextField("Email", text: $signUpViewModel.email)
                SecureField("Password", text: $signUpViewModel.password)
                SecureField("Confirm Password", text: $signUpViewModel.confirmPassword)
            }
            .textFieldStyle()
            
            Button {
                Task {
                    if let user = await
                        signUpViewModel.signUpWithEmail() {
                        print("User Signed Up Successfully: \(user)")
                    }
                }
            } label: {
                Text("Create An Account")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
                Spacer()
            }
        }
    }



#Preview {
    SignUpView()
}
