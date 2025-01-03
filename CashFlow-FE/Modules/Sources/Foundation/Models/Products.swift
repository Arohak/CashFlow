//
//  Products.swift
//  Modularization
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Foundation
import Shared

public struct Response: Decodable {
    public let products: [ProductDTO]
}

//public struct Product: Decodable, Identifiable, Sendable {
//    public let id: Int
//    public let title: String
//    public let category: String
//    public let price: Double
//    public let thumbnail: String
//    
//    public init(id: Int, title: String, category: String, price: Double, thumbnail: String) {
//        self.id = id
//        self.title = title
//        self.price = price
//        self.category = category
//        self.thumbnail = thumbnail
//    }
//}
