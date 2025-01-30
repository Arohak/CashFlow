//
//  CategoryController.swift
//  CashFlow-BE
//
//  Created by Ara Hakobyan on 1/3/25.
//

import Fluent
import Vapor
import Shared

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let routes = routes.grouped("categories")

        routes.get(use: items)
        routes.post(use: create)
        routes.group(":categoryID") { todo in
            todo.get(use: item)
            todo.delete(use: delete)
        }
    }

    @Sendable
    func items(req: Request) async throws -> [CategoryDTO] {
        try await CategoryModel.query(on: req.db).all().map { $0.toDTO }
    }
    
    @Sendable
    func create(req: Request) async throws -> CategoryDTO {
        let model = try req.content.decode(CategoryDTO.self).toModel
        try await model.save(on: req.db)
        return model.toDTO
    }

    @Sendable
    func item(req: Request) async throws -> CategoryDTO {
        guard let model = try await CategoryModel.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return model.toDTO
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let model = try await CategoryModel.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await model.delete(on: req.db)
        return .noContent
    }
}
