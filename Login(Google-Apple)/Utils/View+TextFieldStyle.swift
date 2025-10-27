//
//  View+TextFieldStyle.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//


import SwiftUI

extension View {
    func textFieldStyle() -> some View {
        self.padding()
            .background(.secondary.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
