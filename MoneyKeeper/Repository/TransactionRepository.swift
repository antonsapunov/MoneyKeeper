//
//  TransactionRepository.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 7/3/22.
//

import Foundation
import Combine

protocol TransactionRepositoryProtocol {
    var getTransactionSubject: PassthroughSubject<Transaction?, Never> { get }
    var transactionsSubject: PassthroughSubject<[Transaction], Never> { get }
    func getTransaction(by transactionID: String)
    func deleteTransaction(by transactionID: String)
    func getTransactionsFilteredByDate(startDate: Date, endDate: Date) -> [String : [Transaction]]
}

class TransactionRepository: TransactionRepositoryProtocol {
    
    var getTransactionSubject = PassthroughSubject<Transaction?, Never>()
    var transactionsSubject = PassthroughSubject<[Transaction], Never>()
    
    private let realmStore = RealmStore.shared
    private var allTransactionsByDate: [String: [Transaction]] = [:]
    
    init() {
        realmStore.addTransactionDelegate(delegate: self)
    }
    
    func getTransaction(by transactionID: String) {
        realmStore.getTransaction(transactionID: transactionID) { [weak self] transaction in
            self?.getTransactionSubject.send(transaction)
        }
    }
    
    func deleteTransaction(by transactionID: String) {
        realmStore.deleteTransaction(transactionID: transactionID)
    }
    
    func getTransactionsFilteredByDate(startDate: Date, endDate: Date) -> [String : [Transaction]] {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.transactionDate
        return allTransactionsByDate.filter { element in
            guard let transactionDate = formatter.date(from: element.key) else {
                return false
            }
            return transactionDate >= startDate && transactionDate <= endDate
        }
    }
    
    private func updateAllTransactionsByDate(_ transactions: [Transaction]) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.transactionDate
        allTransactionsByDate = Dictionary(
            grouping: transactions,
            by: { $0.date.transform(with: formatter) }
        )
        transactionsSubject.send(transactions)
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }
}

extension TransactionRepository: TransactionDelegate {
    func update(transactions: [Transaction]) {
        updateAllTransactionsByDate(transactions)
    }
}
