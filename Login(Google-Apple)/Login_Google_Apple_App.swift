//
//  Login_Google_Apple_App.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//
//
//import SwiftUI
//import FirebaseCore
//import GoogleSignIn
//
//
//
//@main
//struct Login_Google_Apple_App: App {
//    init() {
//        FirebaseApp.configure()        
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            UserAuthView()
//        }
//    }
//}
//


import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
struct Login_Google_Apple_App: App {
    @AppStorage("log_Status") var log_Status = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if log_Status {
                // هنا الصفحة اللي يدخل عليها المستخدم بعد تسجيل الدخول
                ContentView()
            } else {
                // شاشة تسجيل الدخول
                UserAuthView()
            }
        }
    }
}
