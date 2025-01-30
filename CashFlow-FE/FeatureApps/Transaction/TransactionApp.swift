//
//  TransactionApp.swift
//  TransactionApp
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import Transaction

@main
struct TransactionApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionNavigationStack()
                .environment(\.container, .live)
        }
    }
}

#Preview {
    TransactionNavigationStack()
        .environment(\.container, .mock)
}
