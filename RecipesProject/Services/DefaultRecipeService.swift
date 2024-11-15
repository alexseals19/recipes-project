//
//  DefaultRecipeService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

class DefaultRecipeService: RecipeService {

    // MARK: - API
    
    func fetchRecipes(by sortOption: SortOption) async throws -> [Recipe] {
        let url = try urlService.makeURL()
        let data = try await networkService.get(from: url)
        let response: Response = try decode(data: data)
        return sortedRecipes(recipes: response.recipes, by: sortOption)
    }
    
    init(networkService: NetworkService, urlService: URLService) {
        self.networkService = networkService
        self.urlService = urlService
    }
    
    // MARK: - Properties
    
    private var networkService: NetworkService
    private var urlService: URLService
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Functions
    
    private func sortedRecipes(recipes: [Recipe], by sortOption: SortOption) -> [Recipe] {
        
        var sortedRecipes: [Recipe] = []
        
        switch sortOption {
        case .name:
            sortedRecipes = recipes.sorted { (lhs: Recipe, rhs: Recipe) -> Bool in
                return lhs.name < rhs.name
            }
        case .cuisine:
            sortedRecipes = recipes.sorted { (lhs: Recipe, rhs: Recipe) -> Bool in
                return lhs.cuisine < rhs.cuisine
            }
        }
        
        return sortedRecipes
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let value = try jsonDecoder.decode(T.self, from: data)
            return value
        } catch {
            throw AppError.decoder
        }
    }
}
