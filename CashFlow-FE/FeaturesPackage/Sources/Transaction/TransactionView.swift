//
//  TransactionView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/23/25.
//

import SwiftUI
import Networking
import MyNavigator
import Shared
import Navigator

public struct TransactionView: View {
    @Environment(\.navigator) var navigator: Navigator

    @State private var store: TransactionStore
    
    public init(service: ITransactionService) {
        self.store = TransactionStore(
            initialState: .init(),
            reducer: TransactionReducer(),
            middlewares: [TransactionMiddleware(service: service)]
        )
    }
    
    public var body: some View {
        NavigationView {
            List(store.list) { item in
                HStack(spacing: 16) {
                    // Category icon or indicator
                    Circle()
                        .fill(item.value >= 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: item.type == .income ? "arrow.down" : "arrow.up")
                                .foregroundColor(item.type == .income ? .green : .red)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.category.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(item.type.rawValue)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Amount with currency formatting
                    Text(formatCurrency(value: item.value))
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(item.type == .income ? .green : .red)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
            .task {
                await store.send(.appear)
            }
            .navigationTitle("Transactions")
            .navigationBarItems(trailing: AddButton(action: {
                navigator.navigate(to: TransactionDestinations.add(TransactionAddDependencies(action: { item in
                    await store.send(.save(item))
                })))
            }))
        }
    }
}

// Helper views and functions
private func AddButton(action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: "plus")
            .resizable()
            .padding(8)
            .frame(width: 32, height: 32)
            .background(Color.accentColor)
            .clipShape(Circle())
            .foregroundColor(.white)
    }
}

private func formatCurrency(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD" // You might want to make this configurable
    return formatter.string(from: NSNumber(value: abs(value))) ?? "$\(abs(value))"
}

#Preview {
    TransactionView(service: MockTransactionService())
}
