//
//  SearchHistoryView.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct SearchHistoryView: View {
    let searchHistory: [String]
    var onSelectItem: (String) -> Void
    var onClearHistory: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                
                VStack(spacing: 8) {
                    ForEach(searchHistory, id: \.self) { item in
                        historyItem(item: item)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Header
    private var header: some View {
        HStack {
            Text("Recent Searches")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Button(action: onClearHistory) {
                Text("Clear History")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
    }
    
    // MARK: - History Item
    private func historyItem(item: String) -> some View {
        Button(action: { onSelectItem(item) }) {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.white)
                Text(item)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.1))
            .cornerRadius(8)
        }
    }
}
