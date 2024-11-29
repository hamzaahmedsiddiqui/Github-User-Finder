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
      VStack(alignment: .leading) {
        HStack {
          Text("Recent Searches")
            .font(.headline)
            .foregroundColor(.white)
          Spacer()
          Button(action: onClearHistory) {
            Text("Clear")
              .font(.subheadline)
              .foregroundColor(.red)
          }
        }
        .padding(.horizontal)

        ForEach(searchHistory, id: \.self) { item in
          Button(action: {
            onSelectItem(item)
          }) {
            HStack {
              Image(systemName: "clock.fill")
                .foregroundColor(.white)
              Text(item)
                .foregroundColor(.white)
              Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
          }
          .background(Color.white.opacity(0.1))
          .cornerRadius(8)
          .padding(.horizontal)
        }
      }
      .padding(.vertical)
    }
  }
