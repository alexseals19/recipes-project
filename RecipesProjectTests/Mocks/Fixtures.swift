//
//  Fixtures.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//

import Foundation
@testable import RecipesProject

extension Recipe {
    
    static let testRecipesUnsorted: [Recipe] = [rockCakesFixture, apamBalikFixture, nanaimoBarsFixture]
    
    static let testRecipesSortedByName: [Recipe] = [apamBalikFixture, nanaimoBarsFixture, rockCakesFixture]
    
    static let testRecipesSortedByCuisine: [Recipe] = [rockCakesFixture, nanaimoBarsFixture, apamBalikFixture]
    
    static let rockCakesFixture: Recipe = Recipe(
        cuisine: "British",
        name: "Rock Cakes",
        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dce36ed7-d5bd-4532-9e9f-fafd75a4eb8f/large.jpg"),
        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dce36ed7-d5bd-4532-9e9f-fafd75a4eb8f/small.jpg"),
        uuid: UUID(),
        sourceUrl: URL(string: "https://www.bbc.co.uk/food/recipes/rock_cakes_03094"),
        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=tY3taZO3Aro")
    )
    
    static let apamBalikFixture: Recipe = Recipe(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
        uuid: UUID(),
        sourceUrl: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    )
    
    static let nanaimoBarsFixture: Recipe = Recipe(
        cuisine: "Canadian",
        name: "Nanaimo Bars",
        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f69452d-d1af-4a5c-9461-203611502b30/large.jpg"),
        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/67257b12-6702-4a9b-b0db-65bd4cbbb6b4/small.jpg"),
        uuid: UUID(),
        sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/nanaimo-bars"),
        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=MMrE4I1ZtWo")
    )
    
}

extension Data {
    static let testRecipe: Data = {
        let bundle = Bundle(for: DefaultRecipeServiceTests.self)
        let url = bundle.url(forResource: "testRecipe", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }()
}

extension Data {
    static let testRecipeMalformed: Data = {
        let bundle = Bundle(for: DefaultRecipeServiceTests.self)
        let url = bundle.url(forResource: "testRecipeMalformed", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }()
}
