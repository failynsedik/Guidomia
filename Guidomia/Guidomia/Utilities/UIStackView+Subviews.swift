//
//  UIStackView+Subviews.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap(\.constraints))

        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
