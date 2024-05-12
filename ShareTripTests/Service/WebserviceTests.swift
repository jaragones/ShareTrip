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
    }

    override func tearDown() {
        webservice = nil
        urlSession = nil
        super.tearDown()
    }
    
    func testGetTripsAsyncSuccess() async throws {
        // Mock
        let expectedTrips = Trips([Trip(driverName: "driverName", status: "status", route: "route", startTime: "startTime", origin: Destination(point: Point(latitude: 0.0, longitude: 0.0), address: "address"), description: "description", destination: Destination(point: Point(latitude: 0.0, longitude: 0.0), address: "address"), stops: [], endTime: "endTime")])
        let jsonData = try JSONEncoder().encode(expectedTrips)
        let url = URL(string: Urls.trips)!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (jsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act
        let webservice = Webservice(session: urlSession)
        let trips = try await webservice.getTripsAsync(url: url)

        // Assert
        XCTAssertEqual(trips, expectedTrips)
    }

    func testGetTripsAsyncFailureBadURL() async {
        // Mock
        let url = URL(string: Urls.trips)!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (nil, HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act & Assert
        do {
            let webservice = Webservice(session: urlSession)
            _ = try await webservice.getTripsAsync(url: url)
            XCTFail("Expected badURLError to be thrown")
        } catch ResponseError.wrongURLError {
            // Success
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testGetTripsAsyncFailureParseError() async {
        // Mock
        let url = URL(string: Urls.trips)!
        let invalidJsonData = Data("invalid json".utf8)
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (invalidJsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act & Assert
        do {
            let webservice = Webservice(session: urlSession)
            _ = try await webservice.getTripsAsync(url: url)
            XCTFail("Expected parseDataError to be thrown")
        } catch ResponseError.parseDataError {
            // Success, the error was thrown as expected
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testGetStopSuccess() {
        // Mock
        let expectedStop = StopExtended(price: 1.5, address: "Ramblas, Barcelona", tripID: 1, paid: true, stopTime: "2018-12-18T08:10:00.000Z", point: Point(latitude: 41.37653, longitude: 2.17924), userName: "Manuel Gomez")
        let jsonData = try! JSONEncoder().encode(expectedStop)
        let url = URL(string: Urls.stops)!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            return (jsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act
        let expectation = XCTestExpectation(description: "Get stop data successfully")
        let webservice = Webservice(session: urlSession)
        webservice.getStop(stopId: 123) { result in
            switch result {
            case .success(let stop):
                // Assert
                XCTAssertEqual(stop, expectedStop, "Stop data should match the expected value")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetStopNetworkError() {
        // Mock
        let url = URL(string: "https://www.fakeurl.co3m/example.com")! // Non-existent URL
        MockURLProtocol.requestHandler = { request in
            print("Request URL:", request.url ?? "nil")
            return (nil, HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!, NSError(domain: "TestErrorDomain", code: 123, userInfo: nil))
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Network error")
        let webservice = Webservice(session: urlSession)
        webservice.getStop(stopId: 456) { result in
            switch result {
            case .success:
                XCTFail("Expected network error, but received success")
            case .failure(let error):
                XCTAssertEqual(error as? ResponseError, .wrongURLError, "Error should be .wrongURLError")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetStopParsingError() {
        // Mock
        let invalidJsonData = Data("Invalid JSON data".utf8) // Invalid JSON data
        let url = URL(string: Urls.stops)! // valid URL
        MockURLProtocol.requestHandler = { request in
            return (invalidJsonData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, nil)
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Parsing error")
        
        let webservice = Webservice(session: urlSession)
        webservice.getStop(stopId: 789) { result in
            switch result {
            case .success:
                XCTFail("Expected parsing error, but received success")
            case .failure(let error):
                XCTAssertEqual(error as? ResponseError, .parseDataError("The data couldn’t be read because it isn’t in the correct format."), "Error should be .parseDataError")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
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
