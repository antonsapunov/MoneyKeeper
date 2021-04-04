//
//  DashboardViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Foundation
import RealmSwift

class DashboardViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        CategoryModel(categoryType: .food).category,
        CategoryModel(categoryType: .transport).category,
        CategoryModel(categoryType: .shopping).category,
        CategoryModel(categoryType: .entertainment).category,
        CategoryModel(categoryType: .service).category
    ]
    
    private var transactionStore: TransactionStore!
    
    init() {
        transactionStore = TransactionStore(categoryDelegate: self)
    }
    
    func createTransaction(category: Category, amount: String) {
        guard let amountDouble = Double(amount) else { return }
        
        transactionStore.createTransaction(category: category, amount: amountDouble)
    }
}

extension DashboardViewModel: CategoryDelegate {
    func update(transactions: [String: [Transaction]]) {
        for key in transactions.keys {
            if let index = categories.firstIndex(where: { $0.type.id == key }),
               let amount = transactions[key]?.compactMap({ $0.amount }).reduce(0, +) {
                categories[index].amount = amount
            }
        }
    }
}
