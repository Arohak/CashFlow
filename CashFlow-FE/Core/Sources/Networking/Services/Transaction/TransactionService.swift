//
//  TransactionService.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/24/25.
//

import Foundation
import Shared

public typealias TransactionEntity = TransactionDTO

public protocol ITransactionService: Sendable {
    func items() async throws -> [TransactionEntity]
    func item(by id: String) async throws -> TransactionEntity
    func create(_ item: TransactionEntity) async throws -> Data
    func update(by id: String, _ item: TransactionEntity) async throws -> Data
    func delete(by id: String) async throws -> Data
    func search(by query: String) async throws -> [TransactionEntity]
}

public actor TransactionService: ITransactionService {
    
    private let baseUrl: URL
    
    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
        
    public func items() async throws -> [TransactionEntity] {
        try await TransactionEndpoint.items.execute(baseUrl: baseUrl, type: [TransactionEntity].self).value
    }
    
    public func item(by id: String) async throws -> TransactionEntity {
        try await TransactionEndpoint.item(id).execute(baseUrl: baseUrl, type: TransactionEntity.self).value
    }
    
    public func create(_ item: TransactionEntity) async throws -> Data {
        try await TransactionEndpoint.create(item).execute(baseUrl: baseUrl).value
    }
    
    public func update(by id: String, _ item: TransactionEntity) async throws -> Data {
        try await TransactionEndpoint.update(id, item).execute(baseUrl: baseUrl).value
    }
    
    public func delete(by id: String) async throws -> Data {
        try await TransactionEndpoint.delete(id).execute(baseUrl: baseUrl).value
    }
    
    public func search(by query: String) async throws -> [TransactionEntity] {
        try await TransactionEndpoint.search(query).execute(baseUrl: baseUrl, type: [TransactionEntity].self).value
    }
}

public actor MockTransactionService: ITransactionService {
    
    public init() { }
    
    public func items() async throws -> [TransactionEntity] {
        try await [
            item(by: ""),
            item(by: ""),
        ]
    }
    
    public func item(by id: String) async throws -> TransactionEntity {
        .init(id: UUID(), type: .expense, category: .init(id: UUID(), name: "Home", info: "Other"), value: 100, note: "note")
//        .init(id: "1", name: "Home", value: 100, date: .now)
    }
    
    public func create(_ item: TransactionEntity) async throws -> Data {
        .init()
    }
    public func update(by id: String, _ item: TransactionEntity) async throws -> Data {
        .init()
    }
    public func delete(by id: String) async throws -> Data {
        .init()
    }
    public func search(by query: String) async throws -> [TransactionEntity] {
        []
    }
}

public struct TransDTO: Identifiable, Equatable, Decodable, Sendable {
    public let id: String
    public let name: String
    public let value: Double
    public let date: Date

    init(id: String, name: String, value: Double, date: Date) {
        self.id = id
        self.name = name
        self.value = value
        self.date = date
    }
}
