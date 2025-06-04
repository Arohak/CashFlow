//
//  GithubNavigationStack.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/29/25.
//

import SwiftUI
import Navigator
import Container

public struct GithubNavigationStack: View {
    @State private var destination: GithubDestinations = .list
    
    public init() { }
    
    public var body: some View {
        ManagedNavigationStack {
            GithubDestinationsView(destination: destination)
                .navigationDestination(GithubDestinations.self)
        }
    }
}

public enum GithubDestinations: NavigationDestination {
    case list
    
    public var view: some View {
        GithubDestinationsView(destination: self)
    }
}

private struct GithubDestinationsView: View {
    let destination: GithubDestinations
    
    @Environment(\.container) var container: Container
    
    var body: some View {
        GithubView(service: container.githubService)
    }
}
