//
//  StatisticsViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Foundation

class StatisticsViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        CategoryModel(categoryType: .food).category,
        CategoryModel(categoryType: .transport).category,
        CategoryModel(categoryType: .shopping).category,
        CategoryModel(categoryType: .entertainment).category,
        CategoryModel(categoryType: .service).category
    ]
    
    @Published var totalSpendings: Double = 0
    
    private let transactionStore = TransactionStore.shared
    
    init() {
        transactionStore.addDelegate(delegate: self)
    }
    
    deinit {
        transactionStore.removeDelegate(delegate: self)
    }
}

extension StatisticsViewModel: CategoryDelegate {
    func update(categories: [Category]) {
        self.categories = categories
        totalSpendings = categories.map { $0.amount }.reduce(0, +)
    }
}
