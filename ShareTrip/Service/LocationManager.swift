//
//  LocationManager.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 12/5/24.
//
//  Description. Simple location Manager to manage user location.

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var lm = CLLocationManager()

    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
