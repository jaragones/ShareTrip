//
//  SCReport+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 11/5/24.
//
//  Description. Some auxiliar methods for SCReport and Core Data interaction.

import CoreData

extension SCReport {
    static func saveReport(name: String, surname: String, email: String, phone: String, content: String, date: Date, in context: NSManagedObjectContext) -> SCReport {
        var newReport: SCReport!
        
        context.performAndWait {
            newReport = SCReport(context: context)
            newReport.name = name
            newReport.surname = surname
            newReport.email = email
            newReport.phone = phone
            newReport.date = date
            newReport.issue = content
            
            do {
                try context.save() // Save changes in the provided context
            } catch {
                print("Error saving SCReport: \(error)")
            }
        }
        
        return newReport
    }
    
    static func fetchAll(in context: NSManagedObjectContext) -> [SCReport] {
        let fetchRequest: NSFetchRequest<SCReport> = SCReport.fetchRequest()

        do {
            let reports = try context.fetch(fetchRequest)
            return reports
        } catch {
            print("Error fetching SCReports: \(error)")
            return []
        }
    }
}
