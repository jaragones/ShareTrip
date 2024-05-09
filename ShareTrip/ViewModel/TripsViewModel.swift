//
//  TripsViewModel.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import Foundation

@MainActor
class TripsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filteredTrips: Trips = []
    
    var trips: Trips = []
    
    func downloadTrips(url: URL) async {
        self.isLoading = true

        // Fetch data from web service
        let webservice = Webservice()
        do {
            self.trips = try await webservice.downloadTripsAsync(url: url)
            updateFilteredTrips(for: .scheduled)
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
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
}
