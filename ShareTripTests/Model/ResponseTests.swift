//
//  ResponseTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import XCTest
@testable import ShareTrip

class ResponseTests: XCTestCase {
    
    // MARK: - Equatability Tests
    
    func testTripEquatability() {
        let trip1 = Trip(driverName: "Alice", status: "Active", route: "Route A", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [], endTime: "10:00")
        let trip2 = Trip(driverName: "Alice", status: "Active", route: "Route A", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [], endTime: "10:00")
        XCTAssertEqual(trip1, trip2, "Trips should be equal")
    }
        
    // MARK: - Codability Tests
    
    func testTripCodability() {
        let trip = Trip(driverName: "Bob", status: "Pending", route: "Route B", startTime: "14:00", origin: Destination(point: Point(latitude: 34.0522, longitude: -118.2437), address: "Los Angeles"), description: "Afternoon trip", destination: Destination(point: Point(latitude: 33.6846, longitude: -117.8265), address: "Irvine"), stops: [], endTime: "15:30")
        
        do {
            let jsonData = try JSONEncoder().encode(trip)
            let decodedTrip = try JSONDecoder().decode(Trip.self, from: jsonData)
            XCTAssertEqual(trip, decodedTrip)
        } catch {
            XCTFail("Error encoding/decoding Trip: \(error)")
        }
    }
        
    // MARK: - Initialization and Property Access Tests
    
    func testTripInitialization() {
        let trip = Trip(driverName: "Charlie", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00")
        
        XCTAssertEqual(trip.driverName, "Charlie")
        XCTAssertEqual(trip.origin.address, "New York")
    }
        
    // MARK: - Edge Case Tests
    
    func testEmptyTrip() {
        let emptyTrip = Trip(driverName: "", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00")
        XCTAssertEqual(emptyTrip.driverName, "", "Driver name should be empty")
    }
    
    func testUniqueUUIDs() {
        let trip1 = Trip(driverName: "Charlie", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00") // Initialize with relevant properties
        let trip2 = Trip(driverName: "Charlie", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00") // Initialize with different properties
        XCTAssertNotEqual(trip1.id, trip2.id, "UUIDs should be unique")
    }
    
    func testStopWithoutID() {
        let stopWithoutID = Stop(point: Point(latitude: 41.8, longitude: -87.62), id: nil)
        XCTAssertEqual(stopWithoutID.id, nil, "Stop should have no ID")
    }
    
    func testEmptyAddress() {
        let emptyAddressDestination = Destination(point: Point(latitude: 41.8, longitude: -87.62), address: "")
        XCTAssertEqual(emptyAddressDestination.address, "", "Destination address should be empty")
    }
    
    func testRouteDescription() {
        let trip = Trip(driverName: "Charlie", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00") // Initialize with relevant properties
        XCTAssertEqual(trip.description, "Evening ride", "Route description should match")
    }
    
    func testNonEqualTrips() {
        let trip1 = Trip(driverName: "Charlie A", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00") // Initialize with relevant properties
        let trip2 = Trip(driverName: "Charlie", status: "Completed", route: "Route C", startTime: "18:30", origin: Destination(point: Point(latitude: 40.7128, longitude: -74.0060), address: "New York"), description: "Evening ride", destination: Destination(point: Point(latitude: 41.8781, longitude: -87.6298), address: "Chicago"), stops: [], endTime: "22:00") // Initialize with different properties
        XCTAssertNotEqual(trip1, trip2, "Trips should not be equal")
    }
    
    func testStopEquatability() {
        let stop1 = Stop(point: Point(latitude: 37.7749, longitude: -122.4194), id: 1)
        let stop2 = Stop(point: Point(latitude: 37.7749, longitude: -122.4194), id: 1)
        XCTAssertEqual(stop1, stop2, "Stops should be equal")
    }
    
    func testStopInitialization() {
        let point = Point(latitude: 37.7749, longitude: -122.4194)
        let stop = Stop(point: point, id: 1)
        XCTAssertEqual(stop.point, point, "Point should match")
        XCTAssertEqual(stop.id, 1, "ID should match")
    }
    
}
