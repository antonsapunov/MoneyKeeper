//
//  RealmManager.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift

protocol CategoryDelegate: AnyObject {
    func update(transactions: [String: [Transaction]])
}

final class TransactionStore: ObservableObject {
    
    private weak var categoryDelegate: CategoryDelegate?
    
    init(categoryDelegate: CategoryDelegate?) {
        self.categoryDelegate = categoryDelegate
        do {
            let realm = try Realm()
            transactionResults = realm.objects(Transaction.self)
            addTransactionObserver()
        } catch let error {
          fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
        }
    }
    
//    @Published var categories: [Category] = [
//        CategoryModel(categoryType: .food).category,
//        CategoryModel(categoryType: .transport).category,
//        CategoryModel(categoryType: .shopping).category,
//        CategoryModel(categoryType: .entertainment).category,
//        CategoryModel(categoryType: .service).category
//    ]
    
//    @Published var totalSpendings: Double = 0

    var transactions: [Transaction] {
        Array(transactionResults)
    }
    
    private var transactionResults: Results<Transaction>
    private var transactionsNotificationToken: NotificationToken?
    
    func createTransaction(category: Category, amount: Double) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let transaction = Transaction()
                transaction.categoryType = category.type.id
                transaction.amount = amount
                transaction.currency = "$"
                let realm = try! Realm()
                try! realm.write {
                    realm.add(transaction, update: .modified)
                }
            }
        }
    }
    
    func deleteTransaction(transaction: Transaction) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(transaction)
                }
            }
        }
    }
    
    private func addTransactionObserver() {
        transactionsNotificationToken = transactionResults.observe { [weak self] changes in
            guard let self = self else { return }
            var transactionByCategory: [String: [Transaction]] = [:]
            switch changes {
            case .initial(let transactions):
                transactionByCategory = Dictionary(grouping: transactions) { $0.categoryType }
                self.categoryDelegate?.update(transactions: transactionByCategory)
            case .update(let transactions, _, _, _):
                transactionByCategory = Dictionary(grouping: transactions) { $0.categoryType }
                self.categoryDelegate?.update(transactions: transactionByCategory)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }

    }

    private func removeTransactionObserver() {
        transactionsNotificationToken?.invalidate()
    }
    
    deinit {
        removeTransactionObserver()
    }
    
}
