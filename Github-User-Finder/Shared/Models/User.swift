//
//  User.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

struct User: Identifiable, Codable {
  let userTag: String
  let id: Int?
  let avatarURL: String?
  let htmlURL: String
  let name: String?
  let blog: String
  let location: String?
  let email: String?
  let bio: String?
  let publicRepos, followers, following: Int?

  enum CodingKeys: String, CodingKey {
    case userTag = "login"
    case id
    case avatarURL = "avatar_url"
    case name, blog, location, email, bio
    case publicRepos = "public_repos"
    case followers, following
    case htmlURL = "html_url"
  }
}

