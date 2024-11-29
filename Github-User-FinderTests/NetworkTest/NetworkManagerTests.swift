//
//  NetworkManagerTests.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//


import XCTest
@testable import Github_User_Finder

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    func testFetchData_success() async throws {
        let mockEndpoint = mockEndpoint
        let users: User = try await networkManager.fetchData(from: mockEndpoint, decodableType: User.self)
        XCTAssertGreaterThan(users.following ?? 0, 0)
    }
}
