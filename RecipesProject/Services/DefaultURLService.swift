//
//  DefaultURLService.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

struct DefaultURLService: URLService {
    
    // MARK: - API
    
    func makeURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint
        
        guard let url = urlComponents.url else {
            preconditionFailure("DefaultURLService failed to form valid URL.")
        }
        return url
    }
    
    // MARK: - Constants
    
    private let scheme = "https"
    private let host = "d3jbb8n5wk0qxi.cloudfront.net"
    private let endpoint = "/recipes.json"
    private let malformedEndpoint = "/recipes-malformed.json"
    private let emptyEndpoint = "/recipes-empty.json"
}
