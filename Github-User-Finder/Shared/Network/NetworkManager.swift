//
//  NetworkManager.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import Foundation
import Network
protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(from endpoint: String,
                               decodableType: T.Type,
                               parameters: [String: String]?) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    static var shared = NetworkManager()
    private init() {}
    
    // This is a generic function made for future use of other services in future
    func fetchData<T: Codable>(from endpoint: String,
                               decodableType: T.Type,
                               parameters: [String: String]? = nil) async throws -> T {
        
        // Check network reachability first
        if !isConnectedToNetwork() {
            throw NetworkError.noInternetConnection
        }
        
        var urlString = endpoint
        
        // Append query parameters if any, for future use
        if let parameters = parameters {
            let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString += "?\(queryString)"
        }
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.invalidResponse
        }
        
        // Decode the response data into the expected type
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData(error.localizedDescription)
        }
    }
    
    // Helper method to check network reachability
    private func isConnectedToNetwork() -> Bool {
        let monitor = NWPathMonitor()
        let semaphore = DispatchSemaphore(value: 0)
        var isConnected = false
        
        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }
        
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor.start(queue: queue)
        
        semaphore.wait()  // Block the thread until the reachability check is complete
        return isConnected
    }
}
