//
//  DefaultImageService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import Foundation

class DefaultImageService: ImageService {

    // MARK: - API
    
    func fetchImage(from url: URL) async throws -> Data {
        let data = try Data(contentsOf: url)
        return data
    }
    
    init() {}
    
    // MARK: - Properties
        
    
    
    // MARK: - Functions
    
    
}
