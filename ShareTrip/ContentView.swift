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
    
    // just mocking up some stuff to prepare UI
    private var mockTrips = [
        Trip(driverName: "Alberto Morales", status: "ongoing", route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@", startTime: "2018-12-18T08:00:00.000Z", origin: Destination(point: Point(latitude: 41.38074, longitude: 2.18594), address: "Metropolis:lab, Barcelona"), description: "Barcelona a Martorell", destination: Destination(point: Point(latitude: 41.49958, longitude: 1.90307), address: "Seat HQ, Martorell"), stops: [], endTime: "2018-12-18T09:00:00.000Z"),
        Trip(driverName: "Joaquin Sabina", status: "ongoing", route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@", startTime: "2018-12-18T08:00:00.000Z", origin: Destination(point: Point(latitude: 41.38074, longitude: 2.18594), address: "Metropolis:lab, Barcelona"), description: "Barcelona a Sant cugat", destination: Destination(point: Point(latitude: 41.49958, longitude: 1.90307), address: "Seat HQ, Martorell"), stops: [], endTime: "2018-12-18T09:00:00.000Z")
    ]

    var body: some View {
        NavigationView {
            VStack (spacing:0) {
                // Logo container
                HeaderView()
                
                // Map container
                MapView()
                    .frame(height: (selectedTrip == nil) ? 160 : 250)
                    .cornerRadius(10)
                    .padding(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Filters container
                FiltersView(selectedFilter: $selectedFilter)
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 10)
                
                // Trips' list container
                TripsListView(trips: mockTrips, selectedTrip: $selectedTrip)
            }
        }
    }
}

#Preview {
    ContentView()
}
