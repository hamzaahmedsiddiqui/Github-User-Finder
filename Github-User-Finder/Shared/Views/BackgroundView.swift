//
//  BackgroundView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.teal, Color(UIColor.systemGray2)]),
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
