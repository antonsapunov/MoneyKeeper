//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/10/21.
//

import Foundation

struct Transaction: Identifiable {
    let id: String
    let categoryType: CategoryType
    let direction: TransactionDirection
    let comment: String
    let amount: Double
    let currency: String
    let time: Date
    
    init(categoryType: CategoryType) {
        id = ""
        self.categoryType = categoryType
        direction = .outgoing
        comment = ""
        amount = 0
        currency = "USD"
        time = Date()
    }
    
    init(id: String, categoryType: CategoryType, direction: TransactionDirection, comment: String, amount: Double, currency: String, time: Date) {
        self.id = id
        self.categoryType = categoryType
        self.direction = direction
        self.comment = comment
        self.amount = amount
        self.currency = currency
        self.time = time
    }
}

enum TransactionDirection: String {
    case incoming
    case outgoing
}
