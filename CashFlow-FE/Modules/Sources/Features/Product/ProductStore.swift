//
//  ProductStore.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/26/25.
//

import Observation
import Shared
import Networking

@MainActor
@Observable
public final class ProductStore {
    private let service: ProductService

    public var product: ProductDTO?
    public var products: [ProductDTO]?
    public var isLoading = false
    
    public init(service: ProductService) {
        self.service = service
    }
    
    public init(product: ProductDTO, service: ProductService) {
        self.service = service
        self.product = product
    }
    
    public func fetchProducts() {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task {
            products = try await service.list()
            isLoading = false
        }
    }
    
    public func fetchProduct() {
        guard let id = product?.id else { return }
        
        isLoading = true

        Task {
            try await Task.sleep(for: .seconds(1))
            product = try? await service.item(id)
            isLoading = false
        }
    }
}
