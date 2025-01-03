//
//  HomeFeatureAppApp.swift
//  HomeFeatureApp
//
//  Created by Ara Hakobyan on 1/2/25.
//

import SwiftUI
import Home

@main
struct HomeFeatureAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(vm: HomeViewModelImpl(service: .live, navigator: .init()))
        }
    }
}
