//
//  GTextField.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/28/22.
//

import UIKit

class GTextField: UITextField {
    var leftPadding: CGFloat = 0
    var rightPadding: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: bounds.origin.x + leftPadding,
            y: bounds.origin.y,
            width: bounds.width - rightPadding * 2,
            height: bounds.height
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: bounds.origin.x + leftPadding,
            y: bounds.origin.y,
            width: bounds.width - rightPadding * 2,
            height: bounds.height
        )
    }
}
