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
    @State private var selectedMarker: GMSMarker? = nil
    var trip: Trip?


    var path: GMSPath? {
        return GMSPath(fromEncodedPath: self.trip?.route ?? "")
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapViewOptions = GMSMapViewOptions()
        let mapView = GMSMapView(options: mapViewOptions)
        mapView.delegate = context.coordinator

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
            newPolyline.strokeColor = .darkGray
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
        marker.userData = ["type" : "origin", "value" : trip]
        marker.icon = addImageAsMarker(name: "ic_destinationMarker", color: .blue)
        markers.append(marker)

        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.trip!.destination.point.latitude, longitude: self.trip!.destination.point.longitude)
        marker.userData = ["type" : "destination", "value" : trip]
        marker.icon = addImageAsMarker(name: "ic_destinationMarker", color: .blue)
        markers.append(marker)

        for stop in trip.validStops {
            if let point = stop.point {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                marker.title = "stop"
                marker.userData = ["type" : "stop", "value" : stop.id as Any]
                marker.icon = addImageAsMarker(name: "ic_stopMarker", color: .red)
                markers.append(marker)
            }
         }
        
        return markers
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: MapsView

        init(_ parent: MapsView) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if mapView.selectedMarker === marker {
                // The marker is already selected, so hide the info window
                mapView.selectedMarker = nil
                // Hide the custom info window view
                marker.iconView = nil
                return true
            } else {
                mapView.selectedMarker = marker
                return true
            }
        }
        
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
            if marker == mapView.selectedMarker {
                var address: String = ""
                var time: String = ""
                var username: String = ""
                
                if let data = marker.userData as? [String: Any] {
                    if data["type"] as! String == "stop" {
                        if let stop = getExtendedStop(data["value"] as Any) {
                            address = stop.address
                            username = stop.userName
                            time = stop.stopTime
                        } else {
                            return nil
                        }
                    } else {
                        let trip = data["value"] as! Trip
                        let type = data["type"] as! String
                        address = (type == "origin") ? trip.origin.address : trip.destination.address
                        time = (type == "origin") ? trip.startTime : trip.endTime
                        username = trip.driverName
                    }
                    
                    let bubbleWindow = UIHostingController(rootView: MapBubbleView(address: address, time: time, username: username))
                    bubbleWindow.view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
                    bubbleWindow.view.backgroundColor = UIColor.clear
                    return bubbleWindow.view
                } else {
                    return nil
                }
            }
            return nil
        }
        
        func getExtendedStop(_ data: Any) -> StopExtended? {
            let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json")!
            do {
                let stop = try JSONDecoder().decode(StopExtended.self, from: Data(contentsOf: url))
                return stop
            } catch {
                print("Error fetching data: \(error)")
            }
            return nil
        }
    }
    
    private func addImageAsMarker(name: String, color: UIColor) -> UIImage? {
        if let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) {
            let tintedImg = image.withTintColor(color)
            return tintedImg.resizedImage(with: CGSize(width: 35, height: 35))
        }
        
        return nil
    }
}
