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
    }
    
    private func loadTransactions() {
        transactions = realmStore.getTransactions()
    }

}
