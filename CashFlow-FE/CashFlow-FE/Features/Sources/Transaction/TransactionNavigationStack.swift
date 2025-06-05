//
//  TransactionNavigationStack.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/27/25.
//

import SwiftUI
import Navigator
import Container
import Shared

public struct TransactionNavigationStack: View {
    @State private var destination: TransactionDestinations = .list
    
    public init() { }
    
    public var body: some View {
        ManagedNavigationStack {
            TransactionDestinationsView(destination: destination)
                .navigationDestination(TransactionDestinations.self)
        }
    }
}

public struct TransactionAddDependencies: Hashable {
    public static func == (lhs: TransactionAddDependencies, rhs: TransactionAddDependencies) -> Bool {
        lhs.uid == rhs.uid
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    let uid = UUID()
    let action: (TransactionDTO) async -> Void
}

public enum TransactionDestinations: NavigationDestination {
    case list
    case add(TransactionAddDependencies)
    
    public var method: NavigationMethod {
        switch self {
        case .list: .push
        case .add: .sheet
        }
    }
    
    public var view: some View {
        TransactionDestinationsView(destination: self)
    }
}

private struct TransactionDestinationsView: View {
    let destination: TransactionDestinations
    
    @Environment(\.container) var container: Container
    
    var body: some View {
        switch destination {
        case .list:
            TransactionView(service: container.transactionService)
        case let .add(dependencies):
            TransactionCreateView(onSave: dependencies.action)
//            TransactionCreateView(service: container.transactionService)
        }
    }
}

