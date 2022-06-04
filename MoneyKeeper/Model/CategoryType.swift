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
            return Constants.food
        case .transport:
            return Constants.transport
        case .shopping:
            return Constants.shopping
        case .entertainment:
            return Constants.entertainment
        case .service:
            return Constants.service
        }
    }
    
    var defaultImage: Image {
        switch self {
        case .food:
            return Image("food")
        case .transport:
            return Image(systemName: "car")
        case .shopping:
            return Image(systemName: "bag")
        case .entertainment:
            return Image(systemName: "tv")
        case .service:
            return Image(systemName: "heart.circle")
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
    
    var defaultColor: Color {
        switch self {
        case .food:
            return .black
        case .transport:
            return .blue
        case .shopping:
            return .yellow
        case .entertainment:
            return .red
        case .service:
            return .purple
        }
    }
}
