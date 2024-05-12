//
//  MapBubbleViewTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
@testable import ShareTrip

class MapBubbleViewTests: XCTestCase {
    func testTitleForStartType() {
        let view = MapBubbleView(type: .start, address: "123 Main St", time: "2022-05-20 10:00", price: 0.0, username: "John Doe")
        XCTAssertEqual(view.getTitleFor(type: .start), "Starting point")
    }

    func testTitleForEndType() {
        let view = MapBubbleView(type: .end, address: "456 Elm St", time: "2022-05-20 11:30", price: 0.0, username: "Jane Smith")
        XCTAssertEqual(view.getTitleFor(type: .end), "Ending point")
    }

    func testTitleForStopType() {
        let view = MapBubbleView(type: .stop, address: "789 Oak St", time: "2022-05-20 12:15", price: 25.0, username: "Alice Johnson")
        XCTAssertEqual(view.getTitleFor(type: .stop), "Requested stop")
    }

    func testStringifyPrice() {
        let view = MapBubbleView(type: .stop, address: "789 Oak St", time: "2022-05-20 12:15", price: 25.0, username: "Alice Johnson")
        XCTAssertEqual(view.stringifyPrice(price: 25.0), "$25.00")
    }
}

