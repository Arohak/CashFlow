//
//  DetailViewModel.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Combine
import Shared
import Navigator
import Networking
import Observation
import Foundation

public protocol DetailViewModel {
    var product: ProductDTO? { get set }
    func fetchProduct()
}

@Observable
final public class DetailViewModelImpl: @preconcurrency DetailViewModel {
    private let service: ApiService
    private let navigator: Navigator<Route>

    private let id: UUID?
    
    public var product: ProductDTO?
    
    public init(id: UUID?, service: ApiService, navigator: Navigator<Route>) {
        self.id = id
        self.service = service
        self.navigator = navigator
    }
    
    @MainActor public func fetchProduct() {
        Task {
            product = try? await service.fetchProduct(id)
        }
    }
}
