//
//  UIView+Shadow.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/28/22.
//

import UIKit

extension UIView {
    /// Adds a shadow to a `UIView`.
    /// - Parameters:
    ///   - x: Shadow offset's `width`
    ///   - y: Shadow offset's `height`
    ///   - blur: Shadow radius
    ///   - color: Shadow's color
    ///   - shadowOpacity: Shadow's opacity
    func addShadow(
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat,
        color: UIColor,
        shadowOpacity: Float
    ) {
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur

        // Render and cache the layer
        layer.shouldRasterize = true
        // Make sure the cache is retina (the default is 1.0)
        layer.rasterizationScale = UIScreen.main.scale
    }
}
