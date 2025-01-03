//
//  ProductModel.swift
//  CashFlow-BE
//
//  Created by Ara Hakobyan on 1/3/25.
//

import Vapor
import Fluent
import struct Foundation.UUID
import Shared

extension ProductDTO: @retroactive Content {
    var toModel: ProductModel {
        .init(
            id: id,
            title: title,
            category: category,
            price: price,
            thumbnail: thumbnail
        )
    }
}

final class ProductModel: Model, @unchecked Sendable {
    static let schema = "products"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "category")
    var category: String
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "thumbnail")
    var thumbnail: String

    init() { }

    init(id: UUID?, title: String, category: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.category = category
        self.price = price
        self.thumbnail = thumbnail
    }
    
    var toDTO: ProductDTO {
        .init(
            id: id,
            title: $title.value ?? "",
            category: $category.value ?? "",
            price: $price.value ?? 0,
            thumbnail: $thumbnail.value ?? ""
        )
    }
}
