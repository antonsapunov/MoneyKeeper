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
    let color: Color
    let icon: Image
    var amount: Double = 0
    
    init(type: CategoryType, color: Color) {
        self.type = type
        self.name = type.name
        self.color = color
        self.icon = type.image
    }
}


