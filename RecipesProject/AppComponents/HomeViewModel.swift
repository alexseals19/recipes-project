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
    
    func onAppear() async {
        await fetchRecipes()
    }
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
    
    
    // MARK: - Properties
    
    private var recipeService: RecipeService
    
    
    
    // MARK: - Functions
    
    private func fetchRecipes() async {
        do {
            let tempRecipes = try await recipeService.fetchRecipes()
            recipes = tempRecipes
        } catch {
            print(error)
        }
    }
    
    
}
