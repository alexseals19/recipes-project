//
//  HomeView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - API
    
    init(recipeService: RecipeService) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(recipeService: recipeService))
    }
    
    // MARK: - Properties
    
    @StateObject private var viewModel: HomeViewModel
    
    // MARK: - Body
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.recipes) { recipe in
                Text(recipe.name)
            }
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView(
        recipeService: DefaultRecipeService(
            networkService: DefaultNetworkService(
                urlSession: URLSession(configuration: .default)),
            urlService: DefaultURLService()
        )
    )
}
