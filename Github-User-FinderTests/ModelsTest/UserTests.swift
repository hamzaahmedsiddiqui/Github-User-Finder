//
//  UserTests.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//


import XCTest
@testable import Github_User_Finder

class UserTests: XCTestCase {
    
    func testUserDecoding_validJSON() throws {
        // Load mock data
        let jsonData = """
        {
            "login": "hamza",
            "id": 123,
            "avatar_url": "https://example.com/avatar.png",
            "html_url": "https://github.com/hamza",
            "name": "Hamza Ahmed",
            "blog": "https://blog.example.com",
            "location": "Berlin",
            "email": "hamza@example.com",
            "bio": "iOS Developer",
            "public_repos": 50,
            "followers": 100,
            "following": 75
        }
        """.data(using: .utf8)!
        
        // Decode into User model
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: jsonData)
        
        XCTAssertEqual(user.userTag, "hamza")
        XCTAssertEqual(user.id, 123)
        XCTAssertEqual(user.avatarURL, "https://example.com/avatar.png")
        XCTAssertEqual(user.htmlURL, "https://github.com/hamza")
        XCTAssertEqual(user.name, "Hamza Ahmed")
        XCTAssertEqual(user.blog, "https://blog.example.com")
        XCTAssertEqual(user.location, "Berlin")
        XCTAssertEqual(user.bio, "iOS Developer")
        XCTAssertEqual(user.publicRepos, 50)
        XCTAssertEqual(user.followers, 100)
        XCTAssertEqual(user.following, 75)
    }
    
    func testUserDecoding_missingFields() throws {
        let jsonData = """
        {
            "login": "hamza",
            "html_url": "https://github.com/hamza"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: jsonData)
        
        XCTAssertEqual(user.userTag, "hamza")
        XCTAssertNil(user.name)
        XCTAssertEqual(user.htmlURL, "https://github.com/hamza")
    }
}