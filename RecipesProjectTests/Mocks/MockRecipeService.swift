//
//  MockRecipeService.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/17/24.
//

import Foundation
@testable import RecipesProject

class MockRecipeService: RecipeService {
    func fetchRecipes() async throws -> [Recipe] {
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            throw error
        }
    }
    
    init(result: Result<[Recipe], AppError>) {
        self.result = result
    }
    
    private let result: Result<[Recipe], AppError>
    
}
