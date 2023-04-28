//
//  FoapUITests.swift
//  FoapUITests
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

import XCTest

final class FoapUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableLoad() throws {
        // Test table view loads and can navigate to detailView
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.cells.count > 0)
        
        let firstItem = tableView.cells.element.firstMatch
        firstItem.tap()
        
        let detailViewController = app.otherElements["detailViewController"]
        // Check that the detail view controller is now displayed
        XCTAssertTrue(detailViewController.exists)
        
        // Navigate back to the table view
        app.navigationBars.buttons.element(boundBy: 0).tap()

    }

    func testRefreshTap() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        
        let navigationBar = app.navigationBars.firstMatch
        let rightButton = navigationBar.buttons.firstMatch
        XCTAssertTrue(rightButton.exists)
        rightButton.tap()

        continueAfterFailure = false
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
