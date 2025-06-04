//
//  HomeView.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import SwiftUI
import Shared
import Views
import Networking
import Navigator

public struct HomeView<VM: IHomeViewModel>: View {
    @Environment(\.navigator) var navigator: Navigator

    @State var vm: VM
    
    public init(vm: VM) {
        self.vm = vm
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    if let products = vm.products {
                        ProductGridView(products: products, onProductTap: { product in
                            navigator.push(HomeDestinations.productItem(product.id?.uuidString))
                        })
                    } else {
                        LoadingView()
                    }
                }
//                Group {
//                    if let products = vm.products {
//                        ProductGridView(products: products, onProductTap: { product in
//                            navigator.push(HomeDestinations.productItem(product.id?.uuidString))
//                        })
//                    } else {
//                        LoadingView()
//                    }
//                }
            }
            .navigationTitle("Home")
            .task {
                vm.fetchProducts()
            }
        }
    }
}

// MARK: - Loading View
private struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)
                .tint(.blue)
            
            Text("Loading Products...")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Product Grid View
private struct ProductGridView: View {
    let products: [ProductDTO]
    let onProductTap: (ProductDTO) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 300, maximum: 400), spacing: 16)
                ],
                spacing: 16
            ) {
                ForEach(products) { product in
                    ProductCard(product: product)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onProductTap(product)
                        }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color(.systemGroupedBackground))
        .refreshable {
            // Add pull-to-refresh functionality
            await Task.yield() // Placeholder for actual refresh logic
        }
    }
}

// MARK: - Product Card
private struct ProductCard: View {
    let product: ProductDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product Image
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                // Category Badge
                Text(product.category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                // Title
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                
                // Price
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    HomeView(vm: HomeViewModel(service: .mock))
}
