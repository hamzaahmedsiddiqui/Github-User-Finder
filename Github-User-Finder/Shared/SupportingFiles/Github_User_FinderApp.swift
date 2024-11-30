//
//  Github_User_FinderApp.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

@main
struct Github_User_FinderApp: App {
    @StateObject private var viewModel = UserSearchViewFactory.createViewModel(service: GitHubUserService())
    // @stateObject wrapper is used here because it won’t recreate the viewModel every time the view is updated
    var body: some Scene {
        WindowGroup {
            UserSearchViewFactory.createView(viewModel: viewModel)
        }
    }
}
