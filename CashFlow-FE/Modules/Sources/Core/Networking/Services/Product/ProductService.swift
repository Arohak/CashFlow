//
//  ProductService.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import Foundation
import Shared

public struct ProductService: Sendable {
    public let list: @Sendable () async throws -> [ProductDTO]
    public let item: @Sendable (UUID?) async throws -> ProductDTO
}

public extension ProductService {
    static func live(url: URL) -> Self {
        .init(
            list: { try await ProductEndpoint.list.execute(baseUrl: url, type: [ProductDTO].self).value },
            item: { try await ProductEndpoint.item($0).execute(baseUrl: url, type: ProductDTO.self).value }
        )
    }
    
    static let mock = Self (
        list: { Array(repeating: .mock, count: 20) },
        item: { _ in .mock }
    )
}
