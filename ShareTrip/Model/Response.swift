//
//  Response.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import Foundation

struct Trip: Codable, Identifiable, Equatable {
    let id = UUID()
    let driverName: String
    let status: String
    let route: String
    let startTime: String
    let origin: Destination
    let description: String
    let destination: Destination
    let stops: [Stop]
    let endTime: String
    
    static func == (lhs: Trip, rhs: Trip) -> Bool {
            return lhs.driverName == rhs.driverName &&
                   lhs.status == rhs.status &&
                   lhs.route == rhs.route &&
                   lhs.startTime == rhs.startTime &&
                   lhs.origin == rhs.origin &&
                   lhs.description == rhs.description &&
                   lhs.destination == rhs.destination &&
                   lhs.stops == rhs.stops &&
                   lhs.endTime == rhs.endTime
        }
    
    // Excluding id from Decoding
    private enum CodingKeys: String, CodingKey {
        case driverName, status, route, startTime, origin, description, destination, stops, endTime
    }
}

// MARK: - Destination
struct Destination: Codable, Equatable {
    let point: Point
    let address: String

    static func == (lhs: Destination, rhs: Destination) -> Bool {
        return lhs.point == rhs.point && lhs.address == rhs.address
    }
}

// MARK: - Point
struct Point: Codable, Equatable {
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

// MARK: - Stop
struct Stop: Codable, Equatable {
    let point: Point?
    let id: Int?

    static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.point == rhs.point && lhs.id == rhs.id
    }
}


typealias Trips = [Trip]
