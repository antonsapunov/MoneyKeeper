//
//  CategoryType.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

indirect enum CategoryType {
    
    case food
    case transport
    case shopping
    case entertainment
    case service
    case add
    case custom(Category)
    
    var id: String {
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
        case .add:
            return "Add"
        case .custom(let category):
            return category.id.uuidString
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
        case .add:
            return "Add"
        case .custom(let category):
            return category.name
        }
    }
    
    var image: Image {
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
        case .add:
            return Image(systemName: "plus")
        case .custom(let category):
            return category.icon
        }
    }
}
