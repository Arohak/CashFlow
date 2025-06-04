//
//  TransactionEndpoint.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import Foundation

enum ProductEndpoint: Endpoint {
    case list, item(UUID?)
    
    var path: String {
        switch self {
        case .list:
            return "/products"
        case let .item(id):
            return "/products/\(id!)"
        }
    }
}
