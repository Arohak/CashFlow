//
//  RootView.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/27/25.
//

import SwiftUI
import Container
import Home
import Transaction
import Product
import Settings

enum AppScreen: String, CaseIterable, Identifiable {
    case home
    case product
    case transaction
    case settings

    var id: AppScreen { self }
    
    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:  HomeNavigationStack()
        case .product: ProductNavigationStack()
        case .transaction: TransactionNavigationStack()
        case .settings: GithubNavigationStack()
        }
    }
    
    var info: (title: String, icon: String) {
        switch self {
        case .home: return ("Home", "house")
        case .product: return ("Stats", "chart.bar.fill")
        case .transaction: return ("Budget", "chart.bar.horizontal.page.fill")
        case .settings: return ("Settings", "gearshape.fill")
        }
    }
}

struct RootView: View {
    @State var selection: AppScreen = .home
    
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen)
                    .tabItem {
                        VStack {
                            Image(systemName: screen.info.icon)
                            Text(screen.info.title)
                        }
                    }
            }
        }
        .environment(\.container, container)
    }
}

#Preview {
    RootView(container: .live)
}
