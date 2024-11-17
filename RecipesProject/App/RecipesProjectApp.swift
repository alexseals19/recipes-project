//
//  RecipesProjectApp.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import SwiftUI

@main
struct RecipesProjectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                recipeService: DefaultRecipeService(
                    networkService: DefaultNetworkService(urlSession: URLSession(configuration: .default)),
                    urlService: DefaultURLService()
                )
            )
        }
    }
}
