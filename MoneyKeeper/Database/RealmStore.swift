//
//  RealmStore.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import RealmSwift
import UIKit

protocol CategoryDelegate: AnyObject {
    func update(categories: [Category])
}

class RealmStore {
    
    static let shared = RealmStore()

    private var categories: [Category] = []
    private var transactions: [Transaction] = []
    
    private var categoriesInitial: [Category] = [
        Category(type: .food),
        Category(type: .transport),
        Category(type: .shopping),
        Category(type: .entertainment),
        Category(type: .service),
    ]
    
    private var delegates: [CategoryDelegate?] = []
    
    private var categoryResults: Results<RealmCategory>
    private var transactionResults: Results<RealmTransaction>
    private var transactionsNotificationToken: NotificationToken?
    
    private init() {
        do {
            let realm = try Realm()
            categoryResults = realm.objects(RealmCategory.self).sorted(byKeyPath: "order", ascending: true)
            transactionResults = realm.objects(RealmTransaction.self)
            addTransactionObserver()
            if categoryResults.isEmpty {
                createInitialCategories()
            }
        } catch let error {
            fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
        }
    }
    
    func addDelegate(delegate: CategoryDelegate) {
        weak var delegate = delegate
        delegates.append(delegate)
    }
    
    func removeDelegate(delegate: CategoryDelegate) {
        delegates.removeAll { $0 === delegate }
    }
    
    private func getActualCategories(for results: Results<RealmCategory>? = nil) -> [Category] {
        return Array(results ?? categoryResults).map {
            return Category(type: CategoryType(stringValue: $0.type), amount: $0.amount)
        }
    }
    
    func createInitialCategories() {
        DispatchQueue.global(qos: .utility).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    var categoriesToWrite = [RealmCategory]()
                    for categoryModel in self.categoriesInitial {
                        let category = RealmCategory()
                        category.type = categoryModel.type.id
                        category.name = categoryModel.name
                        category.color = categoryModel.color.encode()!
                        category.icon = categoryModel.icon.pngData()!
                        category.order = categoryModel.order
                        category.amount = categoryModel.amount
                        categoriesToWrite.append(category)
                    }
                    try realm.write {
                        realm.add(categoriesToWrite, update: .modified)
                    }
                    let results = realm.objects(RealmCategory.self).sorted(byKeyPath: "order", ascending: true)
                    let categories = self.getActualCategories(for: results)
                    self.updateUI(with: categories)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func createTransaction(category: Category, amount: Double) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let transaction = RealmTransaction()
                transaction.categoryType = category.type.id
                transaction.amount = amount
                transaction.currency = "$"
                transaction.date = Date()
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(transaction, update: .modified)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func deleteTransaction(transaction: RealmTransaction) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.delete(transaction)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func getTransactions() -> [Transaction] {
        return Array(transactionResults).sorted(by: { $0.date > $1.date }).map {
            return Transaction(categoryType: CategoryType(stringValue: $0.categoryType), amount: $0.amount, currency: $0.currency, time: $0.date)
        }
    }
    
    private func addTransactionObserver() {
        transactionsNotificationToken = transactionResults.observe { [weak self] changes in
            guard let self = self else { return }
            var transactionByCategory: [String: [RealmTransaction]] = [:]
            switch changes {
            case .initial(let transactions):
                transactionByCategory = Dictionary(grouping: transactions) { $0.categoryType
                }
                //MARK: create categories
                self.updateCategories(transactions: transactionByCategory)
            case .update(let transactions, _, _, _):
                transactionByCategory = Dictionary(grouping: transactions) { $0.categoryType
                }
                self.updateCategories(transactions: transactionByCategory)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func updateCategories(transactions: [String: [RealmTransaction]]) {
        categories = getActualCategories()
        for key in transactions.keys {
            if let index = categories.firstIndex(where: { $0.type.id == key }),
               let amount = transactions[key]?.compactMap({ $0.amount }).reduce(0, +) {
                categories[index].amount = amount
            }
        }
        updateUI(with: categories)
    }
    
    private func updateUI(with categories: [Category]) {
        for delegate in delegates {
            delegate?.update(categories: categories)
        }
    }

    private func removeTransactionObserver() {
        transactionsNotificationToken?.invalidate()
    }
    
    deinit {
        removeTransactionObserver()
    }
    
}
