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
let mockUserHamza = User(
    userTag: "hamzaahmedsiddiqui",
    id: 38706039,
    avatarURL: "https://avatars.githubusercontent.com/u/38706039?v=4",
    htmlURL: "https://github.com/hamzaahmedsiddiqui",
    name: "Hamza Ahmed Siddiqui",
    blog: "https://www.linkedin.com/in/hamza-ahmed-siddiqui-80838999/",
    location: "Berlin, Germany",
    email: nil,
    bio: "I am an iOS Developer with a Master's degree in Computer Science and over 4 years of experience in software development.",
    publicRepos: 10,
    followers: 0,
    following: 3
)
