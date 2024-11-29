//
//  CustomButtonModifier.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

// Custom Button Style
struct CustomButtonModifier: ButtonStyle {
    var bgColor: Color = .teal
    var textColor: Color = .white
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ?
                Capsule()
                    .stroke(.gray, lineWidth: 1) :
                nil
            }
    }
}

extension View {
    func customButtonStyle(bgColor: Color = .teal, textColor: Color = .white, hasBorder: Bool = false) -> some View {
        self.buttonStyle(CustomButtonModifier(bgColor: bgColor, textColor: textColor, hasBorder: hasBorder))
    }
}
