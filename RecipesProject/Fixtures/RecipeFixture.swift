//
//  RecipeFixture.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/14/24.
//

import Foundation

extension Recipe {
    
    static let recipeFixture: Recipe = Recipe(
        cuisine: "British",
        name: "Rock Cakes",
        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dce36ed7-d5bd-4532-9e9f-fafd75a4eb8f/large.jpg"),
        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dce36ed7-d5bd-4532-9e9f-fafd75a4eb8f/small.jpg"),
        uuid: UUID(),
        sourceUrl: URL(string: "https://www.bbc.co.uk/food/recipes/rock_cakes_03094"),
        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=tY3taZO3Aro")
    )
    
}
