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

extension CategoryDTO: @retroactive Content {
    var toModel: CategoryModel {
        .init(
            id: id,
            name: name,
            info: info
        )
    }
}

final class CategoryModel: Model, @unchecked Sendable {
    static let schema = "categories"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "info")
    var info: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID?, name: String, info: String?) {
        self.id = id
        self.name = name
        self.info = info
    }
    
    var toDTO: CategoryDTO {
        .init(
            id: id,
            name: $name.value ?? "",
            info: $info.value ?? ""
        )
    }
}
