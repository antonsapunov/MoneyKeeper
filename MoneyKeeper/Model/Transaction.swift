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
    let date: Date
    
    init(categoryType: CategoryType) {
        id = ""
        self.categoryType = categoryType
        direction = .outgoing
        comment = ""
        amount = 0
        currency = "USD"
        date = Date()
    }
    
    init(id: String, categoryType: CategoryType, direction: TransactionDirection, comment: String, amount: Double, currency: String, date: Date) {
        self.id = id
        self.categoryType = categoryType
        self.direction = direction
        self.comment = comment
        self.amount = amount
        self.currency = currency
        self.date = date
    }
}

extension Transaction {
    init?(realmTransaction: RealmTransaction) {
        guard let transactionCategoryType = CategoryType(rawValue: realmTransaction.categoryType),
              let transactionDirection = TransactionDirection(rawValue: realmTransaction.direction) else {
            return nil
        }
        id = realmTransaction.id
        categoryType = transactionCategoryType
        direction = transactionDirection
        comment = realmTransaction.comment
        amount = realmTransaction.amount
        currency = realmTransaction.currency
        date = realmTransaction.date
    }
}

enum TransactionDirection: String {
    case incoming
    case outgoing
}
