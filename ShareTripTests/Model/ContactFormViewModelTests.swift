//
//  ContactFormViewModelTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
import CoreData

@testable import ShareTrip // Replace with your actual app module name

class ContactFormViewModelTests: XCTestCase {
    func testFormValidation() {
        let viewModel = ContactFormViewModel()
        viewModel.name = "John"
        viewModel.surname = "Doe"
        viewModel.email = "john.doe@example.com"
        viewModel.reportDescription = "Some description"

        XCTAssertTrue(viewModel.isFormValid)
    }

    func testInvalidFormValidation() {
        let viewModel = ContactFormViewModel()
        viewModel.name = "John"
        viewModel.surname = ""
        viewModel.email = "invalid-email"
        viewModel.reportDescription = ""

        XCTAssertFalse(viewModel.isFormValid)
    }

    func testValidEmailValidation() {
        let viewModel = ContactFormViewModel()
        viewModel.email = "john.doe@example.com"

        XCTAssertTrue(viewModel.isValidEmail)
    }

    func testInvalidEmailValidation() {
        let viewModel = ContactFormViewModel()
        viewModel.email = "invalid-email"

        XCTAssertFalse(viewModel.isValidEmail)
    }
    
    func testSubmitReport() {
        // initializing test context
        do {
            let fetchRequest: NSFetchRequest<SCReport> = SCReport.fetchRequest()
            let reports = try PersistenceController.shared.testContext.fetch(fetchRequest)

            for report in reports {
                PersistenceController.shared.testContext.delete(report)
            }

            try PersistenceController.shared.testContext.save()
        } catch {
            print("Failed to delete SCReports: \(error)")
        }
        
        // Create a background context for writing
        let testContext = PersistenceController.shared.testContext

        // Save the report using the background context
        _ = SCReport.saveReport(
            name: "name",
            surname: "surname",
            email: "email@gmail.com",
            phone: "123123",
            content: "reportDescription",
            date: Date(),
            in: testContext
        )

        // Fetch all reports using the main context (for badge count)
        let issues = SCReport.fetchAll(in: testContext)

        XCTAssertEqual(issues.count, 1, "Save correctly")
    }
}
