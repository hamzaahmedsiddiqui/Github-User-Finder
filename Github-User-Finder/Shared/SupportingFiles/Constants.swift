//
//  Constants.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.github.com/"
    static let getUserEndpoint = "users/"
    static let searchHistoryKey = "SearchHistory"
    static let mockSearchHistoryKey = "MockSearchHistory"

    static let mockUser = User(
        userTag: "hamzaahmedsiddiqui",
        id: 38706039,
        avatarURL: "Hamza Ahmed Siddiqui",
        htmlURL: "https://avatars.githubusercontent.com/u/38706039?v=4",
        name: "I am an iOS Developer with a Master's degree in Computer Science and over 4 years of experience in software development.",
        blog: "Berlin, Germany",
        location: "https://www.linkedin.com/in/hamza-ahmed-siddiqui-80838999/",
        email: "abc@gmail.com",
        bio: "no bio",
        publicRepos: 0,
        followers: 3,
        following: 0
    )
}
