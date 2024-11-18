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
    
    @Published var recipesDisplayed: [Recipe] = []
    
    @Published var searchText: String = ""
    
    @Published var isAlertShown = false {
        didSet {
            if !isAlertShown { appError = nil }
        }
    }
                
    @Published var cuisineOption: String? {
        didSet {
            filterRecipes()
        }
    }
    
    var cuisineTypes: [String] = []
    
    var isRecipesListEmpty: Bool {
        recipes.isEmpty
    }
    
    var alertMessage: String {
        appError?.alertMessage ?? AppError.unknown.alertMessage
    }
    
    var alertTitle: String {
        appError?.alertTitle ?? AppError.unknown.alertTitle
    }
    
    func onRefresh() async {
        await fetchRecipes()
    }
    
    func onAppear() async {
        await fetchRecipes()
    }
    
    func filterRecipes() {
        if !searchText.isEmpty, let cuisineOption {
            let recipesBySearch = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
            }
            recipesDisplayed = recipesBySearch.filter {
                $0.cuisine.contains(cuisineOption)
            }
        } else if let cuisineOption {
            recipesDisplayed = recipes.filter {
                $0.cuisine.contains(cuisineOption)
            }
        } else if !searchText.isEmpty {
            recipesDisplayed = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
            }
        } else {
            recipesDisplayed = recipes
        }
    }
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
    // MARK: - Properties
    
    private var recipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    private var recipeService: RecipeService
    
    private var isFilteredBySearch: Bool = false
    
    private var appError: AppError? {
        didSet {
            if appError != nil { isAlertShown = true }
        }
    }
    
    // MARK: - Functions
    
    private func fetchRecipes() async {
        do {
            recipes = try await recipeService.fetchRecipes()
        } catch {
            showAlert(for: error)
        }
        updateCuisineTypes()
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
