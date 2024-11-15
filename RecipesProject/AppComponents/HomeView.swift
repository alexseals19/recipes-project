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
    
    private var isListEmpty: Bool {
        viewModel.recipes.isEmpty
    }
    
    private let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
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
            .scrollDisabled(isListEmpty)
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
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.ultraThinMaterial)
                    .overlay {
                        HStack {
                            Spacer()
                            Button {
                                viewModel.sortOption = .name
                            } label: {
                                Text("NAME")
                            }
                            Spacer()
                            Button {
                                viewModel.sortOption = .cuisine
                            } label: {
                                Text("CUISINE")
                            }
                            Spacer()
                        }
                    }
            }
            
            if viewModel.recipes.isEmpty {
                VStack {
                    Button {
                        hapticImpact.impactOccurred()
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 5, initialVelocity: 10)) {
                            refreshRotation += 360.0
                        }
                        Task {
                            await viewModel.onAppear()
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
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShown, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.alertMessage)
        })
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
