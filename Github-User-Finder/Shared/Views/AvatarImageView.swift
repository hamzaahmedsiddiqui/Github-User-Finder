//
//  AvatarImageView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct AvatarImageView: View {
    let urlString: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image.resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .shadow(radius: 5)
        } placeholder: {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(.gray)
                .background(Circle().fill(Color.gray.opacity(0.2)))
        }
    }
}

#Preview {
    AvatarImageView(urlString: Constants.mockUser.avatarURL ?? "", size: 180)
}

