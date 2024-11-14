//
//  RecipeDetailView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    //MARK: - API
    
    @Binding var detailSelected: Bool
    
    init(recipe: Recipe, detailSelected: Binding<Bool>) {
        self.recipe = recipe
        _detailSelected = detailSelected
    }
    
    //MARK: - Properties
    
    private let recipe: Recipe
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(recipe.name)
                    .font(.title3)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        detailSelected.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundStyle(.primary)
            }
            
            VStack {
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.caption)
                Spacer()
                Image(recipe.country)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(0.5)
                Spacer()
                if recipe.youtubeUrl != nil || recipe.sourceUrl != nil {
                    Text("Want to make this?")
                        .font(.caption)
                }
                HStack {
                    Spacer()
                    if let youtubeUrl = recipe.youtubeUrl {
                        Link(destination: youtubeUrl) {
                            Image("yt_icon_rgb")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                    Spacer()
                    if let sourceUrl = recipe.sourceUrl {
                        Link(destination: sourceUrl) {
                            Image(systemName: "link")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .foregroundStyle(.primary)
                    }
                    Spacer()
                }
                .padding(.top, 1)
            }
            .foregroundStyle(.secondary)
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.recipeFixture, detailSelected: .constant(true))
}
