//
//  Screen.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/27/25.
//

import Foundation
import SwiftUI
import Shared

public enum Route: Hashable, Sendable {
    case home(HomeRoute)
    case product(ProductRoute)
    case transaction(TransactionRoute)
    case github
}

public enum HomeRoute: Hashable, Sendable {
    case list, item(UUID)
}

public enum ProductRoute: Hashable, Sendable {
    case list, item(ProductDTO)
}

public enum TransactionRoute: Hashable, Sendable {
    case list, edit, item(String)
}



public struct NavigationAction {
    let action: (Route) -> ()
    public func callAsFunction(_ route: Route) {
        action(route)
    }
    
    public init(action: @escaping (Route) -> Void) {
        self.action = action
    }
}

public extension EnvironmentValues {
    @Entry var navigate = NavigationAction { _ in }
}

