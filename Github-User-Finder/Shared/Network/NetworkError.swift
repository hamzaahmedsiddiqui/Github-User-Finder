//
//  NetworkError.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

enum NetworkError: Error, LocalizedError {
  case invalidURL
  case invalidResponse
  case invalidData(String)

  var errorDescription: String {
    switch self {
    case .invalidURL:
      return "The URL provided was invalid."
    case .invalidResponse:
      return "No User found"
    case .invalidData(let message):
      return "Decoding error: \(message)"
    }
  }
}
