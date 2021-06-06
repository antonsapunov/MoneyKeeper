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
    
    private var categoriesInitial: [Category] = [
        Category(type: .food, color: .yellow),
        Category(type: .transport, color: .blue),
        Category(type: .shopping, color: .green),
        Category(type: .entertainment, color: .red),
        Category(type: .service, color: .gray),
    ]
    
    private var delegates: [CategoryDelegate?] = []
    
    private var categoryResults: Results<RealmCategory>
    private var transactionResults: Results<RealmTransaction>
    private var transactionsNotificationToken: NotificationToken?
    
    private init() {
        do {
            let realm = try Realm()
            categoryResults = realm.objects(RealmCategory.self)
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
            return Category(type: CategoryType(stringValue: $0.type), color: UIColor.color(data: $0.color)!, amount: $0.amount)
        }
    }
    
    func createInitialCategories() {
        DispatchQueue.global(qos: .utility).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    var categoriesToWrite: [RealmCategory] = []
                    for categoryModel in self.categoriesInitial {
                        let category = RealmCategory()
                        category.type = categoryModel.type.id
                        category.name = categoryModel.name
                        category.color = categoryModel.color.encode()!
                        category.icon = categoryModel.icon.pngData()!
                        category.amount = categoryModel.amount
                        categoriesToWrite.append(category)
                    }
                    try realm.write {
                        realm.add(categoriesToWrite, update: .modified)
                    }
                    let results = realm.objects(RealmCategory.self)
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
