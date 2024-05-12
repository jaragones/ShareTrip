//
//  MapViewTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//

import XCTest
import GoogleMaps

@testable import ShareTrip

class MapViewTests: XCTestCase {
    var mapView: MapsView!
    
    var webservice: Webservice!
    var urlSession: URLSession!

    override func setUp() {
        super.setUp()
        
        // Register MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        
        webservice = Webservice()
        
        mapView = MapsView(trip: nil) // Initialize with no trip initially
    }
    
    override func tearDown() {
        mapView = nil
        webservice = nil
        urlSession = nil
        
        super.tearDown()
    }
    
    func testMapViewUpdatesWithValidTrip() {
        // Given
        let trip = Trip(driverName: "Alice", status: "Active", route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [], endTime: "10:00")
        
        // When
        mapView.trip = trip
        
        // Then
        // Verify that the map updates path correctly
        XCTAssertNotNil(mapView.path, "Path should not be nil")
        XCTAssertEqual(mapView.path?.count(), 12, "Path should have 12 coordinates")
    }
    
    func testMapViewClearsWhenNoTripSelected() {
        // Given
        mapView.trip = Trip(driverName: "Alice", status: "Active", route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [], endTime: "10:00")

        // When
        mapView.trip = nil // Clear the trip
        
        // Then
        XCTAssertEqual(mapView.path?.count(), 0, "Path is empty")
    }
    
    func testGetMarkersWithValidTrip() {
        // Given
        let stop1 = Stop(point: Point(latitude: 41.5, longitude: 2.2), id: 1)
        let stop2 = Stop(point: Point(latitude: 41.6, longitude: 2.3), id: 2)
        
        let trip = Trip(driverName: "Alice", status: "Active", route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@", startTime: "09:00", origin: Destination(point: Point(latitude: 37.7749, longitude: -122.4194), address: "San Francisco"), description: "Morning commute", destination: Destination(point: Point(latitude: 37.3382, longitude: -121.8863), address: "San Jose"), stops: [stop1, stop2], endTime: "10:00")

        // When
        let mapView = MapsView(trip: trip)
        let markers = mapView.getMarkers(from: trip)

        // Then
        XCTAssertEqual(markers.count, 4, "Expected 4 markers (origin, destination, 2 stops)")
        // Add more assertions to verify marker properties (position, icon, user data, etc.)
    }
}
