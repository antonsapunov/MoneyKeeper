//
//  CategoryType.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

enum CategoryType {
    
    case food
    case transport
    case shopping
    case entertainment
    case service
    
    init(stringValue: String) {
        switch stringValue {
        case "food":
            self = .food
        case "transport":
            self = .transport
        case "shopping":
            self = .shopping
        case "entertainment":
            self = .entertainment
        case "service":
            self = .service
        default:
            fatalError("\(stringValue) category not found")
        }
    }
    
    var id: String {
        switch self {
        case .food:
            return "food"
        case .transport:
            return "transport"
        case .shopping:
            return "shopping"
        case .entertainment:
            return "entertainment"
        case .service:
            return "service"
        }
    }
    
    var name: String {
        switch self {
        case .food:
            return "Food"
        case .transport:
            return "Transport"
        case .shopping:
            return "Shopping"
        case .entertainment:
            return "Entertainment"
        case .service:
            return "Service"
        }
    }
    
    var image: UIImage {
        switch self {
        case .food:
            return UIImage(named: "food")!
        case .transport:
            return UIImage(systemName: "car")!
        case .shopping:
            return UIImage(systemName: "bag")!
        case .entertainment:
            return UIImage(systemName: "tv")!
        case .service:
            return UIImage(systemName: "heart.circle")!
        }
    }
}
