//
//  UIImage+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//
//  Description. Some extension parameters for UIImage type

import UIKit

extension UIImage {
    func resizedImage(with targetSize: CGSize) -> UIImage? {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        UIGraphicsBeginImageContextWithOptions(scaledImageSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
