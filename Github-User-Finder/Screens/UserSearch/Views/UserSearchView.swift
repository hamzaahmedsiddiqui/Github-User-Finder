//
//  UserSearchView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    @StateObject var viewModel: UserSearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                title
                searchSection
                userCardSection
                historySection
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
            .animation(.easeInOut, value: viewModel.state.userTag)
            .alert("Error", isPresented: $viewModel.state.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.state.errorMessage)
            }
        }
    }
    
    // MARK: - Title
    private var title: some View {
        Text("GitHub User Finder")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .shadow(radius: 5)
    }
    
    // MARK: - Search Section
    private var searchSection: some View {
        VStack(spacing: 8) {
            searchBar
            searchButton
        }
    }
    
    private var searchBar: some View {
        SearchBar(
            searchText: $searchText,
            isTextFieldFocused: _isTextFieldFocused,
            onSubmit: { viewModel.trigger(.search(username: searchText)) },
            clearSearch: { searchText.removeAll() }
        )
    }
    
    private var searchButton: some View {
        Button("Search") {
            viewModel.trigger(.search(username: searchText))
        }
        .customButtonStyle()
    }
    
    // MARK: - User Card Section
    @ViewBuilder
    private var userCardSection: some View {
        if let vm = viewModel.state.userDetailViewModel {
            NavigationLink(destination: UserDetailView(viewModel: vm)) {
                UserCardView(
                    avatarURL: viewModel.state.avatar,
                    name: viewModel.state.name,
                    userTag: viewModel.state.userTag
                )
            }
            .buttonStyle(PlainButtonStyle())
            .transition(.move(edge: .bottom))
        }
    }
    
    // MARK: - History Section
    @ViewBuilder
    private var historySection: some View {
        if !viewModel.state.searchHistory.isEmpty {
            SearchHistoryView(
                searchHistory: viewModel.state.searchHistory,
                onSelectItem: { item in
                    searchText = item
                    viewModel.trigger(.search(username: item))
                },
                onClearHistory: { viewModel.trigger(.didTapOnClearHistory) }
            )
            .transition(.opacity)
        }
    }
}

