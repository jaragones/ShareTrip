//
//  MapBubbleView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import SwiftUI

struct MapBubbleView: View {
    
    @ObservedObject var mapsViewModel : MapsViewModel
    
    var address, time, username: String
    
    init(address: String, time: String, username: String) {
        self.mapsViewModel = MapsViewModel()
        self.address = address
        self.time = time
        self.username = username
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(self.address)")
            Text("\(self.time)")
            Text("\(self.username)")
            
//            Text("StopTime: \(point.stopTime)")
//            Text("Price: \(point.price)")
//            Text("Type: \(point.type)")
//            Text("Passenger: \(point.passenger)")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}
