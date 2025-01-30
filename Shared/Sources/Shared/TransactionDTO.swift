//
//  TransactionDTO.swift
//  Shared
//
//  Created by Ara Hakobyan on 1/22/25.
//

import Foundation

public struct TransactionDTO: Identifiable, Equatable, Codable, Sendable {
    public let id: UUID?
    public let type: TransactionType
    public let category: CategoryDTO
//    public let repeatType: RepeatType
    public let value: Double
//    public let date: Date?
    public let note: String?
    
    public init(id: UUID?, type: TransactionType, category: CategoryDTO, value: Double, note: String?) {
        self.id = id
        self.type = type
        self.category = category
        self.value = value
        self.note = note
    }
}

public enum TransactionType: String, Codable, Sendable {
    case expense, income
}

public enum RepeatType: String, Codable, Sendable {
    case never, daily, weekly, biweekly, mountly, quarterly, yearly
}
