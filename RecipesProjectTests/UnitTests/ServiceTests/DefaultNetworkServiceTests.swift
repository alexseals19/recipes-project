//
//  DefaultNetworkServiceTests.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import XCTest
@testable import RecipesProject

final class DefaultNetworkServiceTests: XCTestCase {
    
    func test_get_successful() async throws {
        let mockResponse = HTTPURLResponse(
            url: mockUrl,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let result: Result<(Data, URLResponse), Error> = .success((Data(), mockResponse))
        
        let mockURLSessionAPI = MockURLSessionAPI(result: result)
        
        let sut = DefaultNetworkService(urlSession: mockURLSessionAPI)
        
        let data = try await sut.get(from: mockUrl)
        
        XCTAssertNotNil(data, "data should not be nil")
    }
    
    func test_get_non200statusCode_throws() async throws {
        
        let mockResponse = HTTPURLResponse(
            url: mockUrl,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let result: Result<(Data, URLResponse), Error> = .success((Data(), mockResponse))
        
        let mockURLSessionAPI = MockURLSessionAPI(result: result)
        
        let sut = DefaultNetworkService(urlSession: mockURLSessionAPI)
                        
        await XCTAssertThrowsError(
            try await sut.get(from: mockUrl),
            "Error should be thrown"
        ) { error in
            XCTAssertEqual(
                error as? AppError,
                AppError.invalidResponse,
                "Error thrown should be AppError.invalidResponse"
            )
        }
    }
    
    func test_get_urlSessionError_throws() async throws {
        
        let result: Result<(Data, URLResponse), Error> = .failure(MockURLSessionAPI.MockError.unknown)
        
        let mockURLSessionAPI = MockURLSessionAPI(result: result)
        
        let sut = DefaultNetworkService(urlSession: mockURLSessionAPI)
                        
        await XCTAssertThrowsError(
            try await sut.get(from: mockUrl),
            "Error should be thrown"
        ) { error in
            XCTAssertEqual(
                error as? AppError,
                AppError.network,
                "Error thrown should be AppError.network"
            )
        }
    }
    
    private var mockUrl: URL { URL(string: "www.google.com")! }
}
