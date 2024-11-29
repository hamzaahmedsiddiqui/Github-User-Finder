//
//  UserCardView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct UserCardView: View {
    let avatarURL: String
    let name: String
    let userTag: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: avatarURL)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .shadow(radius: 5)
            
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(userTag)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
