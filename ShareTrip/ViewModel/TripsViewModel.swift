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
}
