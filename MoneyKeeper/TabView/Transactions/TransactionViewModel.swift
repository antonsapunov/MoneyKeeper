//
//  TransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/9/21.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var currentTransactionsByDate: [String: [Transaction]] = [:]
    @Published var totalSpendings: Double = 0
    @Published var transactionForUdpate: Transaction?
    
    private var allTransactionsByDate: [String: [Transaction]] = [:] {
        didSet {
            filterTransactionsByDate(startDate: startDate, endDate: endDate)
        }
    }
    
    var startDate = Date()
    var endDate = Date()
    
    private let realmStore = RealmStore.shared
    private var filterState: FilterState = .initial
    
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
        if filterState == .initial {
            startDate = transactions.last?.time.removeTimeStamp() ?? Date()
        }
        return Dictionary(
            grouping: transactions,
            by: { $0.time.transform(with: formatter) }
        )
    }
    
    func filterTransactionsByDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        filterState = .set
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.transactionDate
        currentTransactionsByDate = allTransactionsByDate.filter { element in
            guard let transactionDate = formatter.date(from: element.key) else {
                return false
            }
            return transactionDate >= startDate && transactionDate <= endDate
        }
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }

}

extension TransactionViewModel: TransactionDelegate {
    func update(transactions: [Transaction]) {
        let transactionsByDate = getTransactionsByDate(transactions)
        DispatchQueue.main.async {
            self.allTransactionsByDate = transactionsByDate
        }
    }
}
