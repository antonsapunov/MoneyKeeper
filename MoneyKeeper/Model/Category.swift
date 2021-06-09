//
//  Category.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let type: CategoryType
    let name: String
    let color: UIColor
    let icon: UIImage
    let order: Int
    var amount: Double
    
    init(type: CategoryType, amount: Double = 0) {
        self.type = type
        self.name = type.defaultName
        self.color = type.defaultColor
        self.icon = type.defaultImage
        self.order = type.defaultOrder
        self.amount = amount
    }
    
    init(type: CategoryType, color: UIColor, order: Int, amount: Double = 0) {
        self.type = type
        self.name = type.defaultName
        self.color = color
        self.icon = type.defaultImage
        self.order = order
        self.amount = amount
    }
}
