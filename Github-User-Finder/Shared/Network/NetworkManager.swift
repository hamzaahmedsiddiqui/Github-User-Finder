//
//  NetworkManager.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    // This is a generic function made for future use of other services
    
    func fetchData<T: Codable>(from endpoint: String,decodableType: T.Type, parameters: [String: String]? = nil) async throws -> T {
        var urlString = endpoint
        
        // Append query parameters if any
        if let parameters = parameters {
            let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString += "?\(queryString)"
        }
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
            
        } catch {
            throw NetworkError.invalidData(error.localizedDescription)
        }
    }
}

