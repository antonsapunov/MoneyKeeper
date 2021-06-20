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
    let icon: UIImage
    let order: Int
    var amount: Double
    
    init(type: CategoryType, amount: Double = 0) {
        self.type = type
        self.name = type.defaultName
        self.icon = type.defaultImage
        self.order = type.defaultOrder
        self.amount = amount
    }
    
    init(type: CategoryType, order: Int, amount: Double = 0) {
        self.type = type
        self.name = type.defaultName
        self.icon = type.defaultImage
        self.order = order
        self.amount = amount
    }
}
