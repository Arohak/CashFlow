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

extension TransactionDTO: @retroactive Content {
    var toModel: TransactionModel {
        .init(
            id: id,
            type: type,
            category: category.toModel,
            value: value,
            note: note
        )
    }
}

final class TransactionModel: Model, @unchecked Sendable {
    static let schema = "transactions"
    
    @ID(key: .id)
    var id: UUID?
    
    @Enum(key: "type")
    var type: TransactionType
    
    @Field(key: "category")
    var category: CategoryModel
    
    @Field(key: "value")
    var value: Double
    
    @OptionalField(key: "note")
    var note: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID?, type: TransactionType, category: CategoryModel, value: Double, note: String?) {
        self.id = id
        self.type = type
        self.category = category
        self.value = value
        self.note = note
    }
    
    var toDTO: TransactionDTO {
        .init(
            id: id,
            type: type,
            category: category.toDTO,
            value: $value.value ?? 0,
            note: $note.value ?? ""
        )
    }
}
