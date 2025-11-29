//
//  StudentsToDoTests.swift
//  StudentsToDoTests
//
//  Created by Gabriela Sanchez on 10/11/25.
//

import XCTest
@testable import StudentsToDo

final class StudentsToDoTests: XCTestCase {
    
    // Before test
    var storeManager: StoreManager!
    override func setUpWithError() throws {
        super.setUp()
        storeManager = StoreManager()
    }
    
    // after test
    override func tearDownWithError() throws {
        storeManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(storeManager.isPro, "User should be initially free")
    }
    
    func testTaskGroupInitialization() {
        // when
        let task1 = TaskItem(title: "Test")
        let task2 = TaskItem(title: "Test task 2", isCompleted: true)
        
        // given
        let group = TaskGroup(title: "Group Creation Test", symbolName: "briefcase", tasks: [task1, task2])
        print("Group created successfully")
        
        // then
        XCTAssertEqual(group.title, "Group Creation Test")
        XCTAssertEqual(group.symbolName, "briefcase")
        XCTAssertEqual(group.tasks.count, 2)
        XCTAssertEqual(group.tasks.first?.title, "Test")
        XCTAssertTrue(group.tasks.last?.isCompleted ?? false)
    }
    
    
}
