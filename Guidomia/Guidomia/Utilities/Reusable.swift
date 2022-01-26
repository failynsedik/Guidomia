//
//  Reusable.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
