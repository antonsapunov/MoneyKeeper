//
//  TransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/9/21.
//

import Combine
import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var currentTransactionsByDate: [String: [Transaction]] = [:]
    @Published var totalSpendings: Double = 0
    @Published var transactionForUdpate: Transaction?
    
    private let transactionRepository: TransactionRepositoryProtocol = TransactionRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var startDate = Date()
    var endDate = Date()

    private var filterState: FilterState = .initial
    
    init() {
        transactionRepository.transactionsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transactions in
                self?.updateTransactions(transactions)
            }
            .store(in: &cancellables)
    }
    
    func getTransaction(by transactionID: String) {
        transactionRepository.getTransaction(by: transactionID)
        transactionRepository.getTransactionSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transaction in
                self?.transactionForUdpate = transaction
            }
            .store(in: &cancellables)
    }
    
    func deleteTransaction(by transactionID: String) {
        transactionRepository.deleteTransaction(by: transactionID)
    }
    
    func filterTransactionsByDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        filterState = .set
        currentTransactionsByDate = transactionRepository.getTransactionsFilteredByDate(startDate: startDate, endDate: endDate)
    }
    
    private func updateTransactions(_ transactions: [Transaction]) {
        if filterState == .initial {
            startDate = transactions.last?.date.removeTimeStamp() ?? Date()
        }
        currentTransactionsByDate = transactionRepository.getTransactionsFilteredByDate(startDate: startDate, endDate: endDate)
    }
}
