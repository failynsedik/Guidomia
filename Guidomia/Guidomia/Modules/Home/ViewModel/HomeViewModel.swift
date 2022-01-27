//
//  HomeViewModel.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

final class HomeViewModel {
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

    /// Returns a "ready" (meaning, already formatted) model for `CarDetailExpandedCellContent`.
    func getCarDetailExpandedCellContent(at row: Int) -> CarDetailExpandedCellContent? {
        guard let car = cars[safe: row],
              let collapsedContent = getCarDetailCollapsedCellContent(at: row)
        else { return nil }

        let attributedPros: [NSMutableAttributedString] = car.prosList.filter { !$0.isEmpty }.map(\.attributed)
        let pros = attributedPros.isEmpty ? [NSMutableAttributedString(string: "None")] : attributedPros
        let attributedCons: [NSMutableAttributedString] = car.consList.filter { !$0.isEmpty }.map(\.attributed)
        let cons = attributedCons.isEmpty ? [NSMutableAttributedString(string: "None")] : attributedCons

        let content = CarDetailExpandedCellContent(
            collapsedContent: collapsedContent,
            pros: pros,
            cons: cons,
            isLastCell: row == cars.count - 1
        )

        return content
    }
}

// NOTE: Accessible privately since the configuration is very custom to this particular view's needs.
private extension String {
    var attributed: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(
            string: "• \(self)",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold),
            ]
        )

        attributedString.addAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.gOrange,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            ],
            range: NSRange(location: 0, length: 1)
        )

        return attributedString
    }
}
