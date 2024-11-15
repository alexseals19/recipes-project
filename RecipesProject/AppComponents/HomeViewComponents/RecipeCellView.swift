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
        
    var body: some View {
        ZStack {
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
                    recipeDetailOverlay
                } else {
                    recipeTitleOverlay
                }
            }
        }
        .onAppear {
            
        }
    }
    
    var recipeTitleOverlay: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        isShowingDetailView.toggle()
                    }
                } label: {
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
                }
                .foregroundStyle(.primary)
                Spacer()
            }
            Spacer()
        }
    }
    
    var recipeDetailOverlay: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.ultraThinMaterial)
            .matchedGeometryEffect(id: "detail", in: namespace)
            .overlay {
                RecipeDetailView(recipe: recipe, detailSelected: $isShowingDetailView)
            }
    }
    
//    func getImage(for url: URL) -> Image {
//        Task {
//            let data = try await DefaultImageService().fetchImage(from: url)
//            guard let tempImage = UIImage( data: data) else {
//                return Image(systemName: "xmark")
//            }
//            image = Image(uiImage: tempImage)
//            return image
//        }
//        return Image(systemName: "xmark")
//    }
}

#Preview {
    RecipeCellView(recipe: Recipe.recipeFixture)
}
