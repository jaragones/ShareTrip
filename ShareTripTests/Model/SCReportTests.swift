//
//  SCReportTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
import CoreData

@testable import ShareTrip

class SCReportTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // TODO: A better practise would be to mockup context
    func testSaveReport() {
        // Given
        let context = PersistenceController.shared.testContext

        // When
        let savedReport = SCReport.saveReport(name: "Name", surname: "Surname", email: "Email@address.com", phone: "1234567", content: "Some content", date: Date(), in: context)

        // Then
        XCTAssertNotNil(savedReport, "Saved report should not be nil")
        XCTAssertEqual(savedReport.name, "Name", "Report name should match input")
    }
    
    
    func testFetchAll() {
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
        
        // Given
        let context = PersistenceController.shared.testContext
        _ = SCReport.saveReport(name: "Name 1", surname: "Surname", email: "Email@address.com", phone: "1234567", content: "Some content", date: Date(), in: context)
        _ = SCReport.saveReport(name: "Name 2", surname: "Surname", email: "Email@address.com", phone: "1234567", content: "Some content", date: Date(), in: context)

        // When
        let fetchedReports = SCReport.fetchAll(in: context)

        // Then
        XCTAssertEqual(fetchedReports.count, 2, "Should fetch 2 reports")
        XCTAssertEqual(fetchedReports[0].name, "Name 1", "First report name should match")
        // Add more assertions based on your specific implementation
    }
}
