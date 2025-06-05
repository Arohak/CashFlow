//
//  GithubEndpoint.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import Foundation

enum GithubEndpoint: Endpoint {
    case search(String)
    
    var path: String {
        "/search/repositories"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .search(value):
            return [.init(name: "q", value: value)]
        }
    }
}
