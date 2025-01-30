//
//  RootView2.swift
//  CashFlow-FE
//
//  Created by Ara Hakobyan on 1/26/25.
//

import SwiftUI
import MyNavigator
import Container

struct ContentView: View {
    @Environment(\.navigate) var navigate

    var body: some View {
        VStack {
            Button("Home") {
                navigate(.home(.list))
            }
            Button("Product") {
                navigate(.product(.list))
            }
            Button("Transaction") {
                navigate(.transaction(.list))
            }
            Button("GithubView") {
                navigate(.github)
            }
        }
    }
}

struct RootView1: View {
    @State private var routes: [Route] = []
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
        
    var body: some View {
        NavigationStack(path: $routes) {
            ContentView()
                .navigationDestination(for: Route.self) { route in
                    route.destination(with: container)
                }
        }
        .environment(\.navigate, NavigationAction { routes.append($0) })
    }
}

//struct RootView1: View {
//    @State private var navigator = MyNavigator<Route>()
//    private let container: AppContainer
//    
//    public init(container: AppContainer) {
//        self.container = container
//    }
//    
//    public var body: some View {
//        NavigationStack(path: $navigator.route) {
//            VStack {
//                Button("Home") {
//                    navigator.push(.home(.list))
//                }
//                Button("Product") {
//                    navigator.push(.product(.list))
//                }
//                Button("Transaction") {
//                    navigator.push(.transaction(.list))
//                }
//                Button("GithubView") {
//                    navigator.push(.github)
//                }
//            }
//            .navigationDestination(for: Route.self) { route in
//                route.destination(with: container)
//            }
//        }
//    }
//}

#Preview {
    RootView1(container: .live)
}
