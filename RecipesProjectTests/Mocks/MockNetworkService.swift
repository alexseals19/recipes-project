//
//  MockNetworkService.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import Foundation
@testable import RecipesProject

class MockNetworkService: NetworkService {
    
    init(result: Result<Data, AppError>) {
        self.result = result
    }
    
    func get(from: URL) async throws -> Data {
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            throw error
        }
    }
    
    private let result: Result<Data, AppError>
    
}
