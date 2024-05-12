//
//  ContactFormUITests.swift
//  ShareTripUITests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
@testable import ShareTrip

final class ContactFormUITests: XCTestCase {

    override func setUpWithError() throws {
        // Create an interruption monitor for location services alert
        addUIInterruptionMonitor(withDescription: "Automatically allow location permissions") { alert in
            alert.buttons["Allow Once"].tap()
            return true
        }
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testReportIssueButton() {
        let app = XCUIApplication()
        app.launch()

        let reportIssueButtonImg = app.images["Report an Issue"]
        reportIssueButtonImg.tap()

        let expectation = XCTestExpectation(description: "Wait for the contact form to appear")
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        
        if result == XCTWaiter.Result.timedOut {
            let contactFormViewExists = app.otherElements["ContactFormView"].exists
            XCTAssertTrue(contactFormViewExists, "ContactFormView should be presented when tapping 'Report an Issue'")
        } else {
            XCTFail("The ContactFormView did not appear in time")
        }
    }
    
    func testTextEditorInputMaxValue() {
        let app = XCUIApplication()
        app.launch()

        // Tap the button that opens the ContactFormView
        let reportIssueButtonImg = app.images["Report an Issue"]
        reportIssueButtonImg.tap()

        // Wait for the ContactFormView to appear
        let contactFormView = app.otherElements["ContactFormView"]
        XCTAssertTrue(contactFormView.waitForExistence(timeout: 5), "ContactFormView should appear")

        // Find the TextEditor within the ContactFormView using its accessibility identifier
        let textEditor = contactFormView.textViews["textEditor"]

        // Enter a 250-character string
        let longString = String(repeating: "A", count: 250)
        textEditor.tap()
        textEditor.typeText(longString)

        let string = textEditor.value as! String
        XCTAssertEqual(string.count, 200, "TextEditor should contain the 200-character string")
    }
    
    func testTextEditorInputMinValue() {
        let app = XCUIApplication()
        app.launch()

        // Tap the button that opens the ContactFormView
        let reportIssueButton = app.images["Report an Issue"]
        reportIssueButton.tap()

        // Wait for the ContactFormView to appear
        let contactFormView = app.otherElements["ContactFormView"]
        XCTAssertTrue(contactFormView.waitForExistence(timeout: 5), "ContactFormView should appear")

        // Find the TextEditor within the ContactFormView using its accessibility identifier
        let textEditor = contactFormView.textViews["textEditor"]

        // bug on ios simulator requires keyboard to be set to virtual
        // Enter a 150-character string
        let shortString = "12345678901234567890123456789012345678901234567890"
        textEditor.tap()
        textEditor.typeText(shortString)

        // Verify that the entered text matches
        let string = textEditor.value as! String
        XCTAssertEqual(string.count, 50, "TextEditor should contain 50 characters")
    }
}
