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

final class UserSearchViewModel: ObservableObject {
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
    
    
    
    // MARK: - Search History
    
    private func loadSearchHistory() {
        if let savedHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] {
            state.searchHistory = savedHistory
        }
    }
    
    private func saveSearchHistory(searchText: String) {
        guard !state.searchHistory.contains(searchText) else { return }
        state.searchHistory.append(searchText)
        UserDefaults.standard.set(state.searchHistory, forKey: "SearchHistory")
    }
    
    private func clearHistory() {
        state.searchHistory.removeAll()
        UserDefaults.standard.removeObject(forKey: "SearchHistory")
    }
    
    
    // MARK: - User Fetching
    private func fetchUser(searchText: String) {
        if searchText != "" {
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let fetchedUser = try await self.userService.fetchUser(username: searchText)
                    await MainActor.run {
                        self.setUser(user: fetchedUser)
                        self.saveSearchHistory(searchText: searchText)
                    }
                } catch let error as NetworkError {
                    await MainActor.run {
                        self.resetUserState()
                        self.saveSearchHistory(searchText: searchText) // might make sense to save history only on successful fetches but as per requirement it is saving 
                        self.state.showAlert = true
                        self.state.errorMessage = error.errorDescription
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
        self.state = UserSearchViewState()
    }
}
