//
//  Github_User_FinderApp.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

@main
struct Github_User_FinderApp: App {
    var body: some Scene {
        WindowGroup {
            userSearchView
        }
    }
    
    private var userSearchView: some View {
        let viewModel = UserSearchViewFactory.makeViewModel(service: GitHubUserService())
        return UserSearchViewFactory.makeView(viewModel: viewModel)
    }
}
