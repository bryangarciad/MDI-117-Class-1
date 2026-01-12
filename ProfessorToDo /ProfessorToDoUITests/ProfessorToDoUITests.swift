//
//  ProfessorToDoUITests.swift
//  ProfessorToDoUITests
//
//  Created by Gabriela Sanchez on 10/11/25.
//

import XCTest

final class ProfessorToDoUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // In UI testing it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // Start the app
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up after each test
    }
    
    // MARK: MDI 1115 - 4
    func testLaunchInEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        let header = app.staticTexts["Who is working today?"]
        
        XCTAssertTrue(header.exists, "The English header 'Who is working today?' was not found.")
    }
    
    func testLaunchInSpanish() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let spanishHeader = app.staticTexts["¿Quién está trabajando hoy?"]
        
        XCTAssertTrue(spanishHeader.waitForExistence(timeout: 2), "The Spanish header '¿Quién está trabajando hoy?' was not found.")
    }
    
    func testNewGroupSheetLocalization() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let firstProfile = app.buttons.firstMatch
        if firstProfile.exists {
            firstProfile.tap()
            
            let addButton = app.buttons["Add"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                
                XCTAssertTrue(app.staticTexts["Nombre del Grupo"].exists)
                
                XCTAssertTrue(app.staticTexts["Seleccionar Icono"].exists)
            }
        }
    }
    
    // MARK: 117 - 1
    // E2E Test
    func testFullUserFlow() {
        // 1. Verify that the "Proffesor" Card is available
        let professorCard = app.buttons["profileCard_Professor"]
        XCTAssertTrue(professorCard.waitForExistence(timeout: 5), "The Proffesor Card should exists in screen")
        professorCard.tap()
        
        // 2. Verify we are on the Dasboard and tap "Add Group"
        let addGroupButton = app.buttons["addGroupButton"]
        XCTAssertTrue(addGroupButton.waitForExistence(timeout: 10), "The add group button should be vissible on the dashboard")
        addGroupButton.tap()
        
        //3. Fill out the new Group View
        let groupNameInputeField = app.textFields["newGroupNameField"]
        XCTAssertTrue(groupNameInputeField.exists, "The Group Name Text Input Field should be present")
        groupNameInputeField.tap()
        groupNameInputeField.typeText("Test Project")
        
        let iconButton = app.images["iconSelect_list.bullet"]
        if iconButton.exists {
            iconButton.tap()
        }
        
        let saveButton = app.buttons["saveGroupButton"]
        if saveButton.exists {
            saveButton.tap()
        }
        
        let newGroupRow = app.buttons["groupRow_Test Project"] // this technique to select ui elemts by accesibility id
        XCTAssertTrue(newGroupRow.waitForExistence(timeout: 5), "The new group 'Test Project' should appear in the dashboard")
        newGroupRow.tap()
        
        //4. Add a Task Inside the Newle Created Group
        let addTaskButton = app.buttons["addTaskButton"]
        XCTAssertTrue(addTaskButton.exists, "The add task button should be available in the detail view")
        addTaskButton.tap()
        
        // 5. add a new task under selected group
        let taskTextField = app.textFields.firstMatch
        taskTextField.tap()
        taskTextField.typeText("Finish UI Test")
        
        app.keyboards.buttons["Return"].tap()
        
        let completionToggle = app.images["taskCompletionToggle_Finish UI Test"]
        XCTAssertTrue(completionToggle.exists, "The task completion toggle should exists")
        completionToggle.tap()
    }
    
}
