//
//  ORSeparator.swift
//  Login(Google-Apple)
//
//  Created by Mohammed Mamdouh on 10/09/2025.
//

import SwiftUI

struct ORSeparator: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.separator))
            Text("or")
                .foregroundColor(.secondary)
                .font(.subheadline)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.separator))
        }
        .padding(.horizontal)
    }
}

#Preview {
    ORSeparator()
}
