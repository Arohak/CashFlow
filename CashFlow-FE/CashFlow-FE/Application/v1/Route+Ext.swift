//
//  Route+Ext.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import MyNavigator
import Container

import Home
import Transaction
import Product
import Settings

public extension Route {
    @MainActor
    @ViewBuilder
    func destination(with container: Container) -> some View {
        switch self {
        case let .home(route):
            switch route {
            case .list:
                HomeView(vm: HomeViewModel(service: container.productService))
            case .item:
                ProductDetailsView(product: .mock, service: container.productService)
            }
        case let .product(route):
            switch route {
            case .list:
                ProductFeedView(service: container.productService)
            case let .item(product):
                ProductDetailsView(product: product, service: container.productService)
            }
        case .transaction:
            TransactionView(service: container.transactionService)
        case .github:
            GithubView(service: container.githubService)
        }
    }
}
