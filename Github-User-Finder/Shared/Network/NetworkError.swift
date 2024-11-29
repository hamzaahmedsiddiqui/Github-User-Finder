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
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case noInternetConnection
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidResponse:
            return "No valid response from the server."
        case .invalidData(let message):
            return "Decoding error: \(message)"
        case .badRequest:
            return "Bad request. The server could not process the request."
        case .unauthorized:
            return "Unauthorized access. Please check your credentials."
        case .forbidden:
            return "Forbidden access. You do not have permission to access this resource."
        case .notFound:
            return "The requested resource was not found."
        case .serverError:
            return "The server encountered an error. Please try again later."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        }
    }
}
