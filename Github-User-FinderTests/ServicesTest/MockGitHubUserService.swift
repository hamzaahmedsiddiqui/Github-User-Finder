//
//  MockGitHubUserService.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import XCTest
import Foundation
@testable import Github_User_Finder

class MockGitHubUserService: GitHubUserServiceProtocol {
    var shouldThrowError: Bool = false
    var mockUser: User?

    func fetchUser(username: String) async throws -> User {
        if shouldThrowError || username == noUserSearchtext {
            throw NetworkError.notFound // Simulate an error (replace with actual error type if different)
        }
        
        guard let mockUser = mockUser else {
            throw NetworkError.notFound // Simulate a case where no user is returned
        }
        
        return mockUserHamza
    }
}
