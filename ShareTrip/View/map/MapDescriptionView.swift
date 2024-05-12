//
//  TripDescriptionView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//
//  Description. Simple overlay over map to show which map is being viewed.

import SwiftUI

struct MapDescriptionView: View {
    
    var trip: Trip?
    
    var body: some View {
        if let trip = trip {
            Text(trip.description)
                .font(.system(size: 13))
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .offset(x: 0, y: 115)
        }
    }
}

#Preview {
    ContentView()
}
