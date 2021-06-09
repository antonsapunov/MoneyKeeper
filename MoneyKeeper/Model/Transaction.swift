//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/10/21.
//

import Foundation

struct Transaction {
    let id = UUID()
    let categoryType: CategoryType
    let amount: Double
    let currency: String
    let time: Date
}
