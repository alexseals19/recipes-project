//
//  RecipeCellView.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import SwiftUI

struct RecipeCellView: View {
    
    // MARK: - API
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: - Properties
    
    @State private var detailSelected: Bool = false
    
    @Namespace private var namespace
    
    @State private var image = Image(systemName: "waveform")
    
    private let recipe: Recipe
    
    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 25))
                .overlay {
                    if !detailSelected {
                        VStack {
                            HStack {
                                HStack {
                                    Text(recipe.name)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.1)
                                    Button {
                                        withAnimation(.linear(duration: 0.2)) {
                                            detailSelected.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "line.3.horizontal.decrease.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15, height: 15)
                                    }
                                    .foregroundStyle(.primary)
                                }
                                .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                                .background(
                                    Capsule()
                                        .foregroundStyle(.ultraThinMaterial)
                                        .matchedGeometryEffect(id: "detail", in: namespace)
                                )
                                .padding(10)
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(.ultraThinMaterial)
                            .overlay {
//                                RecipeDetailView(
//                                    name: recipe.name,
//                                    cuisine: recipe.cuisine,
//                                    detailSelected: $detailSelected)
                            }
                            .matchedGeometryEffect(id: "detail", in: namespace)
                    }
                    
                }
                .padding(.horizontal, 5)
        }
        .onAppear {
            
//            guard let url = recipe.photo_url_large else {
//                return
//            }
//            
//            Task {
//                let data = try await DefaultImageService(
//                    networkService: DefaultNetworkService(
//                        urlSession: URLSession(configuration: .default)
//                    ),
//                    urlService: DefaultURLService()).fetchImage(from: url)
//                guard let tempImage = UIImage( data: data) else {
//                    return
//                }
//                
//                image = Image(uiImage: tempImage)
//            }
        }
    }
}

//#Preview {
//    RecipeCellView(recipe: Recipe(
//        cuisine: "British",
//        name: "Battenberg Cake",
//        photo_url_large: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg")!,
//        id: UUID()
//    ))
//}
