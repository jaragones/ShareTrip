//
//  DateExtensionTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import XCTest
@testable import ShareTrip 

class DateExtensionTests: XCTestCase {
    func testFromStringWithFormat() {
        let dateString = "2023-05-10T14:30:00.000Z"
        let expectedDate = Date(timeIntervalSince1970: 1683729000)
        
        let convertedDate = Date().fromStringWithFormat(str: dateString)
        XCTAssertEqual(convertedDate, expectedDate, "Conversion from string to Date failed")
    }
    
    func testGetAbbreviationForMonth() {
        let monthString = "2023-05-10T14:30:00.000Z"
        let expectedAbbreviation = "May"
        
        let abbreviation = Date.getAbbreviationForMonth(from: monthString)
        XCTAssertEqual(abbreviation, expectedAbbreviation, "Abbreviation calculation failed")
    }
    
    func testGetDayForDate() {
        let dateString = "2023-05-10T14:30:00.000Z"
        let expectedDay = "10"
        
        let day = Date.getDayForDate(from: dateString)
        XCTAssertEqual(day, expectedDay, "Day extraction failed")
    }
    
    func testGetHourForDate() {
        let dateString = "2023-05-10T14:30:00.000Z"
        let expectedHour = "16:30"
        
        let hour = Date.getHourForDate(from: dateString)
        XCTAssertEqual(hour, expectedHour, "Hour extraction failed")
    }
}
