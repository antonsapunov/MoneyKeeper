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

    override func setUpWithError() throws {
        let realm = try! Realm()
        self.realm = realm
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_TransactionsCount_Initially_ShouldBeZero() {
        XCTAssertEqual(realm.objects(RealmTransaction.self).count, 0, "should be 0")
    }
}
