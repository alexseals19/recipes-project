//
//  DefaultImageService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import Foundation

class DefaultImageService: ImageService {

    // MARK: - API
    
    func fetchImage(from url: String) async throws -> Data {
        let endpoint = URL(string: url)!
        let data = try await networkService.get(from: endpoint)
        let response: Data = try decode(data: data)
        return response
    }
    
    init(networkService: NetworkService, urlService: URLService) {
        self.networkService = networkService
        self.urlService = urlService
    }
    
    // MARK: - Properties
    
    private var networkService: NetworkService
    private var urlService: URLService
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Functions
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let value = try jsonDecoder.decode(T.self, from: data)
            return value
        } catch {
            throw AppError.decoder
        }
    }
}
