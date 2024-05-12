//
//  EnumTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
@testable import ShareTrip

class FilterOptionsTests: XCTestCase {
    func testRawValues() {
        XCTAssertEqual(FilterOptions.all.rawValue, 1)
        XCTAssertEqual(FilterOptions.scheduled.rawValue, 2)
        XCTAssertEqual(FilterOptions.onGoing.rawValue, 3)
    }
}
