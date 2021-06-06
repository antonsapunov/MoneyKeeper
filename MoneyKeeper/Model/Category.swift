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
    var amount: Double
    
    init(type: CategoryType, color: UIColor, amount: Double = 0) {
        self.type = type
        self.name = type.name
        self.color = color
        self.icon = type.image
        self.amount = amount
    }
}
