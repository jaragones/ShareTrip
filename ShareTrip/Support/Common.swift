//
//  Common.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description.
//  This file contains default values that can be used across the app.
//

import SwiftUI
import CoreLocation

struct AppColors {
    static let primaryHexColor = "#96F6AF"
    static let highlightHexColor = "#E8FEEE"
}

struct Urls {
    static let trips = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/trips.json"
    static let stops = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json"
}

struct Report {
    static let maxReportDescriptionLength = 200
}

struct Location {
    static let defaultLocation = CLLocation(latitude: 41.3851, longitude: 2.1734)
}
