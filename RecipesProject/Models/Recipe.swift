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
    let photoUrlLarge: String?
    let id: UUID
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case id = "uuid"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        self.id = try container.decode(UUID.self, forKey: .id)
    }
}
