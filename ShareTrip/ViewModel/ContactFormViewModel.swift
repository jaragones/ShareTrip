//
//  ContactViewModel.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import Foundation
import CoreData
import UserNotifications

class ContactFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var reportDescription: String = ""
    @Published var reportDate = Date()

    var isFormValid: Bool {
        // Check if all required fields (except phone) are non-empty
        !name.isEmpty && !surname.isEmpty && !email.isEmpty && !reportDescription.isEmpty
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func submitReport() {
        // Handling form data and storing into core data
        //    using background context for writing
        let persistenceController = PersistenceController.shared
        let backgroundContext = persistenceController.backgroundContext
        _ = SCReport.saveReport(name: name, surname: surname, email: email, phone: phone, content: reportDescription, date: reportDate, in: backgroundContext)
        
        // using background context for reading and refresh badge.
        //    badge is refreshed here rather than when closing app
        //    due to the only way to manage SCReport is this method
        let issues = SCReport.fetchAll(in: persistenceController.container.viewContext)
        UNUserNotificationCenter.current().requestAuthorization (options: .badge) { _, _ in
            UNUserNotificationCenter.current().setBadgeCount(issues.count, withCompletionHandler: nil)
        }
    }
}
