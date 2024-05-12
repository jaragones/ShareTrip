//
//  ColorExtensionTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import XCTest
import SwiftUI
@testable import ShareTrip

class ColorExtensionTests: XCTestCase {
    
    func testColorInitWithHex() {
        // Test standard 6-digit hex
        let color = Color(hex: "FF5733")
        assertColorsEqual(color, Color(red: 1, green: 0.3412, blue: 0.2))
        
        // Test 3-digit hex
        let shortColor = Color(hex: "F53")
        assertColorsEqual(shortColor, Color(red: 1, green: 0.3333, blue: 0.2))
        
        // Test 8-digit hex with alpha
        let alphaColor = Color(hex: "80FF5733")
        assertColorsEqual(alphaColor, Color(red: 1, green: 0.3412, blue: 0.2, opacity: 0.5019))
        
        // Test invalid hex
        let invalidColor = Color(hex: "GHIJKL")
        assertColorsEqual(invalidColor, Color(red: 0, green: 0, blue: 0))
    }
    
    private func assertColorsEqual(_ color1: Color, _ color2: Color, file: StaticString = #file, line: UInt = #line) {
        // Convert the SwiftUI Color to UIColor
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)
        
        // Get RGBA components from UIColor
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
        
        uiColor1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        uiColor2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        // Define a tolerance value
        let tolerance: CGFloat = 0.01
        
        // Compare the RGBA components with tolerance
        if abs(red1 - red2) > tolerance || abs(green1 - green2) > tolerance ||
           abs(blue1 - blue2) > tolerance || abs(alpha1 - alpha2) > tolerance {
            let message = "Expected colors to be equal within tolerance, but they were not. Color 1 RGBA: (\(red1), \(green1), \(blue1), \(alpha1)), Color 2 RGBA: (\(red2), \(green2), \(blue2), \(alpha2))"
            XCTFail(message, file: file, line: line)
        }
    }
}
