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
        realmStore.addDelegate(delegate: self)
    }
    
    func createTransaction(category: Category, amount: String) {
        guard let amountDouble = Double(amount) else { return }
        
        realmStore.createTransaction(category: category, amount: amountDouble)
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }
}

extension DashboardViewModel: CategoryDelegate {
    func update(categories: [Category]) {
        self.categories = categories
    }
}
