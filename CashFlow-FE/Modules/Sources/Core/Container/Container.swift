//
//  AppContainer.swift
//  
//
//  Created by Artem Kvasnetskyi on 19.12.2022.
//

import Networking
import SwiftUI

public final class Container {
    public var transactionService: ITransactionService
    public var githubService: GithubService
    public var productService: ProductService

    public init(_ configuration: Configuration) {
        self.transactionService = TransactionService(baseUrl: configuration.info.serverURL)
        self.productService = .live(url: configuration.info.serverURL)
        self.githubService = .live(url: configuration.info.githubURL)
    }
    
    public init() {
        self.transactionService = MockTransactionService()
        self.productService = .mock
        self.githubService = .mock
    }
    
    @MainActor public static let mock = Container()
    @MainActor public static let live = Container(Configuration(bundle: .main))
}

public extension EnvironmentValues {
    @Entry var container = Container()
}

// Third Party https://github.com/hmlongco/Factory
//public extension Container {
//    var transactionService: ParameterFactory<URL, ITransactionService> {
//        self { _ in MockTransactionService() }.shared
//    }
//    
//    var productService: ParameterFactory<URL, ProductService> {
//        self { .live(url: $0) }.singleton
//    }
//}
