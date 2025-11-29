//
//  StudentsToDoUITests.swift
//  StudentsToDoUITests
//
//  Created by SDGKU on 10/11/25.
//

import XCTest

final class StudentsToDoUITests: XCTestCase {
    
    // if the test fails, stop it to fix the error on that screen
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testAddGroupFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        let schoolButton = app.buttons["school_data"]
        XCTAssertTrue(schoolButton.waitForExistence(timeout: 5.0), "The school button should exist on Home Screen")
        schoolButton.tap()
        
        let addNewGroupButton = app.buttons["manageGroupsButton"]
        XCTAssertTrue(addNewGroupButton.waitForExistence(timeout: 2.0), "The (+) icon is present")
        addNewGroupButton.tap()
        
        let nameField = app.textFields["newGroupNameTextField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2.0), "text field is visible")
        nameField.tap()
        nameField.typeText("UI Test Group")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        // then
        XCTAssertTrue(addNewGroupButton.exists, "Should return to the main list")
    }
}
