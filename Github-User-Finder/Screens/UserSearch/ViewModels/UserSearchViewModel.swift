//
//  UserSearchViewModel.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

struct UserSearchViewState {
  var name: String = ""
  var userTag: String = ""
  var avatar: String = ""
  var errorMessage: String = ""
  var showAlert: Bool = false
  var searchHistory: [String] = []
  var userDetailViewModel: UserDetailViewModel?
}

enum UserSearchViewAction {
  case search(username: String)
  case didTapCard
  case didTapOnClearHistory
}

class UserSearchViewModel: ObservableObject {
  @Published var state: UserSearchViewState
  private var userService: GitHubUserServiceProtocol

  init(userService: GitHubUserServiceProtocol) {
    self.userService = userService
    self.state = UserSearchViewState()

    loadSearchHistory()
  }

  func trigger(_ action: UserSearchViewAction) {
    switch action {
    case .search(let username):
      fetchUser(searchText: username)
    case.didTapCard:
      print("open detail view")
    case .didTapOnClearHistory:
      clearHistory()
    }
  }


  // Function to load the search history
  private func loadSearchHistory() {
    if let savedHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] {
      state.searchHistory = savedHistory
    }
  }

  // Function to save search history
  private func saveSearchHistory(searchText: String) {
    if !state.searchHistory.contains(searchText) {
      state.searchHistory.append(searchText)
      UserDefaults.standard.set(state.searchHistory, forKey: "SearchHistory")
    }
  }
  
  // Function to clear the search history
  private func clearHistory() {
    state.searchHistory.removeAll()
    UserDefaults.standard.removeObject(forKey: "SearchHistory")
  }

  // Function to fetch User by username
  private func fetchUser(searchText: String) {
    if searchText != "" {
      Task {
        do {
          let fetchedUser = try await userService.fetchUser(username: searchText)
          await MainActor.run {
            setUser(user: fetchedUser)
            saveSearchHistory(searchText: searchText)
          }
        } catch let error as NetworkError {
          await MainActor.run {
            resetUserState()
            saveSearchHistory(searchText: searchText)
            state.showAlert = true
            state.errorMessage = error.errorDescription
          }
        }
      }
    } else {
      state.showAlert = true
      state.errorMessage = "Kindly write username to search"
    }
  }

  private func setUser(user: User) {
    self.state.name = user.name ?? ""
    self.state.userTag = user.userTag
    self.state.avatar = user.avatarURL ?? ""
    self.state.userDetailViewModel = UserDetailViewModel(user: user)
  }

  private func resetUserState() {
    self.state.name = ""
    self.state.userTag = ""
    self.state.avatar = ""
    self.state.userDetailViewModel = nil
  }
}
