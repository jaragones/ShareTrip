//
//  ContentView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    // we want to react in different views based on these values
    @State private var selectedFilter: FilterOptions = .scheduled
    @State private var selectedTrip: Trip?
        
    @ObservedObject var tripsViewModel : TripsViewModel
    
    init() {
        self.tripsViewModel = TripsViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing:0) {
                // Logo and report container
                HeaderView()
                
                // Map container
                ZStack {
                    MapsView(trip: selectedTrip)
                        .frame(height: (selectedTrip == nil) ? 160 : 300)
                        .cornerRadius(10)
                        .padding(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        .id(UUID())
                    
                    MapDescriptionView(trip: selectedTrip)
                }
                
                // Filters container
                FiltersView(selectedFilter: $selectedFilter)
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 10)
                
                // Trips' list container
                ZStack {
                    TripsListView(trips: self.tripsViewModel.filteredTrips, selectedTrip: $selectedTrip)
                    
                    // Show something to user if error is happening
                    if tripsViewModel.trips.isEmpty || self.tripsViewModel.errorMessage != nil {
                        ErrorView(message: self.tripsViewModel.errorMessage)
                            .onTapGesture {
                                Task {
                                    await tripsViewModel.retrieveTrips(from: URL(string: Urls.trips)!)
                                }
                            }
                    }
                }
            }.overlay(
                Group {
                    if self.tripsViewModel.isLoading {
                        LoadingOverlay()
                    }
                }
            )
        }.task {
            await tripsViewModel.retrieveTrips(from: URL(string: Urls.trips)!)
        }.onChange(of: selectedFilter) {
            // we request an update once 'filter' is updated
            self.tripsViewModel.updateFilteredTrips(for: selectedFilter)
        }

    }
}

#Preview {
    ContentView()
}
