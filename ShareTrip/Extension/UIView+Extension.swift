//
//  UIView+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 13/11/25.
//

import UIKit

extension UIView {

    // MARK: - Corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    // MARK: - Border
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Shadow
    func applyShadow(color: UIColor = .black,
                     alpha: Float = 0.1,
                     x: CGFloat = 0,
                     y: CGFloat = 2,
                     blur: CGFloat = 6) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
    }

    // MARK: - Load From Nib
    static func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
