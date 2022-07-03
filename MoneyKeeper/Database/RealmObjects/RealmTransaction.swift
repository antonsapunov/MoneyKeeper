//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift

class RealmTransaction: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var categoryType: String = CategoryType.food.rawValue
    @objc dynamic var direction: String = TransactionDirection.incoming.rawValue
    @objc dynamic var comment: String = ""
    @objc dynamic var amount: Double = 0
    @objc dynamic var currency: String = "$"
    @objc dynamic var date: Date!
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

extension RealmTransaction {
    convenience init(transaction: Transaction) {
        self.init()
        categoryType = transaction.categoryType.rawValue
        direction = transaction.direction.rawValue
        comment = transaction.comment
        amount = transaction.amount
        currency = transaction.currency
        date = transaction.date
    }
    
    convenience init(categoryType: CategoryType, comment: String?, direction: TransactionDirection, amount: Double) {
        self.init()
        self.categoryType = categoryType.rawValue
        self.direction = direction.rawValue
        self.comment = comment ?? ""
        self.amount = amount
        currency = "$"
        date = Date()
    }
}
