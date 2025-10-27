//
//  EmailLoginViewModel.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 11/09/2025.
//

import SwiftUI

@MainActor
@Observable
final class EmailLoginViewModel {
    var email: String = ""
    var password: String = ""
    
    
    func loginWithEmail() async -> UserInfo? {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        do {
            let user = try await AuthenticationManager.shared.loginWithEmail(email: email, password: password)
            return user
            
        } catch {
            print("Error: \(error)")
        }
        
        return nil

    }
}
