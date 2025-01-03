//
//  ApiService.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Foundation
import Shared

public struct ApiService: Sendable {
    public let fetchProducts: @Sendable () async throws -> [ProductDTO]
    public let fetchProduct: @Sendable (UUID?) async throws -> ProductDTO
}

extension ApiService {
//    static let baseURL = "https://dummyjson.com"
    static let baseURL = "https://f4eb-5-77-196-202.ngrok-free.app"
    
     public static let live = Self(
        fetchProducts: {
            let url = URL(string: "\(baseURL)/products")!
            let (data, _) = try await URLSession.shared.data(from: url)
//            let result = try JSONDecoder().decode(Response.self, from: data)
//            return result.products
            let result = try JSONDecoder().decode([ProductDTO].self, from: data)
            return result
        },
        fetchProduct: { id in
            let url = URL(string: "\(baseURL)/products/\(id!)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(ProductDTO.self, from: data)
            return result
        }
    )
    
    public static let mock = Self (
        fetchProducts: {
            Array(repeating: product, count: 20)
        }, fetchProduct: { _ in
            product
        }
    )
    
    static let product = ProductDTO(id: UUID(uuidString: "0"), title: "iPhone", category: "Apple", price: 100, thumbnail: "")
}

