//
//  RootView.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import Settings
import Container

struct RootView: View {
    @Environment(\.container) var container: Container

    var body: some View {
        GithubView(service: container.githubService)
    }
}

#Preview {
    RootView()
        .environment(\.container, .mock)
}
