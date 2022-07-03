//
//  MoneyKeeperTests.swift
//  MoneyKeeperTests
//
//  Created by Anton Sapunov on 6/4/22.
//

import XCTest
import RealmSwift
@testable import MoneyKeeper

class MoneyKeeperTests: XCTestCase {
    
    var realm: Realm!
    
    private let realmStore = RealmStore.shared

    override func setUpWithError() throws {
        let realm = try! Realm()
        self.realm = realm
        realmStore.createInitialCategories()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_CategoryCount_Initially_ShouldBeZero() {
        XCTAssertEqual(realm.objects(RealmCategory.self).count, 5, "should be 5 (Initial categories count)")
    }
    
    func test_TransactionsCount_Initially_ShouldBeZero() {
        XCTAssertEqual(realm.objects(RealmTransaction.self).count, 0, "should be 0")
    }
}
