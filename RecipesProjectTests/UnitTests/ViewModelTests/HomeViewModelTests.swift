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
    
    func test_filterRecipes_by_cuisine() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
        
        await sut.fetchRecipes()
        
        let expectedRecipesDisplayed: [Recipe] = [Recipe.breadAndButterPuddingFixture, Recipe.christmasCakeFixture, Recipe.rockCakesFixture]
        
        sut.cuisineOption = "British"
                
        XCTAssertEqual(sut.recipesDisplayed, expectedRecipesDisplayed)
        
    }
    
    func test_filterRecipes_by_search_term() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.fetchRecipes()
        
        let expectedRecipesDisplayed: [Recipe] = [Recipe.apamBalikFixture]
        
        sut.searchText = "Apam"
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, expectedRecipesDisplayed)
    }
    
    func test_filterRecipes_by_search_and_cuisine() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.fetchRecipes()
        
        let expectedRecipesDisplayed: [Recipe] = [Recipe.rockCakesFixture]
        
        sut.cuisineOption = "British"
        
        sut.searchText = "Rock Cakes"
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, expectedRecipesDisplayed)
    }
    
    func test_filterRecipes_empty_search() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.fetchRecipes()
        
        sut.searchText = ""
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, Recipe.testRecipes)
    }
}
