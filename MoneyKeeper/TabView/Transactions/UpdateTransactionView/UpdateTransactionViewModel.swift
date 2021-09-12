//
//  UpdateTransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 9/12/21.
//

import Foundation

class UpdateTransactionViewModel: ObservableObject {
    
    private let realmStore = RealmStore.shared
    
    func updateTransaction(transactionID: String, amount: String) {
        guard let amountDouble = Double(amount) else { return }
        realmStore.updateTransaction(transactionID: transactionID, amount: amountDouble)
    }

}
