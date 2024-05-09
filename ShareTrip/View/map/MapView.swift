//
//  MapView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.38074, longitude: 2.18594), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
            .accessibilityIdentifier("mapView")
    }
}
