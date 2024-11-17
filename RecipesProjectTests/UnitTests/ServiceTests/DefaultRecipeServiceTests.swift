//
//  DefaultRecipeServiceTests.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import XCTest
@testable import RecipesProject

final class DefaultRecipeServiceTests: XCTestCase {
    
    func test_fetchRecipes_successful() async throws {
        
        let networkResult: Result<Data, AppError> = .success(Data.testRecipe)
        let urlResult: Result<URL, Error> = .success(mockUrl)
        
        let mockNetworkService = MockNetworkService(result: networkResult)
        let mockURLService = MockURLService(result: urlResult)
        
        let sut = DefaultRecipeService(networkService: mockNetworkService, urlService: mockURLService)
        
        let result = try await sut.fetchRecipes()
        
        XCTAssertNotNil(result, "result should not be nil")
    }
    
    func test_fetchRecipes_invalidURL_throws() async throws {
        
        let networkResult: Result<Data, AppError> = .success(Data.testRecipe)
        let urlResult: Result<URL, Error> = .failure(MockError.unknown)
        
        let mockNetworkService = MockNetworkService(result: networkResult)
        let mockURLService = MockURLService(result: urlResult)
        
        let sut = DefaultRecipeService(networkService: mockNetworkService, urlService: mockURLService)
        
        await XCTAssertThrowsError(try await sut.fetchRecipes())
    }
    
    func test_fetchRecipes_networkError_throws() async throws {
        
        let networkResult: Result<Data, AppError> = .failure(.network)
        let urlResult: Result<URL, Error> = .success(mockUrl)
        
        let mockNetworkService = MockNetworkService(result: networkResult)
        let mockURLService = MockURLService(result: urlResult)
        
        let sut = DefaultRecipeService(networkService: mockNetworkService, urlService: mockURLService)
        
        await XCTAssertThrowsError(try await sut.fetchRecipes()) { error in
            XCTAssertEqual(error as? AppError, .network, "Error thrown should be network")
        }
    }
    
    func test_fetchRecipes_dataNotDecodable_throws() async throws {
        
        let networkResult: Result<Data, AppError> = .success(Data.testRecipeMalformed)
        let urlResult: Result<URL, Error> = .success(mockUrl)
        
        let mockNetworkService = MockNetworkService(result: networkResult)
        let mockURLService = MockURLService(result: urlResult)
        
        let sut = DefaultRecipeService(networkService: mockNetworkService, urlService: mockURLService)
        
        await XCTAssertThrowsError(try await sut.fetchRecipes()) { error in
            XCTAssertEqual(error as? AppError, .decoder, "Error thrown should be decoder")
        }
    }
    
    enum MockError: Error {
        case unknown
    }
    
    private var mockUrl: URL { URL(string: "www.google.com")! }
    
    
}
