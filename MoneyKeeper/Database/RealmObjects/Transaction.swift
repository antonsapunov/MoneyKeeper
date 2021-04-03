//
//  Transaction.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift

class Transaction: Object {
    
    @objc dynamic var categoryType: String = CategoryType.food.identifier
    @objc dynamic var amount: Int = 0
    @objc dynamic var currency: String = "$"
    
}
