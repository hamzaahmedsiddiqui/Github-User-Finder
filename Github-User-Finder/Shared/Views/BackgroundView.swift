//
//  BackgroundView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct BackgroundView: View {
    var firstColor: Color = .purple
    var secondColor: Color = .blue
    var startPoint: UnitPoint = .topLeading
    var endPoint: UnitPoint = .trailing
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [firstColor, secondColor]),
            startPoint: startPoint,
            endPoint:endPoint
        ).ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
