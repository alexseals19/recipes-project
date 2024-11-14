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
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(refreshRotation))
                        .padding(.top, 30)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeCellView(recipe: recipe)
                        }
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 28)
                }
            }
            .refreshable {
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 5, initialVelocity: 10)) {
                    refreshRotation += 360.0
                }
                Task {
                    await viewModel.onAppear()
                }
            }
            .padding(.horizontal, 3)
            
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 72)
                    .foregroundStyle(.ultraThinMaterial)
                Spacer()
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 25)
                    .foregroundStyle(.ultraThinMaterial)
            }
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
        .background(
            Gradient(colors: [.gray.opacity(0.5), .gray.opacity(0.2)])
        )
        .ignoresSafeArea()
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
