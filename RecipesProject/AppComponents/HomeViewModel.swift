//
//  HomeViewModel.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - API
    @Published var recipes: [Recipe] = []
    @Published var recipesDisplayed: [Recipe]?
    
    @Published var isAlertShown = false {
        didSet {
            if !isAlertShown { appError = nil }
        }
    }
                
    @Published var cuisineOption: String? {
        didSet {
            if let cuisineOption {
                filterRecipes(for: cuisineOption)
            } else {
                filterRecipes(for: "")
            }
        }
    }
    
    var cuisineTypes: [String] = []
    
    var alertMessage: String {
        appError?.alertMessage ?? AppError.unknown.alertMessage
    }
    
    var alertTitle: String {
        appError?.alertTitle ?? AppError.unknown.alertTitle
    }
    
    func onAppear() async {
        await fetchRecipes()
        updateCuisineTypes()
    }
    
    func filterRecipes(for searchText: String) {
        if searchText.isEmpty, cuisineOption == nil {
            recipesDisplayed = nil
        } else if !searchText.isEmpty, let cuisineOption {
            let recipesBySearch = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
            }
            recipesDisplayed = recipesBySearch.filter {
                $0.cuisine.contains(cuisineOption)
            }
        } else {
            recipesDisplayed = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func setCuisineOption(cuisine: String?) {
        cuisineOption = cuisine
    }
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
    // MARK: - Properties
    
    private var recipeService: RecipeService
    
    private var appError: AppError? {
        didSet {
            if appError != nil { isAlertShown = true }
        }
    }
    
    // MARK: - Functions
    
    private func fetchRecipes() async {
        do {
            let tempRecipes = try await recipeService.fetchRecipes()
            recipes = tempRecipes
        } catch {
            showAlert(for: error)
        }
    }
    
    private func showAlert(for error: Error) {
        if let error = error as? AppError {
            appError = error
        } else {
            appError = AppError.unknown
        }
    }
    
    private func updateCuisineTypes() {
        cuisineTypes.removeAll()
        
        for recipe in recipes {
            if !cuisineTypes.contains(recipe.cuisine) {
                cuisineTypes.append(recipe.cuisine)
            }
        }
        
        cuisineTypes.sort { lhs, rhs in
            lhs > rhs
        }
    }
}
