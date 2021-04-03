//
//  RealmManager.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    private init() {}
    
    static let shared = RealmManager()
    
    func addTransaction(categoryType: CategoryType, amount: Int) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let transaction = Transaction()
                transaction.categoryType = categoryType.identifier
                transaction.amount = amount
                transaction.currency = "$"
                let realm = try! Realm()
                try! realm.write {
                    realm.add(transaction)
                }
            }
        }
    }
}
