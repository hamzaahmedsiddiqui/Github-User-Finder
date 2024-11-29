//
//  UserDetailView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject var viewModel: UserDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: .padding) {
                imageView
                descriptionView
                repositoryDescriptionView
                blogCTAView
                profileCTAView
            }
        }
        .padding(.vertical, .padding)
        .background(BackgroundView())
        .navigationTitle("User Details")
        .toolbarRole(.editor)
    }
    
    // MARK: - Image View
    @ViewBuilder
    private var imageView: some View {
        if let avatarURL = viewModel.state.avatar {
            AvatarImageView(urlString: avatarURL, size: 180)
        }
    }
    
    // MARK: - Description View
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: .padding) {
            if let name = viewModel.state.name {
                Text(name)
                    .multilineTextAlignment(.leading)
                    .customTextStyle(
                        font: .system(size: 30, weight: .bold),
                        foregroundColor: .primary
                    )
            }
            
            Text(viewModel.state.userTag)
                .customTextStyle(font: .title2, foregroundColor: .black)
            
            if let bio = viewModel.state.bio {
                Text(bio)
                    .customTextStyle(font: .body, foregroundColor: .black)
            }
            
            if let location = viewModel.state.location {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.black)
                    Text(location)
                        .customTextStyle(font: .body, foregroundColor: .primary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.padding)
    }
    
    // MARK: - Repository Description View
    private var repositoryDescriptionView: some View {
        HStack(spacing: .padding) {
            Text("Repositories: \(viewModel.state.repositoryCount ?? 0)")
            Text("Followers: \(viewModel.state.followers ?? 0)")
            Text("Following: \(viewModel.state.following ?? 0)")
        }
        .customTextStyle(font: .body, foregroundColor: .primary)
    }
    
    // MARK: - CTA Views
    @ViewBuilder
    private var profileCTAView: some View {
        if let url = URL(string: viewModel.state.profileURL ?? "") {
            ctaView(description: "View Profile on GitHub", url: url, systemImage: "person.circle")
        }
    }
    
    @ViewBuilder
    private var blogCTAView: some View {
        if let blogURL = viewModel.state.blogURL, let url = URL(string: blogURL) {
            ctaView(description: "Visit Blog", url: url, systemImage: "link")
        }
    }
    
    private func ctaView(description: String, url: URL, systemImage: String) -> some View {
        Link(destination: url) {
            Label(description, systemImage: systemImage)
                .font(.body)
                .foregroundColor(.white)
                .customButtonStyle()
        }
    }
}

// MARK: - Constants
fileprivate extension CGFloat {
    static let padding: CGFloat = 8
}
