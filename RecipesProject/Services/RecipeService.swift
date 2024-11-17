//
//  RecipeService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

protocol RecipeService {
    func fetchRecipes() async throws -> [Recipe]
}
