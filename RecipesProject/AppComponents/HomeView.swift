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
    
    @State private var refreshRotation = 0.0
    
    @FocusState private var isSearchBarFocused: Bool
    
    private let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            ScrollView() {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.recipesDisplayed) { recipe in
                        RecipeCellView(recipe: recipe)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
            .padding(.top, 1)
            .background(Gradient(colors: [.gray.opacity(0.2), .clear]))
            .scrollDisabled(viewModel.isRecipesListEmpty)
            .refreshable {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
        
            ToolbarView(
                cuisineTypes: viewModel.cuisineTypes,
                searchText: $viewModel.searchText,
                cuisineOption: $viewModel.cuisineOption,
                filterRecipes: viewModel.filterRecipes
            )
            .shadow(radius: 10)
            .padding(.horizontal)
            
            if viewModel.isRecipesListEmpty {
                emptyListView
            } else if viewModel.recipesDisplayed.isEmpty {
                Text("Sorry, no recipes match your search term.")
                    .font(.headline)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShown, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.alertMessage)
        })
        .onAppear {
            Task {
                await viewModel.fetchRecipes()
            }
        }
    }
    
    private var emptyListView: some View {
        VStack {
            Button {
                hapticImpact.impactOccurred()
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 5, initialVelocity: 10)) {
                    refreshRotation += 360.0
                }
                Task {
                    await viewModel.fetchRecipes()
                }
            } label: {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.degrees(refreshRotation))
                    .padding(.top, 30)
            }
            .foregroundStyle(.primary)
            .padding(25)
            Text("There are no recipes to show at this time.")
                .font(.headline)
            Text("Please refresh to try again.")
                .font(.headline)
        }
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
