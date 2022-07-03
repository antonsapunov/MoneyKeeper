//
//  StatisticsViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

import Combine
import Foundation

class StatisticsViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    @Published var totalSpendings: Double = 0
    
    private let transactionRepository: TransactionRepositoryProtocol = TransactionRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var startDate = Date()
    var endDate = Date()
    
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
            self.totalSpendings = categories.map { $0.getCategoryAmount() }.reduce(0, +)
        }
    }
}
