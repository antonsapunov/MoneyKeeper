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
    
    private let transactionStore = TransactionStore.shared
    
    init() {
        transactionStore.addDelegate(delegate: self)
    }
    
    func createTransaction(category: Category, amount: String) {
        guard let amountDouble = Double(amount) else { return }
        
        transactionStore.createTransaction(category: category, amount: amountDouble)
    }
    
    deinit {
        transactionStore.removeDelegate(delegate: self)
    }
}

extension DashboardViewModel: CategoryDelegate {
    func update(categories: [Category]) {
        self.categories = categories
    }
}
