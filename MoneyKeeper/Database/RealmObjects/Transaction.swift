//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift

class Transaction: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var categoryType: String = CategoryType.food.id
    @objc dynamic var amount: Double = 0
    @objc dynamic var currency: String = "$"
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
