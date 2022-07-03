//
//  RealmStore.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import RealmSwift
import UIKit

protocol UpdateDelegate: AnyObject {}

protocol CategoryDelegate: UpdateDelegate {
    func update(categories: [Category])
}

protocol TransactionDelegate: UpdateDelegate {
    func update(transactions: [Transaction])
}

class RealmStore {
    
    static let shared = RealmStore()
    
    private var categoriesInitial: [Category] = [
        Category(type: .food),
        Category(type: .transport),
        Category(type: .shopping),
        Category(type: .entertainment),
        Category(type: .service),
    ]
    
    private var categoryDelegates: [CategoryDelegate?] = []
    private var transactionDelegates: [TransactionDelegate?] = []
    
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
    
    func addCategoryDelegate(delegate: CategoryDelegate) {
        weak var delegate = delegate
        categoryDelegates.append(delegate)
    }
    
    func addTransactionDelegate(delegate: TransactionDelegate) {
        weak var delegate = delegate
        transactionDelegates.append(delegate)
    }
    
    func removeDelegate(delegate: UpdateDelegate) {
        categoryDelegates.removeAll { $0 === delegate }
        transactionDelegates.removeAll { $0 === delegate }
    }
    
    private func getActualCategories(for results: Results<RealmCategory>? = nil) -> [Category] {
        return Array(results ?? categoryResults)
            .compactMap {
                guard let categoryType = CategoryType(rawValue: $0.type) else { return nil }
            return Category(type: categoryType)
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
                        category.type = categoryModel.type.rawValue
                        category.name = categoryModel.name
                        category.order = categoryModel.order
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
    
    func createTransaction(categoryType: CategoryType, comment: String? = nil, direction: TransactionDirection, amount: Double) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let transaction = RealmTransaction(categoryType: categoryType, comment: comment, direction: direction, amount: amount)
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
    
    func getTransaction(transactionID: String, comletionHandler: @escaping (Transaction?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    guard let realmTransaction = realm.object(ofType: RealmTransaction.self, forPrimaryKey: transactionID) else { return }
                    let transaction = Transaction(realmTransaction: realmTransaction)
                    comletionHandler(transaction)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func updateTransaction(transactionID: String, amount: Double) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let transactions = realm.objects(RealmTransaction.self)
                        .filter("id == %@", transactionID)
                    if let transaction = transactions.first {
                        try realm.write {
                            transaction.amount = amount
                        }
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func deleteTransaction(transactionID: String) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        let transaction = realm.objects(RealmTransaction.self)
                            .filter("id == %@", transactionID)
                        realm.delete(transaction)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    private func sortedTransactionsByDate(_ transactions: Results<RealmTransaction>) -> [Transaction] {
        return transactions
            .sorted(by: { $0.date > $1.date })
            .compactMap { Transaction(realmTransaction: $0) }
    }
    
    private func addTransactionObserver() {
        transactionsNotificationToken = transactionResults.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(let transactions):
                //MARK: create categories
                self.updateCategories(with: transactions)
                self.updateTransactions(with: transactions)
            case .update(let transactions, _, _, _):
                self.updateCategories(with: transactions)
                self.updateTransactions(with: transactions)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func updateCategories(with transactions: Results<RealmTransaction>) {
        let transactionByCategory = Dictionary(grouping: transactions) {
            $0.categoryType
        }
        var categories = getActualCategories()
        
        for key in transactionByCategory.keys {
            if let index = categories.firstIndex(where: { $0.type.rawValue == key }),
               let transactionByCategory = transactionByCategory[key] {
                categories[index].transactions = transactionByCategory.compactMap { Transaction(realmTransaction: $0) }
            }
        }
        updateUI(with: categories)
    }
    
    private func updateTransactions(with transactions: Results<RealmTransaction>) {
        updateUI(with: sortedTransactionsByDate(transactions))
    }
    
    private func updateUI(with categories: [Category]) {
        for delegate in categoryDelegates {
            delegate?.update(categories: categories)
        }
    }
    
    private func updateUI(with transactions: [Transaction]) {
        for delegate in transactionDelegates {
            delegate?.update(transactions: transactions)
        }
    }

    private func removeTransactionObserver() {
        transactionsNotificationToken?.invalidate()
    }
    
    deinit {
        removeTransactionObserver()
    }
    
}
