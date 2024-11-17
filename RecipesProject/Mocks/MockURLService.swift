//
//  MockURLService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/17/24.
//

import Foundation

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
