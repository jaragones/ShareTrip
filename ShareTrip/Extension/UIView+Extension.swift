//
//  UIView+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 14/11/25.
//

import UIKit

extension UIView {

    // MARK: - Layout

    /// Pins the view to its superview's edges with optional insets
    func pinToSuperviewEdges(insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else {
            assertionFailure("No superview for \(self)")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }

    // MARK: - Styling

    /// Adds rounded corners
    func roundCorners(_ radius: CGFloat = 12) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    /// Adds shadows to the view
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.15,
        radius: CGFloat = 8,
        offset: CGSize = .init(width: 0, height: 3)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }

    /// Adds border to the view
    func addBorder(width: CGFloat = 1, color: UIColor = .lightGray) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    // MARK: - Animations

    /// Fades the view in
    func fadeIn(duration: TimeInterval = 0.3, delay: TimeInterval = 0) {
        alpha = 0
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseOut
        ) { self.alpha = 1 }
    }

    /// Fades the view out
    func fadeOut(duration: TimeInterval = 0.3, delay: TimeInterval = 0) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseOut
        ) { self.alpha = 0 }
    }

    // MARK: - Nib Loading

    /// Loads a UIView from a XIB with the same class name
    class func loadNib() -> Self {
        func instantiate<T>() -> T {
            let name = String(describing: self)
            let nib = UINib(nibName: name, bundle: Bundle(for: self))
            return nib.instantiate(withOwner: nil, options: nil).first as! T
        }
        return instantiate()
    }
}
