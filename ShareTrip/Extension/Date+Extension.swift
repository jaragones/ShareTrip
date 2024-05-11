//
//  Date+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI

extension Date {
    // used to convert any "date" string into Date based on format
    func fromStringWithFormat(str: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let isoDate = str
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to reliable US_POSIX
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: isoDate) {
            return date
        } else {
            return nil
        }
    }
    
    // shorted way to get Calendar component
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    static func getAbbreviationForMonth(from string: String) -> String {
        return Date().fromStringWithFormat(str: string)?.getShortMonthName() ?? "n/a"
    }
    
    static func getDayForDate(from string: String) -> String {
        if let date = Date().fromStringWithFormat(str: string) {
            return String(date.get(.day))
        } else {
            return "n/a"
        }
    }
    
    static func getHourForDate(from string: String) -> String {
        if let date = Date().fromStringWithFormat(str: string) {
            let hour = date.get(.hour)
            let minute = date.get(.minute)

            return String(format: "%02d:%02d", hour, minute)
        } else {
            return "n/a"
        }
    }

    private func getShortMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}
