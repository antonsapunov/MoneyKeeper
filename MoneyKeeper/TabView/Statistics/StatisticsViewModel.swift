//
//  StatisticsViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Foundation

class StatisticsViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    @Published var totalSpendings: Double = 0
    
    private let realmStore = RealmStore.shared
    
    init() {
        realmStore.addCategoryDelegate(delegate: self)
    }
    
    deinit {
        realmStore.removeDelegate(delegate: self)
    }
}

extension StatisticsViewModel: CategoryDelegate {
    func update(categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.totalSpendings = categories.map { $0.amount }.reduce(0, +)
        }
    }
}
