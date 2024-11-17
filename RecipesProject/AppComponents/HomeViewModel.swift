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
    
    @Published var isAlertShown = false {
        didSet {
            if !isAlertShown { appError = nil }
        }
    }
    
    @Published var sortOption: SortOption = .name
        
    @Published var searchText: String = ""
        
    var recipesFiltered: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var alertMessage: String {
        appError?.alertMessage ?? AppError.unknown.alertMessage
    }
    
    var alertTitle: String {
        appError?.alertTitle ?? AppError.unknown.alertTitle
    }
    
    func onAppear() async {
        await fetchRecipes()
    }
    
    func sortRecipes(by sortOption: SortOption) {
        
        self.sortOption = sortOption
        
        switch sortOption {
        case .name:
            recipes.sort { (lhs: Recipe, rhs: Recipe) -> Bool in
                return lhs.name < rhs.name
            }
        case .cuisine:
            recipes.sort { (lhs: Recipe, rhs: Recipe) -> Bool in
                return lhs.cuisine < rhs.cuisine
            }
        }
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
            let tempRecipes = try await recipeService.fetchRecipes(by: sortOption)
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
    
}

enum SortOption: String {
    case name = "Name"
    case cuisine = "Cuisine"
}
