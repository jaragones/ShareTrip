//
//  UIView+Extension.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 13/11/25.
//

import UIKit

extension UIView {

    // MARK: - Frame Shortcuts
    var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }

    var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }

    var x: CGFloat {
        get { frame.origin.x }
        set { frame.origin.x = newValue }
    }

    var y: CGFloat {
        get { frame.origin.y }
        set { frame.origin.y = newValue }
    }

    // MARK: - Styling Helpers
    func roundCorners(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? (min(bounds.width, bounds.height) / 2)
        layer.masksToBounds = true
    }

    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.1,
        offset: CGSize = .init(width: 0, height: 2),
        radius: CGFloat = 4
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }

    func addBorder(color: UIColor = .lightGray, width: CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    // MARK: - Animations
    func fadeIn(duration: TimeInterval = 0.3) {
        alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }

    func fadeOut(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }

    func bounce(scale: CGFloat = 1.05, duration: TimeInterval = 0.15) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            }
        }
    }

    // MARK: - Convenience
    /// Loads a UIView from a nib file with the same name as the class.
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    /// Pins the view to all edges of its superview.
    func pinToSuperviewEdges(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
