//
//  DefaultNetworkService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

class DefaultNetworkService: NetworkService {
    
    // MARK: - API
    
    func get(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(from: url, delegate: nil)
            try verify(response: response)
            return data
        } catch {
            if let error = error as? AppError, error == .invalidResponse {
                throw error
            } else {
                throw AppError.network
            }
        }
    }
    
    init(urlSession: URLSessionAPI) {
        self.urlSession = urlSession
    }
    
    // MARK: - Constants
    
    private let httpOk = 200...299
    
    // MARK: - Properties
    
    private var urlSession: URLSessionAPI
        
    // MARK: - Functions
    
    private func verify(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpOk.contains(httpResponse.statusCode) else {
            throw AppError.invalidResponse
        }
    }
}
