//
//  TransactionStore.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/24/25.
//

import UnidirectionalFlow
import Networking
import Shared

typealias TransactionStore = Store<TransactionState, TransactionAction>

struct TransactionState: Equatable, Sendable {
    var list: [TransactionEntity] = []
    var isLoading = false
}

enum TransactionAction: Equatable, Sendable {
    case appear
    case update(list: [TransactionEntity])
    case save(TransactionEntity)
}

struct TransactionReducer: Reducer {
    func reduce(oldState: TransactionState, with action: TransactionAction) -> TransactionState {
        var state = oldState
        
        switch action {
        case .appear:
            state.isLoading = true
        case let .update(items):
            state.list = items
            state.isLoading = false
        case .save:
            break
        }
        
        return state
    }
}

actor TransactionMiddleware: Middleware {
    private let service: ITransactionService

    init(service: ITransactionService) {
        self.service = service
    }
    
    func process(state: TransactionState, with action: TransactionAction) async -> TransactionAction? {
        switch action {
        case .appear:
            let result = try? await service.items()
            guard !Task.isCancelled else {
                return .update(list: state.list)
            }
            return .update(list: result ?? [])
        case let .save(item):
            _ = try? await service.create(item)
            return .appear
        default:
            return nil
        }
    }
}
