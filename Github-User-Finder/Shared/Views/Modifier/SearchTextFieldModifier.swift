//
//  SearchTextFieldModifier.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct SearchTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .textInputAutocapitalization(.none)
            .disableAutocorrection(true)
            .keyboardType(.webSearch)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
