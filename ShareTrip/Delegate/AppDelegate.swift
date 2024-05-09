//
//  AppDelegate.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import UIKit
import SwiftUI
import GoogleMaps

// Define your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    static var shared: AppDelegate!

    override init() {
        super.init()
        AppDelegate.shared = self // set the shared instance
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialization code here
        GMSServices.provideAPIKey("AIzaSyA3uj9CfqLAnmqS6V3LhxPvLBUgfMlz17s")
                
        return true
    }
}

@main
struct ShareTrip: App {
    // Connect your AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
