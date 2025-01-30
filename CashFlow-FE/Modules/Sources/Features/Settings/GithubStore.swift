//
//  GithubStore.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import UnidirectionalFlow
import Networking
import MyNavigator

typealias GithubStore = Store<GithubState, GithubAction>

struct GithubState: Equatable, Sendable {
    var repos: [Repo] = []
    var isLoading = false
}

enum GithubAction: Equatable, Sendable {
    case search(query: String)
    case setResults(repos: [Repo])
}

struct GithubReducer: Reducer {
    func reduce(oldState: GithubState, with action: GithubAction) -> GithubState {
        var state = oldState
        
        switch action {
        case .search:
            state.isLoading = true
        case let .setResults(repos):
            state.repos = repos
            state.isLoading = false
        }
        
        return state
    }
}

actor GithubMiddleware: Middleware {
    private let service: GithubService

    init(service: GithubService) {
        self.service = service
    }
    
    func process(state: GithubState, with action: GithubAction) async -> GithubAction? {
        switch action {
        case let .search(query):
            let results = try? await service.search(query)
            guard !Task.isCancelled else {
                return .setResults(repos: state.repos)
            }
            return .setResults(repos: results?.items ?? [])
        default:
            return nil
        }
    }
}
