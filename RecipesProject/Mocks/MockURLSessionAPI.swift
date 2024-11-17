//
//  MockURLSessionAPI.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/17/24.
//

import Foundation

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
