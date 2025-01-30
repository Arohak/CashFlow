//
//  HomeApp.swift
//  HomeFeatureApp
//
//  Created by Ara Hakobyan on 1/2/25.
//

import SwiftUI
import Home

@main
struct HomeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeNavigationStack()
                .environment(\.container, .live)
        }
    }
}

#Preview {
    HomeNavigationStack()
        .environment(\.container, .mock)
}
