//
//  Recipe.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

struct Recipe: Codable, Hashable, Identifiable {
    
    let cuisine: String
    let name: String
    let id: UUID
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case id = "uuid"
    }
}
