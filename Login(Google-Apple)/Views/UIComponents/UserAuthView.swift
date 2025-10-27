//
//  UserAuthView.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//

import SwiftUI

struct UserAuthView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("me")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        .black.opacity(0.3),
                        .black.opacity(0.6)
                    ]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
                
               
                VStack {
                    Spacer()
                    cardContent
                        .frame(maxWidth: 340)
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
    
    private var cardContent: some View {
        VStack(spacing: 20) {
          
            VStack(spacing: 8) {
                Image("logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                Text("Let's Get Started!")
                    .font(.title3)
                    .bold()
            }
            
           
            VStack(spacing: 16) {
                LoginButtons(type: .apple)
                LoginButtons(type: .google)
                ORSeparator()
                
                NavigationLink(destination: EmailLoginView()) {
                    LoginButtons(type: .email)
                }
            }
            
          
            HStack {
                Text("Don't have an account?")
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.7))
                NavigationLink("Create An Account") {
                    SignUpView()
                }
                .foregroundStyle(.white)
                .font(.footnote)
                .fontWeight(.bold)
            }
            .padding(.bottom, 12)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.white.opacity(0.2))
        )
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 4)
    }
}

#Preview {
    UserAuthView()
}
