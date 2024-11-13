//
//  ImageService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/13/24.
//

import Foundation

protocol ImageService {
    func fetchImage(from: String) async throws -> Data
}
