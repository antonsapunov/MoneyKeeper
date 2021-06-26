//
//  TransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/9/21.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var transactionsByDate: [String: [Transaction]] = [:]
    @Published var totalSpendings: Double = 0
    
    private let realmStore = RealmStore.shared
    
    init() {
        loadTransactions()
        realmStore.addTransactionDelegate(delegate: self)
    }
    
    private func loadTransactions() {
        let transactions = realmStore.getTransactions()
        groupTransactionsByDate(transactions)
    }
    
    private func groupTransactionsByDate(_ transactions: [Transaction]) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.transactionDate
        transactionsByDate = Dictionary(
            grouping: transactions,
            by: { $0.time.transform(with: formatter) }
        )
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }

}

extension TransactionViewModel: TransactionDelegate {
    func update(transactions: [Transaction]) {
        DispatchQueue.main.async {
            self.groupTransactionsByDate(transactions)
        }
    }
}
