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
    let trip: Trip?
    
    var path: GMSPath? {
        return GMSPath(fromEncodedPath: self.trip?.route ?? "")
    }
    var polyline: GMSPolyline? {
        return path.map { GMSPolyline(path: $0) }
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapViewOptions = GMSMapViewOptions()
        let mapView = GMSMapView(options: mapViewOptions)

        if let path = path {
            let bounds = GMSCoordinateBounds(path: path)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 50) // Adjust padding as needed
            mapView.moveCamera(update)
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 5.0
            polyline.map = mapView // Add the polyline to the map
        }
        
        // Set the initial camera position to a specific coordinate (e.g., Barcelona)
        let barcelonaCoordinate = CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734)
        let cameraPosition = GMSCameraPosition.camera(withTarget: barcelonaCoordinate, zoom: 12.0)
        mapView.camera = cameraPosition
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
