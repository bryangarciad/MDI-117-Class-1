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
    
    
    // Given an array of two users in the persistent storage, when the Content View load, Then the screen should shoe the profile
    // Card Sorted alpabethically Descending
    func testContentProfileCardsSort() {
        let profileCardsQuery = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "profileCard_"))
        XCTAssertGreaterThan(profileCardsQuery.count, 1, "Need at least two cards to test ordering")
        
        var names: [String] = []
        for i in 0..<profileCardsQuery.count {
            let element = profileCardsQuery.element(boundBy: i)
            XCTAssertTrue(element.waitForExistence(timeout: 5))
            let fullId = element.identifier
            let name = fullId.replacingOccurrences(of: "profileCard_", with: "") // strip out prefix
            names.append(name)
        }
        
        XCTAssertEqual(names, ["Student", "Professor"])
    }
    
}
