//
//  TransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/9/21.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var totalSpendings: Double = 0
    
    private let realmStore = RealmStore.shared
    
    init() {
        loadTransactions()
        realmStore.addTransactionDelegate(delegate: self)
    }
    
    private func loadTransactions() {
        transactions = realmStore.getTransactions()
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }

}

extension TransactionViewModel: TransactionDelegate {
    func update(transactions: [Transaction]) {
        DispatchQueue.main.async {
            self.transactions = transactions
        }
    }
}
