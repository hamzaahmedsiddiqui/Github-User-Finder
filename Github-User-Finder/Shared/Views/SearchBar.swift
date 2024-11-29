//
//  SearchBar.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var isTextFieldFocused: Bool
    var onSubmit: () -> Void
    var clearSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search GitHub users...", text: $searchText)
                .padding(12)
                .padding(.horizontal, 25)
                .background(Color.white.opacity(0.9))
                .cornerRadius(8)
                .shadow(radius: 3)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: clearSearch) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .focused($isTextFieldFocused)
                .onSubmit {
                    onSubmit()
                }
        }
    }
}
