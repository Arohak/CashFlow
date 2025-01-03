//
//  ContentView.swift
//  CashFlow FE
//
//  Created by Ara Hakobyan on 1/1/25.
//

import SwiftUI
import Navigator
import Home
import Detail

struct RootView: View {
    @State private var navigator = Navigator<Route>()
    
    public var body: some View {
        NavigationStack(path: $navigator.route) {
            VStack {
                Button("Home") {
                    navigator.push(.home)
                }
                .buttonStyle(.plain)
                
                Button("Detail") {
                    navigator.push(.detail(UUID()))
                }
                .buttonStyle(.plain)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView(vm: HomeViewModelImpl(service: .live, navigator: navigator))
                case let .detail(id):
                    DetailView(vm: DetailViewModelImpl(id: id, service: .live, navigator: navigator))
                }
            }
        }
    }
}

#Preview {
    RootView()
}
