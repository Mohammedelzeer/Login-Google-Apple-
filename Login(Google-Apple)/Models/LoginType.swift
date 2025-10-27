//
//  LoginType.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//

public enum LoginType: String {
    case email
    case apple
    case google
    
    var iconName: String {
        switch self {
        case .email:
            return "envelope"
        case .apple:
            return "apple"
        case .google:
            return "google"
        }
    }
    
    var title: String {
        switch self {
        case .email:
            return "Continue with Email"
        case .apple:
            return "Continue with Apple"
        case .google:
            return "Continue with Google"
        }
    }
}
