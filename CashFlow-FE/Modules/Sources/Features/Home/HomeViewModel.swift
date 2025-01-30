//
//  HomeViewModel.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Combine
import MyNavigator
import Networking
import Observation
import Shared

@MainActor
public protocol IHomeViewModel {
    var products: [ProductDTO]? { get set }
    
    func fetchProducts()
    func showDetail(for product: ProductDTO)
}

@Observable
public final class HomeViewModel: IHomeViewModel {
    private let service: ProductService
    private let navigator: MyNavigator<Route>
    
    public var products: [ProductDTO]?
    public var errorMessage: String?
    public var isLoading = false
    
    public init(service: ProductService, navigator: MyNavigator<Route>) {
        self.service = service
        self.navigator = navigator
    }
    
    public init(service: ProductService) {
        self.service = service
        self.navigator = .init()
    }
    
    public func fetchProducts() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                products = try await service.list()
            } catch {
                errorMessage = "Failed to load products. Please try again."
            }
            isLoading = false
        }
    }
    
    public func showDetail(for product: ProductDTO) {
        navigator.push(.home(.item(product.id!)))
    }
}



