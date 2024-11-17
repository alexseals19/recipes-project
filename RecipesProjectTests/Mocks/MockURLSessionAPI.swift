//
//  MockURLSessionAPI.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import Foundation
@testable import RecipesProject

struct MockURLSessionAPI: URLSessionAPI {
    
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            throw error
        }
    }
    
    init(result: Result<(Data, URLResponse), Error>) {
        self.result = result
    }
    
    private let result: Result<(Data, URLResponse), Error>
    
    enum MockError: Error {
        case unknown
    }
}
