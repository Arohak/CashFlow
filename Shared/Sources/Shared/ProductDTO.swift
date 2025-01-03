//
//  ProductDTO.swift
//  Shared
//
//  Created by Ara Hakobyan on 1/3/25.
//

import Foundation

public protocol Product: Codable, Identifiable, Sendable {
    var id: UUID? { get }
    var title: String { get }
    var category: String { get }
    var price: Double { get }
    var thumbnail: String { get }
}

public struct ProductDTO: Product {
    public let id: UUID?
    public let title: String
    public let category: String
    public let price: Double
    public let thumbnail: String
    
    public init(id: UUID?, title: String, category: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.category = category
        self.thumbnail = thumbnail
    }
}
