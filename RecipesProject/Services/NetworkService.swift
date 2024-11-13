//
//  NetworkService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

protocol NetworkService {
    func get(from: URL) async throws -> Data
}
