//
//  AppDelegate.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import UIKit
import SwiftUI
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    static var shared: AppDelegate!

    override init() {
        super.init()
        AppDelegate.shared = self
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeGoogleMaps()
                
        return true
    }
    
    // Google Maps initialization
    //    APIkey is stored under credentials.plist file with name 'GoogleMapsAPIKey'
    //    NOTE. This value is set and push to github! This shouldn't be done!
    //          Just doing it, because not sure if reviewer of this test
    //          will have one.
    private func initializeGoogleMaps() {
        if let path = Bundle.main.path(forResource: "credentials", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: path),
            let apiKey = keys["GoogleMapsAPIKey"] as? String {
            GMSServices.provideAPIKey(apiKey)
        }
    }
}

@main
struct ShareTrip: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
