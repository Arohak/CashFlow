//
//  GithubService.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/25/25.
//

import Foundation

public struct GithubService: Sendable {
    public let search: @Sendable (String) async throws -> SearchResponse
}

public extension GithubService {
    static func live(url: URL) -> Self {
        .init {
            try await GithubEndpoint.search($0).execute(baseUrl: url, type: SearchResponse.self).value
        }
    }

    static let mock = Self (
        search: { _ in
            SearchResponse(
                items: [
                    Repo(id: 1, name: "Repo1", description: "RepoDesc1"),
                    Repo(id: 2, name: "Repo2", description: "RepoDesc2")
                ]
            )
        }
    )
}

public struct Repo: Identifiable, Equatable, Decodable, Sendable {
    public let id: Int
    public let name: String
    public let description: String?
}

public struct SearchResponse: Decodable, Sendable {
    public let items: [Repo]
}
