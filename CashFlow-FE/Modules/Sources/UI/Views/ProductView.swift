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

    public init(title: String, category: String, price: Double) {
        self.title = title
        self.category = category
        self.price = price
    }
    
    public var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text(category)
                    .font(.title)
                    .foregroundStyle(.orange)
                Spacer()
            }
            HStack {
                Text(title)
                    .font(.title2)
                Text("$ \(price)")
                    .font(.title2)
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
    }
}
