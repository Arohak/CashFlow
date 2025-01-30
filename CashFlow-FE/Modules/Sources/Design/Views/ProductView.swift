//
//  File.swift
//  
//
//  Created by Ara Hakobyan on 3/29/24.
//

import Foundation
import SwiftUI

public struct ProductView: View {
    let title: String
    let category: String
    let price: Double
    let thumbnail: String
    
    public init(title: String, category: String, price: Double, thumbnail: String) {
        self.title = title
        self.category = category
        self.price = price
        self.thumbnail = thumbnail
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Product Image
            Group {
                if let imageURL = URL(string: thumbnail), !thumbnail.isEmpty {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "photo")
                        .foregroundStyle(.gray)
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(Color.gray.opacity(0.1))
            
            // Product Details
            VStack(alignment: .leading, spacing: 8) {
                // Category badge
                Text(category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                // Title
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Price
                Text("$\(String(format: "%.2f", price))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        ProductView(
            title: "iPhone 14 Pro",
            category: "Smartphones",
            price: 999.99,
            thumbnail: ""
        )
        
        ProductView(
            title: "MacBook Pro 16-inch",
            category: "Laptops",
            price: 2499.99,
            thumbnail: "https://example.com/invalid-image"
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
