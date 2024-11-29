//
//  UserSearchViewFactory.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

final class UserSearchViewFactory {
    static func makeView(viewModel: UserSearchViewModel) -> UserSearchView {
        UserSearchView(viewModel: viewModel)
    }
    
    static func makeViewModel(service: GitHubUserService) -> UserSearchViewModel {
        UserSearchViewModel(userService: service)
    }
}
