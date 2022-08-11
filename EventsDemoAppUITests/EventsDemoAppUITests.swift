//
//  EventsDemoAppUITests.swift
//  EventsDemoAppUITests
//
//  Created by Edwin Weru on 02/08/2022.
//

import XCTest

class EventsDemoAppUITests: XCTestCase {

    override func setUpWithError() throws {
      continueAfterFailure = false
    }
    func testExample() throws {
        let app = XCUIApplication()
        app.buttons["icon play red"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Play/Pause"]/*[[".buttons[\"Pause\"]",".buttons[\"Play\/Pause\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".buttons[\"Close\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Suns @ Mavericks"].buttons["Events"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Suns @ Mavericks")/*[[".cells.containing(.staticText, identifier:\"2022-08-11T04:30:43.174Z\")",".cells.containing(.staticText, identifier:\"Suns @ Mavericks\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#DAZNbreakfast")/*[[".cells.containing(.staticText, identifier:\"Interview Sadio Mane\")",".cells.containing(.staticText, identifier:\"#DAZNbreakfast\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["2022-08-11T10:30:43.174Z"].swipeUp()
        tablesQuery.cells.containing(.staticText, identifier:"PSG v Strasbourg").element.swipeDown()
        app.tabBars["Tab Bar"].buttons["Schedules"].tap()
                
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
