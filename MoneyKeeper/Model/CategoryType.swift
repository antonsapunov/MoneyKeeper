//
//  CategoryType.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

enum CategoryType: String {
    
    case food
    case transport
    case shopping
    case entertainment
    case service
    
    var defaultName: String {
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
    
    var defaultImage: UIImage {
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
    
    var defaultOrder: Int {
        switch self {
        case .food:
            return 1
        case .transport:
            return 2
        case .shopping:
            return 3
        case .entertainment:
            return 4
        case .service:
            return 5
        }
    }
}
