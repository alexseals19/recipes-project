//
//  URLSession+URLSessionAPI.swift
//  RecipesProject
//
//  Created by Alex Seals on 11/12/24.
//

import Foundation

public protocol URLSessionAPI {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionAPI {}
