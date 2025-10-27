//
//  AuthenticationManger.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 11/09/2025.
//

import FirebaseAuth
import Foundation

class AuthenticationManager {
    static let shared = AuthenticationManager()

    private init() {}

    func getLoggedInUser() -> UserInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserInfo(user: user)
    }

    func createAccount(withEmail email: String, password: String, name: String) async throws -> UserInfo {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeRequest = authResult.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        return UserInfo(user: authResult.user)
    }
    
    func loginWithEmail(email: String, password: String) async throws -> UserInfo {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserInfo(user: authResult.user)
    }
}



