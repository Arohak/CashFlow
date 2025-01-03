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
        let product = try req.content.decode(ProductDTO.self).toModel
        try await product.save(on: req.db)
        return product.toDTO
    }

    @Sendable
    func item(req: Request) async throws -> ProductDTO {
        guard let product = try await ProductModel.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return product.toDTO
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await ProductModel.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .noContent
    }
}
