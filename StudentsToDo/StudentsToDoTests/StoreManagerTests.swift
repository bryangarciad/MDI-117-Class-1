//
//  StoreManagerTests.swift
//  StudentsToDo
//
//  Created by SDGKU
//

import XCTest
@testable import StudentsToDo

final class StoreManagerTests: XCTestCase {
    var storeManager: StoreManager!
    
    // before (initial state of the app)
    override func setUpWithError() throws {
        storeManager = StoreManager()
    }
    // after (clean state of the app)
    override func tearDownWithError() throws {
        storeManager = nil
    }
    
    // Free User Test
    func testFreeUserGroupLimit() {
        // given -> free user limitation
        XCTAssertTrue(storeManager.canAddGroup(currentGroupCount: 0))
        XCTAssertTrue(storeManager.canAddGroup(currentGroupCount: 2))
        // false
        XCTAssertFalse(storeManager.canAddGroup(currentGroupCount: 3), "Free user should not be able to add the 4th group")
        XCTAssertFalse(storeManager.canAddGroup(currentGroupCount: 4))
    }
    
    // Pro User Test
    func testProUserGroupLimit() {
        storeManager.isPro = true
        // CaseL User has 10 groups -> Can they add another one
        // Expected result would be TRUE
        XCTAssertTrue(storeManager.canAddGroup(currentGroupCount: 10), "Pro user can exceed the limit")
        XCTAssertTrue(storeManager.canAddGroup(currentGroupCount: 100), "Pro user can exceed the limit")
        
    }
}
