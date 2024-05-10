//
//  MapView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI
import GoogleMaps
import Polyline

struct MapsView: UIViewRepresentable {
    var trip: Trip?

    var path: GMSPath? {
        return GMSPath(fromEncodedPath: self.trip?.route ?? "")
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapViewOptions = GMSMapViewOptions()
        let mapView = GMSMapView(options: mapViewOptions)

        // Set the initial camera position to a specific coordinate (e.g., Barcelona)
        let barcelonaCoordinate = CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734)
        let cameraPosition = GMSCameraPosition.camera(withTarget: barcelonaCoordinate, zoom: 12.0)
        mapView.camera = cameraPosition

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        updateMapForSelectedTrip(on: uiView) // Pass the correct uiView
    }

    private func updateMapForSelectedTrip(on mapView: GMSMapView) {
        guard let trip = trip else {
            // Handle case when no trip is selected (e.g., clear markers, reset camera)
            mapView.clear() // Clear existing polylines and markers
            return
        }

        // Remove existing polylines and markers
        mapView.clear()

        // Generate a new path (e.g., from trip.route)
        if let newPath = GMSPath(fromEncodedPath: trip.route) {
            let bounds = GMSCoordinateBounds(path: newPath)
            
            // Fit the bounds with padding
            let update = GMSCameraUpdate.fit(bounds, withPadding: 70)
            mapView.moveCamera(update)
            
            // Create a new polyline
            let newPolyline = GMSPolyline(path: newPath)
            newPolyline.strokeWidth = 5.0
            newPolyline.map = mapView
            
            // Add markers (if needed)
            let markers: [GMSMarker] = getMarkers(from: self.trip)
            markers.forEach { $0.map = mapView }
        }
    }

    
    private func getMarkers(from trip: Trip?) -> [GMSMarker] {
        var markers: [GMSMarker] = []
        
        guard let trip = trip else {
            return []
        }
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: trip.origin.point.latitude, longitude: trip.origin.point.longitude)
        marker.userData = "Origin"
        marker.icon = GMSMarker.markerImage(with: .blue)
        markers.append(marker)

        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.trip!.destination.point.latitude, longitude: self.trip!.destination.point.longitude)
        marker.userData = "Destination"
        marker.icon = GMSMarker.markerImage(with: .blue)
        markers.append(marker)

        for stop in trip.validStops {
            if let point = stop.point {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                marker.userData = "Stop"
                marker.icon = GMSMarker.markerImage(with: .red)
                markers.append(marker)
            }
         }
        
        return markers
    }
}
