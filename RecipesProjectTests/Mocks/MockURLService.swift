//
//  MockURLService.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import Foundation
@testable import RecipesProject

class MockURLService: URLService {
    
    init(result: Result<URL, Error>) {
        self.result = result
    }
    
    func makeURL() throws -> URL {
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            throw error
        }
    }
    
    private let result: Result<URL, Error>
    
}
