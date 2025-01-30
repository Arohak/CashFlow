//
//  ProductFeedApp.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/28/25.
//

import SwiftUI

@main
struct ProductFeedApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.container, .live)
        }
    }
}
