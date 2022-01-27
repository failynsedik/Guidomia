//
//  Double+RoundOff.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import Foundation

extension Double {
    var roundedWithAbbreviations: String {
        let number = Double(self)

        let thousand = number / 1000
        let million = number / 1_000_000

        if number >= 1000, number < 1_000_000 {
            if floor(thousand) == thousand {
                return "\(Int(thousand))k"
            }

            return "\(thousand.roundToPlaces(1))k"
        }

        if number > 1_000_000 {
            if floor(million) == million {
                return "\(Int(thousand))k"
            }

            return "\(million.roundToPlaces(1))M"
        } else {
            if floor(number) == number {
                return "\(Int(number))"
            }

            return "\(number)"
        }
    }

    func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
