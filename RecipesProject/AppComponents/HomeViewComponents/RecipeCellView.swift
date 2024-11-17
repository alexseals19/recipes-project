//
//  RecipeCellView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeCellView: View {
    
    // MARK: - API
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: - Properties
    
    @State private var isShowingDetailView: Bool = false
    
    @Namespace private var namespace
    
    //MARK: - Body
        
    var body: some View {
        Button {
            withAnimation(.linear(duration: 0.2)) {
                isShowingDetailView.toggle()
            }
        } label: {
            WebImage(url: recipe.thumbnailImageUrl) { image in
                image.resizable()
            } placeholder: {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.thinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 25))
            .overlay {
                if isShowingDetailView {
                    recipeDetailOverlayView
                } else {
                    recipeTitleOverlayView
                }
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var recipeTitleOverlayView: some View {
        VStack {
            HStack {
                HStack {
                    Text(recipe.name)
                        .font(.subheadline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .padding(.vertical, 5)
                }
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                .background(
                    Capsule()
                        .foregroundStyle(.thinMaterial)
                        .matchedGeometryEffect(id: "detail", in: namespace)
                )
                .padding(10)
                .foregroundStyle(.primary)
                Spacer()
            }
            Spacer()
        }
    }
    
    private var recipeDetailOverlayView: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.ultraThinMaterial)
            .matchedGeometryEffect(id: "detail", in: namespace)
            .overlay {
                RecipeDetailView(recipe: recipe, detailSelected: $isShowingDetailView)
            }
    }
}

#Preview {
    RecipeCellView(recipe: Recipe.rockCakesFixture)
}
