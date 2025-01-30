//
//  TransactionEndpoint.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/24/25.
//

import Foundation

enum TransactionEndpoint: Endpoint {
    case items
    case item(String)
    case create(TransactionEntity)
    case update(String, TransactionEntity)
    case delete(String)
    
    case search(String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .items, .item, .search:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .items, .create, .search:
            return "/transactions"
        case let .item(id), let .delete(id), let .update(id, _):
            return "/transactions/\(id)"
        }
    }
    
    var bodyParameters: Any? {
        switch self {
        case let .create(value), let .update(_, value):
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let jsonData = try! encoder.encode(value)
            let string = String(data: jsonData, encoding: .utf8)!
            return string
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .item(value):
            return [.init(name: "q", value: value)]
        default:
            return []
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
