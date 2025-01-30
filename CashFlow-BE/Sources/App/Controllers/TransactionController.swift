//
//  TransactionController.swift
//  CashFlow-BE
//
//  Created by Ara Hakobyan on 1/3/25.
//

import Fluent
import Vapor
import Shared

struct TransactionController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let routes = routes.grouped("transactions")

        routes.get(use: items)
        routes.post(use: create)
        routes.group(":transactionID") { todo in
            todo.get(use: item)
            todo.delete(use: delete)
        }
    }

    @Sendable
    func items(req: Request) async throws -> [TransactionDTO] {
        try await TransactionModel.query(on: req.db).all().map { $0.toDTO }
    }
    
    @Sendable
    func create(req: Request) async throws -> TransactionDTO {
        let model = try req.content.decode(TransactionDTO.self).toModel
        try await model.save(on: req.db)
        return model.toDTO
    }

    @Sendable
    func item(req: Request) async throws -> TransactionDTO {
        guard let model = try await TransactionModel.find(req.parameters.get("transactionID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return model.toDTO
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let model = try await TransactionModel.find(req.parameters.get("transactionID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await model.delete(on: req.db)
        return .noContent
    }
}
