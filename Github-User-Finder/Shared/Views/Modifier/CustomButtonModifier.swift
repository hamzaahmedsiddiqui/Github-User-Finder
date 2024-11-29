//
//  CustomButtonModifier.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//
import SwiftUI

// Custom Button Style with Black and Gray Gradient and Shadow
struct CustomButtonModifier: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.black, .gray],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5) 
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .foregroundColor(.white)
    }
}

// View extension for applying the custom button style
extension View {
    func customButtonStyle() -> some View {
        self.buttonStyle(CustomButtonModifier())
    }
}
