//
//  NavigationStack.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/27/25.
//

import SwiftUI
import Navigator
import Shared
import Container
import MyNavigator

public struct ProductNavigationStack: View {
    @State private var destination: ProductDestinations?
    
    public init() { }
    
    public var body: some View {
        ManagedNavigationStack {
            VStack {
                Button("Product Feed") {
                    destination = .list
                }
                .buttonStyle(.bordered)
                
                Button("Product Detail") {
                    destination = .item(.mock)
                }
                .buttonStyle(.bordered)
                .navigate(to: $destination)
            }
            .navigationDestination(ProductDestinations.self)
        }
    }
}

public enum ProductDestinations {
    case list
    case item(ProductDTO)
}

extension ProductDestinations: NavigationDestination {
    public var method: NavigationMethod {
        switch self {
        case .list: .push
        case .item: .sheet
        }
    }
    
    public var view: some View {
        ProductDestinationsView(destination: self)
    }
}

public struct ProductDestinationsView: View {
    let destination: ProductDestinations
    
    @Environment(\.container) var container: Container
    
    public var body: some View {
        switch destination {
        case .list:
            ProductFeedView(service: container.productService)
        case let .item(product):
            ProductDetailsView(product: product, service: container.productService)
        }
    }
}
