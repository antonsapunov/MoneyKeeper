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