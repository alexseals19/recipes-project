//
//  HomeViewModelTests.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/17/24.
//

import Foundation
import XCTest
@testable import RecipesProject

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    func test_sortRecipes_by_name() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        await sut.onAppear()
        
        sut.sortRecipes(by: .name)
        
        XCTAssertEqual(sut.recipes, Recipe.testRecipesSortedByName)
    }
    
    func test_sortRecipes_by_cuisine() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        await sut.onAppear()
        
        sut.sortRecipes(by: .cuisine)
        
        XCTAssertEqual(sut.recipes, Recipe.testRecipesSortedByCuisine)
    }
    
    func test_recipesFiltered_by_name() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        let testRecipesFiltered: [Recipe] = [Recipe.apamBalikFixture]
        
        await sut.onAppear()
        
        sut.searchText = "Apam"
                
        XCTAssertEqual(sut.recipesFiltered,testRecipesFiltered)
    }
    
    func test_recipesFiltered_by_cuisine() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        let testRecipesFiltered: [Recipe] = [Recipe.nanaimoBarsFixture]
        
        await sut.onAppear()
        
        sut.searchText = "Canadian"
                
        XCTAssertEqual(sut.recipesFiltered, testRecipesFiltered)
    }
    
}
