//
//  ProductController.swift
//  CashFlow-BE
//
//  Created by Ara Hakobyan on 1/3/25.
//

import Fluent
import Vapor
import Shared

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")

        products.get(use: items)
        products.post(use: create)
        products.group(":productID") { todo in
            todo.get(use: item)
            todo.delete(use: delete)
        }
    }

    @Sendable
    func items(req: Request) async throws -> [ProductDTO] {
        try await ProductModel.query(on: req.db).all().map { $0.toDTO }
    }
    
    @Sendable
    func create(req: Request) async throws -> ProductDTO {
        let model = try req.content.decode(ProductDTO.self).toModel
        try await model.save(on: req.db)
        return model.toDTO
    }

    @Sendable
    func item(req: Request) async throws -> ProductDTO {
        guard let model = try await ProductModel.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return model.toDTO
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let model = try await ProductModel.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await model.delete(on: req.db)
        return .noContent
    }
}
