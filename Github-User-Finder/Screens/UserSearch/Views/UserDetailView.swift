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
      VStack {
        imageView
        descriptionView
        repositoryDescriptionView
        blogCTAView
        profileCTAView
      }
    }
    .padding(.vertical, .padding)
    .background {
      BackgroundView()
    }
    .navigationTitle("User Details")
    .toolbarRole(.editor)
  }

  @ViewBuilder
  private var imageView: some View {
    if let avatarURL = viewModel.state.avatar {
      AvatarImageView(urlString: avatarURL, size: 180)
    }
  }

  private var descriptionView: some View {
    VStack(alignment: .leading, spacing: .padding) {
      if let name = viewModel.state.name {
        Text(name)
          .multilineTextAlignment(.leading)
          .customTextStyle(
            font: .system(
              size: 30,
              weight: .bold
            ),
            foregroundColor: .primary
          )
      }

      Text(viewModel.state.userTag)
        .customTextStyle(
          font: .title2,
          foregroundColor: .black
        )

      if let description = viewModel.state.description {
        Text(description)
          .customTextStyle(
            font: .body,
            foregroundColor: .secondary
          )
      }

      if let locationDescription = viewModel.state.location {
        HStack {
          Image(systemName: "mappin.and.ellipse")
            .foregroundColor(.blue)
          Text(locationDescription)
            .customTextStyle(
              font: .body,
              foregroundColor: .secondary
            )
        }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .padding(.padding)

  }

  private var repositoryDescriptionView: some View {
    VStack(spacing: .padding) {
      HStack {
        Text("Repositories: \(viewModel.state.repositoryCount ?? 0)")
        Text("Followers: \(viewModel.state.followers ?? 0)")
        Text("Following: \(viewModel.state.following ?? 0)")
      }
      .customTextStyle(font: .body, foregroundColor: .primary)
      .foregroundColor(.primary)
      .padding(.padding)
    }
    .frame(alignment: .leading)
  }

  @ViewBuilder
  private var profileCTAView: some View {
    if let url = URL(string: viewModel.state.profileURL ?? "") {
      ctaView(description: "View Profile on GitHub", url: url)
    }
  }

  @ViewBuilder
  private var blogCTAView: some View {
    if let url = URL(string: viewModel.state.blogURL ?? "") {
      ctaView(description: "View Profile on GitHub", url: url)
    }
  }

  private func ctaView(description: String, url: URL) -> some View {
    Link(description, destination: url)
      .font(.body)
      .foregroundColor(.blue)
      .customButtonStyle()
      .padding(.padding)
  }
}


fileprivate extension CGFloat {
  static let padding: CGFloat = 8
}
