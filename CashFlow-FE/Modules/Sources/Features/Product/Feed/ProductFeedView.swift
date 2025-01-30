//
//  ProductFeedView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import Views
import Networking
import Navigator

public struct ProductFeedView: View {
    @Environment(\.navigator) var navigator: Navigator

    @State var store: ProductStore

    public init(service: ProductService) {
        self.store = ProductStore(service: service)
    }
    
    public var body: some View {
        NavigationView {
            Group {
                if let products = store.products {
                    List(products) { product in
                        ProductView(title: product.title, category: product.category, price: product.price, thumbnail: "")
                            .onTapGesture {
                                navigator.push(ProductDestinations.item(product))
                            }
                    }
                } else {
                    Text("Loading")
                }
            }
            .navigationTitle("Products")
            .task {
                store.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductFeedView(service: .mock)
}
