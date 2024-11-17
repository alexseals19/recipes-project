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
    
    func test_setCuisineOption_British() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        await sut.onAppear()
        
        sut.setCuisineOption(cuisine: "British")
        
        for recipe in sut.recipesFiltered {
            XCTAssertEqual(recipe.cuisine, "British")
        }
    }
    
    func test_recipesFiltered_by_name_search() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        let testRecipesFiltered: [Recipe] = [Recipe.apamBalikFixture]
        
        await sut.onAppear()
        
        sut.searchText = "Apam"
                
        XCTAssertEqual(sut.recipesFiltered,testRecipesFiltered)
    }
    
    func test_recipesFiltered_by_cuisine_search() async throws {
        
        let sut = HomeViewModel(recipeService: MockRecipeService(result: .success(Recipe.testRecipesUnsorted)))
        
        let testRecipesFiltered: [Recipe] = [Recipe.nanaimoBarsFixture]
        
        await sut.onAppear()
        
        sut.searchText = "Canadian"
                
        XCTAssertEqual(sut.recipesFiltered, testRecipesFiltered)
    }
    
}
