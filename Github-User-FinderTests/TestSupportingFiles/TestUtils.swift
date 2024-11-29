//
//  TestUtils.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//



import Foundation
@testable import Github_User_Finder

class TestUtils {
    static func loadMockUser() -> User {
        let testBundle = Bundle(for: Self.self)  // Using Self for shared bundle access

        guard let url = testBundle.url(forResource: "MockUser", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("MockUser.json file not found in the test bundle")
        }

        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            fatalError("Error decoding mock user: \(error)")
        }
    }
}