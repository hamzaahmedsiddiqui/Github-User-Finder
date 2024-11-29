//
//  UserDetailViewModelTests.swift
//  Github-User-FinderTests
//
//  Created by hamza Ahmed on 2024-11-29.
//

import XCTest
@testable import Github_User_Finder

final class UserDetailViewModelTests: XCTestCase {
  var viewModel: UserDetailViewModel!
  var mockUser: User!

  override func setUp() {
    super.setUp()
    // Initialize mock user data
    mockUser = testUser
      
    // Initialize the view model with the mock user
    viewModel = UserDetailViewModel(user: mockUser)
  }

  override func tearDown() {
    // Clean up after each test
    viewModel = nil
    mockUser = nil
    super.tearDown()
  }

  func testInitialization() {
    // Then
    XCTAssertEqual(viewModel.state.name, mockUser.name)
    XCTAssertEqual(viewModel.state.userTag, mockUser.userTag)
    XCTAssertEqual(viewModel.state.avatar, mockUser.avatarURL)
    XCTAssertEqual(viewModel.state.bio, mockUser.bio)
    XCTAssertEqual(viewModel.state.location, mockUser.location)
    XCTAssertEqual(viewModel.state.followers, mockUser.followers)
    XCTAssertEqual(viewModel.state.following, mockUser.following)
    XCTAssertEqual(viewModel.state.repositoryCount, mockUser.publicRepos)
    XCTAssertEqual(viewModel.state.profileURL, mockUser.htmlURL)
    XCTAssertEqual(viewModel.state.blogURL, mockUser.blog)
  }

  func testInitializationWithNilValues() {
    // Given
    let userWithNilValues = User(
      userTag: "niluser",
      id: nil,
      avatarURL: nil,
      htmlURL: "https://github.com/niluser",
      name: nil,
      blog: "",
      location: nil,
      email: nil,
      bio: nil,
      publicRepos: nil,
      followers: nil,
      following: nil
    )
    // When
    let viewModelWithNilValues = UserDetailViewModel(user: userWithNilValues)

    // Then
    XCTAssertNil(viewModelWithNilValues.state.name)
    XCTAssertEqual(viewModelWithNilValues.state.userTag, userWithNilValues.userTag)
    XCTAssertNil(viewModelWithNilValues.state.avatar)
    XCTAssertNil(viewModelWithNilValues.state.bio)
    XCTAssertNil(viewModelWithNilValues.state.location)
    XCTAssertNil(viewModelWithNilValues.state.followers)
    XCTAssertNil(viewModelWithNilValues.state.following)
    XCTAssertNil(viewModelWithNilValues.state.repositoryCount)
    XCTAssertEqual(viewModelWithNilValues.state.profileURL, userWithNilValues.htmlURL)
    XCTAssertEqual(viewModelWithNilValues.state.blogURL, userWithNilValues.blog)
  }
}
