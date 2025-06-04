//
//  HomeNavigationStack.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/27/25.
//

import SwiftUI
import Navigator
import Container

public struct HomeNavigationStack: View {
    @State private var destination: HomeDestinations = .list
    
    public init() { }
    
    public var body: some View {
        ManagedNavigationStack {
            HomeDestinationsView(destination: destination)
                .navigationDestination(HomeDestinations.self)
        }
    }
}

public enum HomeDestinations: NavigationDestination {
    case list
    case productItem(String?)
    case transaction(String?)
    
    public var view: some View {
        HomeDestinationsView(destination: self)
    }
}

private struct HomeDestinationsView: View {
    let destination: HomeDestinations
    
    @Environment(\.container) var container: Container
    
    var body: some View {
        switch destination {
        case .list:
            HomeView(vm: HomeViewModel(service: container.productService))
        case let .productItem(id):
            EmptyView()
//            ProductDetailsView(product: product, service: container.productService)
        default:
            EmptyView()
        }
    }
}
