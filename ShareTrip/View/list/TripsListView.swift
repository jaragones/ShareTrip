//
//  TripsListView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. Trip List View.

import SwiftUI

struct TripsListView: View {
    
    var trips: Trips
    
    // updating this var via binding to be used on MapView container
    @Binding var selectedTrip: Trip?
    
    var body: some View {
        List(trips, id:\.id) { trip in
            TripCellView(trip: trip)
                .onTapGesture {
                    withAnimation {
                        let previousSelection = selectedTrip
                        $selectedTrip.wrappedValue = nil    // otherwise change is missed
                        $selectedTrip.wrappedValue = (previousSelection?.id != trip.id) ? trip : nil
                    }
                }
                .padding(0)
                .listRowBackground(selectedTrip?.id == trip.id ? Color.highlightAppColor: Color.white)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
