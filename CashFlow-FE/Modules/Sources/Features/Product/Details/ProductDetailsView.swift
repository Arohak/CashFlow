//
//  ProductDetailsView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import Views
import Shared
import Networking
import Navigator

public struct ProductDetailsView: View {
    @Environment(\.navigator) var navigator: Navigator

    @State var store: ProductStore

    public init(product: ProductDTO, service: ProductService) {
        self.store = ProductStore(product: product, service: service)
    }
    
    public var body: some View {
        VStack {
            if let product = store.product {
                ProductView(title: product.title, category: product.category, price: product.price, thumbnail: "")
            } else {
                Text("Loading")
            }
            
            VStack {
                ZStack {
                    ProgressView()
                        .controlSize(.regular)
                        .tint(.blue)
                        .opacity(store.isLoading ? 1 : 0)
                    
                    Button("Refresh") {
                        store.fetchProduct()
                    }
                    .buttonStyle(.plain)
                    .opacity(store.isLoading ? 0 : 1)
                }
                .padding()
                
                HStack {
                    Button("Back") {
                        navigator.pop()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Root") {
                        navigator.popAll()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProductDetailsView(product: .mock, service: .mock)
}
