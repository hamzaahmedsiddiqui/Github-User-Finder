//
//  GitHubUserService.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation


protocol GitHubUserServiceProtocol {
    func fetchUser(username: String) async throws -> User
}

class GitHubUserService: GitHubUserServiceProtocol {
    func fetchUser(username: String) async throws -> User {
        let endpoint = Constants.baseURL + Constants.getUserEndpoint + username
        return try await NetworkManager.shared.fetchData(from: endpoint, decodableType: User.self)
    }
}
