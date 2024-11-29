//
//  stub.swift
//  DemoChallengeTests
//
//  Created by hamza Ahmed on 2024-11-28.
//

import Foundation


@testable import Github_User_Finder

let ViewModelError = "ViewModel cannot be instantiated."
let mockEndpoint = "https://api.github.com/users/hamzaahmedsiddiqui"
let noUserSearchtext = "possssd"
let userExsistSearchtext = "hamzaahmedsiddiqui"
let mockUser = User(
  userTag: "hamzaahmedsiddiqui",
  id: 38706039,
  avatarURL: "https://avatars.githubusercontent.com/u/38706039?v=4",
  htmlURL: "https://avatars.githubusercontent.com/u/38706039?v=4",
  name: "Hello World",
  blog: "Berlin, Germany",
  location: "https://www.linkedin.com/in/hamza-ahmed-siddiqui-80838999/",
  email: "abc@gmail.com",
  bio: "Hello this is bio",
  publicRepos: 0,
  followers: 3,
  following: 0
)
let testUser = User(
  userTag: "testuser",
  id: 123456,
  avatarURL: "https://example.com/avatar.png",
  htmlURL: "https://github.com/testuser",
  name: "Test User",
  blog: "https://testuserblog.com",
  location: "Test City",
  email: "testuser@example.com",
  bio: "This is a test bio.",
  publicRepos: 42,
  followers: 100,
  following: 50
)
