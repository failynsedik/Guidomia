//
//  CarFilterViewModel.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/28/22.
//

import Foundation

enum FilterFieldType {
    case make
    case model
}

final class CarFilterViewModel {
    var activeFilterFieldType: FilterFieldType?
    var carMakeList: [String] = []
    var carModelList: [String] = []

    func pickerViewNumberOfRows() -> Int {
        switch activeFilterFieldType {
        case .make: return carMakeList.count
        case .model: return carModelList.count
        default: return 0
        }
    }

    func pickerViewTitle(for row: Int) -> String {
        switch activeFilterFieldType {
        case .make:
            if let title = carMakeList[safe: row] {
                return title
            } else {
                return ""
            }

        case .model:
            if let title = carModelList[safe: row] {
                return title
            } else {
                return ""
            }

        default:
            return ""
        }
    }
}
