//
//  RootView.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/28/25.
//

import SwiftUI
import Container
import Product

struct RootView: View {
    @Environment(\.container) var container: Container

    var body: some View {
        ProductFeedView(service: container.productService)
    }
}

#Preview {
    RootView()
        .environment(\.container, .mock)
}
