//
//  SearchView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import SwiftUI
import Networking

public struct GithubView: View {
    @State private var store: GithubStore
    @State private var query = ""
    
    public init(service: GithubService) {
        let store = GithubStore(
            initialState: .init(),
            reducer: GithubReducer(),
            middlewares: [GithubMiddleware(service: service)]
        )
        _store = State(wrappedValue: store)
    }
    
    public var body: some View {
        NavigationView {
            List(store.repos) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    
                    if let description = repo.description {
                        Text(description)
                    }
                }
            }
            .redacted(reason: store.isLoading ? .placeholder : [])
            .searchable(text: $query)
            .task(id: query) {
                await store.send(.search(query: query))
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    GithubView(service: .mock)
}
