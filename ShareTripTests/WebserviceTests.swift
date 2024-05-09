//
//  WebserviceTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import XCTest
@testable import ShareTrip

class WebserviceTests: XCTestCase {
    var webservice: Webservice!
    var urlSession: URLSession!

    override func setUp() {
        super.setUp()
        
        // Register MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        
        webservice = Webservice()
        // Configure a mock URL session or use dependency injection if needed
    }

    override func tearDown() {
        webservice = nil
        urlSession = nil
        super.tearDown()
    }
    
    func testDownloadTripsAsyncSuccess() async throws {
        // Arrange
        let expectedTrips = Trips([Trip(driverName: "driverName", status: "status", route: "route", startTime: "startTime", origin: Destination(point: Point(latitude: 0.0, longitude: 0.0), address: "address"), description: "description", destination: Destination(point: Point(latitude: 0.0, longitude: 0.0), address: "address"), stops: [], endTime: "endTime")]) // Provide a valid Trips object
        let jsonData = try JSONEncoder().encode(expectedTrips)
        let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/trips.json")!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (jsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act
        let webservice = Webservice(session: urlSession)
        let trips = try await webservice.downloadTripsAsync(url: url)

        // Assert
        XCTAssertEqual(trips, expectedTrips)
    }

    func testDownloadTripsAsyncFailureBadURL() async {
        // Arrange
        let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws2.com/tech-test/trips.json")!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (nil, HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act & Assert
        do {
            let webservice = Webservice(session: urlSession)
            _ = try await webservice.downloadTripsAsync(url: url)
            XCTFail("Expected badURLError to be thrown")
        } catch ResponseError.wrongURLError {
            // Success
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testDownloadTripsAsyncFailureParseError() async {
        // Arrange
        let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/trips.json")!
        let invalidJsonData = Data("invalid json".utf8)
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (invalidJsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act & Assert
        do {
            let webservice = Webservice(session: urlSession)
            _ = try await webservice.downloadTripsAsync(url: url)
            XCTFail("Expected parseDataError to be thrown")
        } catch ResponseError.parseDataError {
            // Success, the error was thrown as expected
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}

// MockURLProtocol class to mock network responses
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (Data?, HTTPURLResponse, Error?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Handler is unavailable.")
            return
        }

        do {
            let (data, response, error) = try handler(request)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required method. Leave empty if not needed.
    }
}
