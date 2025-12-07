//
//  TripsViewModel.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. Trip ViewModel to interact with main ContainView.

import Foundation
import CoreLocation

import Combine

@MainActor
class TripsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filteredTrips: Trips = []
        
    var trips: Trips = []
    
    var locationManager: LocationManager
    @Published var userLocation: CLLocation?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        locationManager = LocationManager()
        locationManager.$lastLocation
            .sink { [weak self] location in
                // Handle location updates here
                self?.handleUserLocationUpdate(location)
            }
            .store(in: &cancellables)
    }
    
    private func handleUserLocationUpdate(_ location: CLLocation?) {
        let status = CLLocationManager().authorizationStatus
        switch status {
            case .authorizedWhenInUse:
                userLocation = location
                locationManager.lm.stopUpdatingLocation()
            default:
            userLocation = Location.defaultLocation
        }
    }
    
    func retrieveTrips(from url: URL) async {
        self.isLoading = true

        // Fetch data from web service
        let webservice = Webservice()
        do {
            // retrieve first page (10 elements) from url
            self.trips = try await webservice.getTripsAsync(url: url)
            
            // by default, we show .scheduled events
            updateFilteredTrips(for: .scheduled)
            
            self.errorMessage = nil
        } catch let customError as ResponseError {
            switch customError {
            case .wrongURLError:
                self.errorMessage = "Server couldn't be reached"
            case .parseDataError:
                self.errorMessage = "Data couldn't be parsed"
            default:
                self.errorMessage = "Something went wrong"
            }
        } catch {
            self.errorMessage = "Something went wrong"
        }
        
        // once all is process we set loading
        do {
            self.isLoading = false
        }
    }
    
    func updateFilteredTrips(for filter: FilterOptions) {
        switch filter {
        case .all: // All trips
            self.filteredTrips = self.trips
        case .scheduled: // Scheduled trips
            self.filteredTrips = self.trips.filter { $0.status == "scheduled" }
        case .onGoing: // Ongoing trips
            self.filteredTrips = self.trips.filter { $0.status == "ongoing" }
        }
    }
    
    func sortTripsByDistance() {
        guard let userLocation = userLocation else { return }

        filteredTrips = filteredTrips.sorted { tripA, tripB in
            let locA = CLLocation(latitude: tripA.latitude, longitude: tripA.longitude)
            let locB = CLLocation(latitude: tripB.latitude, longitude: tripB.longitude)

            let distanceA = userLocation.distance(from: locA)
            let distanceB = userLocation.distance(from: locB)

            return distanceA < distanceB
        }
    }
}
