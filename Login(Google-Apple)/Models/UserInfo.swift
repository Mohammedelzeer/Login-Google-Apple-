//
//  UserInfo.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 11/09/2025.
//

import FirebaseAuth

struct UserInfo {
    let uid: String
    let email: String?
    let displayName: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
}
