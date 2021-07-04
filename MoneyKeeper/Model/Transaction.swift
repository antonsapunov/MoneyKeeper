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
}

enum TransactionDirection: String {
    case incoming
    case outgoing
}
