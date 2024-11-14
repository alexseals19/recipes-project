//
//  Recipe.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation
import SwiftUI

struct Recipe: Codable, Hashable, Identifiable {
    
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let uuid: UUID
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
    var id: UUID {
        uuid
    }   
}

extension Recipe {
    var country: String {
        switch cuisine {
        case "British":
            return "UK"
        case "American":
            return "USA"
        case "Canadian":
            return "CA"
        case "French":
            return "FR"
        case "Italian":
            return "IT"
        case "Tunisian":
            return "TU"
        case "Malaysian":
            return "MY"
        case "Greek":
            return "GR"
        case "Polish":
            return "PO"
        case "Russian":
            return "RU"
        case "Portuguese":
            return "PG"
        case "Croatian":
            return "CR"
        default:
            return "USA"
        }
    }
}
