//
//  MapDescriptionViewTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 11/5/24.
//

import XCTest
@testable import ShareTrip
import SwiftUI

class MapDescriptionViewTests: XCTestCase {
    var mapDescView: MapDescriptionView!
    
    override func setUp() {
        super.setUp()
        mapDescView = MapDescriptionView()
    }
    
    override func tearDown() {
        mapDescView = nil
        super.tearDown()
    }
    
    func testViewWithTrip() {
        let trip = Trip(driverName: "Alice", status: "Active", route: "Route A", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [], endTime: "10:00")
        
        mapDescView.trip = trip
        
        let descriptionText = mapDescView.body
        
        XCTAssertNotNil(descriptionText)
    }
}
