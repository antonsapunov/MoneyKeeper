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
    let icon: Image
    let order: Int
    var transactions: [Transaction]
    
    init(type: CategoryType) {
        self.type = type
        self.name = type.defaultName
        self.icon = type.defaultImage
        self.order = type.defaultOrder
        self.transactions = []
    }
    
    func getCategoryAmount() -> Double {
        return transactions.compactMap({ $0.amount }).reduce(0, +)
    }
    
    
}
