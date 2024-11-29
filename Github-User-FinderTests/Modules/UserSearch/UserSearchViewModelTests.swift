//
//  UserSearchViewModelTests.swift
//  Github-User-FinderTests
//
//  Created by hamza Ahmed on 2024-11-29.
//

import XCTest
import Combine
@testable import Github_User_Finder

final class UserSearchViewModelTests: XCTestCase {
  var viewModel: UserSearchViewModel!
  var mockUserService: MockGitHubUserService!
  var cancellables: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    // Initialize the mock service and view model before each test
    mockUserService = MockGitHubUserService()
    viewModel = UserSearchViewModel(userService: mockUserService)
  }

  override func tearDown() {
    viewModel = nil
    mockUserService = nil
    cancellables.removeAll()

    super.tearDown()
  }

  func test_fetchUser_withSuccess() {
    // Given
    mockUserService.shouldThrowError = false
    let username = "hamzaahmedsiddiqui"
    let expectation = self.expectation(description: "FetchUserSuccess")

    // Observe the state changes
    viewModel.$state
      .dropFirst()
      .first(where: { state in
        state.name == "Hamza Ahmed Siddiqui"
      })
      .sink { _ in
        expectation.fulfill()
      }
      .store(in: &cancellables)

    // When
    viewModel.trigger(.search(username: username))

    // Then
    wait(for: [expectation], timeout: 2.0)

    XCTAssertEqual(viewModel.state.name, "Hamza Ahmed Siddiqui")
    XCTAssertEqual(viewModel.state.userTag, "hamzaahmedsiddiqui")
  }

  func test_fetchUser_withFailure() {
    // Given
    mockUserService.shouldThrowError = true
    let username = "invaliduser"
    let expectation = self.expectation(description: "FetchUserFailure")

    // Observe the state changes
    viewModel.$state
      .dropFirst()
      .first(where: { state in
        state.showAlert == true
      })
      .sink { _ in
        expectation.fulfill()
      }
      .store(in: &cancellables)

    // When
    viewModel.trigger(.search(username: username))

    // Then
    wait(for: [expectation], timeout: 2.0)

    XCTAssertEqual(viewModel.state.name, "")
    XCTAssertEqual(viewModel.state.userTag, "")
    XCTAssertEqual(viewModel.state.avatar, "")
    XCTAssertNil(viewModel.state.userDetailViewModel)
    XCTAssertTrue(viewModel.state.showAlert)
    XCTAssertEqual(viewModel.state.errorMessage, NetworkError.invalidURL.errorDescription)
  }

  func test_clearHistoryAction_didClearUsers_FromUserDefaults() {
    // Given
    viewModel.state.searchHistory = ["user1", "user2", "user3"]

    // When
    viewModel.trigger(.didTapOnClearHistory)

    // Then
    XCTAssertTrue(viewModel.state.searchHistory.isEmpty)
    let savedHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String]
    XCTAssertNil(savedHistory)
  }

  func test_searchEmptyUsername_throwsAlert() {
    // Given
    let username = ""

    // When
    viewModel.trigger(.search(username: username))

    // Then
    XCTAssertTrue(viewModel.state.showAlert)
    XCTAssertEqual(viewModel.state.errorMessage, "Kindly write username to search")
  }

  func test_saveSearchHistory_didSaveUser() {
    // Given
    let username = "newuser"
    viewModel.state.searchHistory = ["existinguser"]

    // When
    viewModel.trigger(.search(username: username))

    // Wait for async operation
    let expectation = self.expectation(description: "SaveSearchHistory")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 2.0)

    // Then
    XCTAssertTrue(viewModel.state.searchHistory.contains(username))
  }

  func test_duplicateSearchHistory_didNot_saveUser() {
    // Given
    let username = "duplicateuser"
    viewModel.state.searchHistory = [username]

    // When
    viewModel.trigger(.search(username: username))

    // Wait for async operation
    let expectation = self.expectation(description: "DuplicateSearchHistory")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 2.0)

    // Then
    XCTAssertEqual(viewModel.state.searchHistory.filter { $0 == username }.count, 1)
  }
}
