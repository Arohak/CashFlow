//
//  DetailView.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import SwiftUI
import Models
import Views

public struct DetailView<VM: DetailViewModel>: View {
    @State var vm: VM
    
    public init(vm: VM) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack {
            if let product = vm.product {
                ProductView(title: product.title, category: product.category, price: product.price)
            } else {
                Text("Loading")
            }
        }
        .padding()
        .task {
            vm.fetchProduct()
        }
    }
}

#Preview {
    DetailView(vm: DetailViewModelImpl(id: nil, service: .mock, navigator: .init()))
}
