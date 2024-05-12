//
//  UIImageExtensionTests.swift
//  ShareTripTests
//
//  Created by Jordi Aragones Vilella on 11/5/24.
//

import XCTest
@testable import ShareTrip

class UIImageExtensionTests: XCTestCase {

    func testResizedImage() {
        // Given
        let originalImage = UIImage(named: "logo_SEATCode_round")!
        let targetSize = CGSize(width: 100, height: 100)

        // When
        let resizedImage = originalImage.resizedImage(with: targetSize)

        // Then
        XCTAssertNotNil(resizedImage, "The resized image should not be nil.")
        XCTAssertEqual(resizedImage?.size.width, targetSize.width, "The resized image width should match the target size width.")
        XCTAssertEqual(resizedImage?.size.height, targetSize.height, "The resized image height should match the target size height.")
    }

    func testResizedImageMaintainsAspectRatio() {
        // Given
        let originalImage = UIImage(named: "logo_SEATCode_round")! // Make sure this image is added to your test target
        let targetSize = CGSize(width: 100, height: 200)

        // When
        let resizedImage = originalImage.resizedImage(with: targetSize)

        // Then
        XCTAssertNotNil(resizedImage, "The resized image should not be nil.")
        let widthRatio = targetSize.width / originalImage.size.width
        let heightRatio = targetSize.height / originalImage.size.height
        let expectedScaleFactor = min(widthRatio, heightRatio)
        let expectedWidth = originalImage.size.width * expectedScaleFactor
        let expectedHeight = originalImage.size.height * expectedScaleFactor
        if let resizedImage = resizedImage {
            XCTAssertEqual(resizedImage.size.width, expectedWidth, accuracy: 0.001, "The resized image width should maintain the aspect ratio.")
            XCTAssertEqual(resizedImage.size.height, expectedHeight, accuracy: 0.001, "The resized image height should maintain the aspect ratio.")
        } else {
            XCTFail("Resize image is not properly formatted")
        }
    }
}
