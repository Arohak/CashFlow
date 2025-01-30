//
//  CategoryDTO.swift
//  Shared
//
//  Created by Ara Hakobyan on 1/22/25.
//

import Foundation

public struct CategoryDTO: Identifiable, Equatable, Codable, Sendable {
    public let id: UUID?
    public let name: String
    public let info: String?
    
    public init(id: UUID?, name: String, info: String?) {
        self.id = id
        self.name = name
        self.info = info
    }
}
