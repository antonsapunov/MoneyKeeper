//
//  DashboardViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Foundation
import RealmSwift

class DashboardViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    private let realmStore = RealmStore.shared
    
    init() {
        realmStore.addCategoryDelegate(delegate: self)
    }
    
    func createTransaction(category: Category, direction: TransactionDirection, amount: String) {
        guard let amountDouble = Double(amount) else { return }
        
        realmStore.createTransaction(categoryType: category.type, direction: direction, amount: amountDouble)
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }
}

extension DashboardViewModel: CategoryDelegate {
    func update(categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
        }
    }
}
