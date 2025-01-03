//
//  HomeViewModel.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Combine
import Models
import Navigator
import Networking
import Observation
import Shared

public protocol HomeViewModel {
    var products: [ProductDTO]? { get set }
    
    func fetchProducts()
    func showDetail(for product: ProductDTO)
}

@Observable
final public class HomeViewModelImpl: @preconcurrency HomeViewModel {
    private let service: ApiService
    private let navigator: Navigator<Route>
    
    public var products: [ProductDTO]?
    
    public init(service: ApiService, navigator: Navigator<Route>) {
        self.service = service
        self.navigator = navigator
    }
    
    @MainActor
    public func fetchProducts() {
        Task {
            do {
                products = try await service.fetchProducts()
            } catch {
                
            }
        }
    }
    
    public func showDetail(for product: ProductDTO) {
        navigator.push(.detail(product.id))
    }
}



