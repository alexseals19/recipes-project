//
//  HomeViewModel.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - API
    
    @Published var recipes: [Recipe] = []
    
    @Published var isAlertShown = false {
        didSet {
            if !isAlertShown { appError = nil }
        }
    }
    
    @Published var sortOption: SortOption = .name {
        didSet {
            sortRecipes()
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
    
    func sortRecipes() {
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

enum SortOption {
    case name
    case cuisine
}
