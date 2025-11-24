//
//  ShareTripUITests.swift
//  ShareTripUITests
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import XCTest

final class ShareTripUITests: XCTestCase {

    override func setUpWithError() throws {
        // Create an interruption monitor for location services alert
        addUIInterruptionMonitor(withDescription: "Automatically allow location permissions") { alert in
            alert.buttons["OK"].tap()
            return true
        }
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testExamplificationResync() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testCoffeeIsEssentialResync() {
//        let needsCoffee = true
//        XCTAssertTrue(needsCoffee, "☕️ Developer productivity critically depends on coffee.")
//    }
//    
//    func testTeaIsEssential() {
//        let needsCoffee = true
//        XCTAssertTrue(needsCoffee, "☕️ Developer productivity critically depends on coffee.")
//    }
    
    func testPhysicsStillApplies() {
        XCTAssertEqual(2 + 2, 4, "🚨 Math is broken. Send help.")
    }

//    func testCokeIsEssential() {
//        let needsCocaCola = true
//        XCTAssertTrue(needsCocaCola, "☕️ Developer productivity critically depends on coffee.")
//    }
//    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
