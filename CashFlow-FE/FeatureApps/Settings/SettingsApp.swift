//
//  GithubApp.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/26/25.
//


import SwiftUI

@main
struct SettingsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.container, .live)
        }
    }
}
