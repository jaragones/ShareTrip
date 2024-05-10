//
//  MapsViewModel.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import SwiftUI
import Combine

class MapsViewModel: ObservableObject {
    @Published var stop: StopExtended?
    
    @Published var address: String?
    @Published var name: String?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    var userData: [String : Any] = [:]
      
    func initializeData() {
        let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json")!
        do {
            let stop = try JSONDecoder().decode(StopExtended.self, from: Data(contentsOf: url))
            self.address = stop.address
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
