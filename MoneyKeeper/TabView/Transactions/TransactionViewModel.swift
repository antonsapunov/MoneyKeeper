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
    @Published var transactionForUdpate: Transaction?
    
    private let realmStore = RealmStore.shared
    
    init() {
        realmStore.addTransactionDelegate(delegate: self)
    }
    
    func getTransaction(by transactionID: String) {
        realmStore.getTransaction(transactionID: transactionID) { [weak self] transaction in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.transactionForUdpate = transaction
            }
        }
    }
    
    func deleteTransaction(by transactionID: String) {
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
