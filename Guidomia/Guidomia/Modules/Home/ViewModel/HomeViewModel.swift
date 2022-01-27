//
//  HomeViewModel.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import Foundation

struct HomeViewModel {
    private let cars: [CarDTO]

    init() {
        let cars: [CarDTO] = JSONParser.parse(resource: "car_list", intoType: [CarDTO].self) ?? []
        self.cars = cars
    }
}

// MARK: - TableView Data Source

extension HomeViewModel {
    func numberOfRows() -> Int {
        cars.count
    }

    /// Returns a "ready" (meaning, already formatted) model for `CarDetailCollapsedCellContent`.
    func getCarDetailCollapsedCellContent(at row: Int) -> CarDetailCollapsedCellContent? {
        guard let car = cars[safe: row] else { return nil }

        let name = "\(car.make) \(car.model)"
        let imageName = "\(name.split(separator: " ").joined(separator: "_")).jpg"
        let price = "Price : \(car.marketPrice.roundedWithAbbreviations)"

        var starRatings: [String] = []

        for _ in 0 ..< car.rating {
            starRatings.append("★")
        }

        let rating = starRatings.joined(separator: " ")
        let isLastCell = row == cars.count - 1

        let content = CarDetailCollapsedCellContent(
            name: name,
            imageName: imageName,
            price: price,
            rating: rating,
            isLastCell: isLastCell
        )

        return content
    }
}
