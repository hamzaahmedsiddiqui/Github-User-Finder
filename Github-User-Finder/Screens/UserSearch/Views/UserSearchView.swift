//
//  UserSearchView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct UserSearchView: View {
  @State private var searchText: String = ""
  @FocusState private var isTextFieldFocused: Bool
  @StateObject var viewModel: UserSearchViewModel

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        title
        searchView
        userCardView
        historyView
        Spacer()
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
      )
      .animation(.easeInOut, value: viewModel.state.userTag)
      .alert(isPresented: $viewModel.state.showAlert) {
        Alert(
          title: Text("Error"),
          message: Text(viewModel.state.errorMessage),
          dismissButton: .default(Text("OK"))
        )
      }
    }
  }

  private var title: some View {
    Text("GitHub User Finder")
      .font(.largeTitle)
      .fontWeight(.bold)
      .foregroundColor(.white)
      .shadow(radius: 5)
  }

  private func clearSearch() {
    searchText.removeAll()
  }

  @ViewBuilder
  private var historyView: some View {
    if !viewModel.state.searchHistory.isEmpty {
        SearchHistoryView(
        searchHistory: viewModel.state.searchHistory,
        onSelectItem: { item in
          searchText = item
          viewModel.trigger(.search(username: item))
        },
        onClearHistory: {
          viewModel.trigger(.didTapOnClearHistory)
        }
      )
      .transition(.opacity)
    }
  }

  @ViewBuilder
  private var userCardView: some View {
    if let vm = viewModel.state.userDetailViewModel {
      NavigationLink(
        destination: UserDetailView(viewModel: vm),
        label: {
          UserCardView(
            avatarURL: viewModel.state.avatar,
            name: viewModel.state.name,
            userTag: viewModel.state.userTag
          )
        }
      )
      .buttonStyle(PlainButtonStyle())
      .transition(.move(edge: .bottom))
    }
  }

  private var searchButton: some View {
    Text("Search")
      .fontWeight(.semibold)
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .padding()
      .background(LinearGradient(
        gradient: Gradient(colors: [.purple, .blue]),
        startPoint: .leading,
        endPoint: .trailing
      ))
      .cornerRadius(8)
      .shadow(radius: 5)
  }

  private var searchBar: some View {
    SearchBar(
      searchText: $searchText,
      isTextFieldFocused: _isTextFieldFocused,
      onSubmit: {
        viewModel.trigger(.search(username: searchText))
      },
      clearSearch: clearSearch
    )
  }

  private var searchView: some View {
    VStack {
      searchBar
      searchButton
        .onTapGesture {
          viewModel.trigger(.search(username: searchText))
        }
    }
  }
}

//#Preview {
//  UserSearchView()
//}
