//
//  Router.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/29/24.
//

import Observation
import Foundation
import SwiftUI

@MainActor
@Observable
public final class Router<Route: Hashable> {
    public var route = [Route]()
    public init() {}
}

public extension Router {
    func pop() {
        route.removeLast()
    }
    
    func push(_ route: Route) {
        self.route.append(route)
    }
    
    func popToRoot() {
        route.removeAll()
    }
}

