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
        realmStore.addTransactionDelegate(delegate: self)
        blabla
    }
    
    func deleteTransaction(transactionID: String) {
        realmStore.deleteTransaction(transactionID: transactionID)
    }
    
    private func getTransactionsByDate(_ transactions: [Transaction]) -> [String: [Transaction]] {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.transactionDate
        return Dictionary(
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
        let transactionsByDate = getTransactionsByDate(transactions)
        DispatchQueue.main.async {
            self.transactionsByDate = transactionsByDate
        }
    }
}
