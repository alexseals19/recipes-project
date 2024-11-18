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
        
        await sut.onAppear()
        
        sut.cuisineOption = "British"
                
        XCTAssertEqual(sut.recipesDisplayed, Recipe.testRecipesFilterdByCuisine)
        
    }
    
    func test_filterRecipes_by_search_term() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.onAppear()
        
        sut.searchText = "Apam"
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, Recipe.testRecipesFilteredBySearch)
    }
    
    func test_filterRecipes_by_search_and_cuisine() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.onAppear()
        
        let filteredRecipes: [Recipe] = [Recipe.rockCakesFixture]
        
        sut.cuisineOption = "British"
        
        sut.searchText = "Rock Cakes"
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, filteredRecipes)
    }
    
    func test_filterRecipes_empty_search() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipes)))
                
        await sut.onAppear()
        
        sut.searchText = ""
        
        sut.filterRecipes()
                
        XCTAssertEqual(sut.recipesDisplayed, Recipe.testRecipes)
    }
}
