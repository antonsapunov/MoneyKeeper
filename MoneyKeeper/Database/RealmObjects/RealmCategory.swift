//
//  RealmCategory.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Foundation
import RealmSwift

class RealmCategory: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var type: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var icon: Data = Data()
    @objc dynamic var order: Int = 0
    @objc dynamic var amount: Double = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
