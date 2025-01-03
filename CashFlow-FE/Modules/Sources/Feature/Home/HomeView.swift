//
//  HomeView.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import SwiftUI
import Shared
import Views

public struct HomeView<VM: HomeViewModel>: View {
    @State var vm: VM
    
    public init(vm: VM) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack {
            if let products = vm.products {
                GridView(for: products)
            } else {
                Text("Loading")
            }
        }
        .task {
            vm.fetchProducts()
        }
    }
    
    func GridView(for products: [ProductDTO]) -> some View {
//        let columns = Array(repeating: GridItem(.flexible()), count: 2)
        let columns = [GridItem(.adaptive(minimum: 250), spacing: 20)]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products) { product in
                    ProductView(title: product.title, category: product.category, price: product.price)
                        .onTapGesture {
                            vm.showDetail(for: product)
                        }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView(vm: HomeViewModelImpl(service: .live, navigator: .init()))
}
