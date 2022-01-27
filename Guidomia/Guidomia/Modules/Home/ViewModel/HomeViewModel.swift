//
//  HomeViewModel.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

enum HomeSection: Int, CaseIterable {
    case header
    case carList
}

final class HomeViewModel {
    private let cars: [CarDTO]
    var expandedCellRow: Int = 0
    private var filteredCars: [CarDTO] = []
    private var makeQueryString: String = ""
    private var modelQueryString: String = ""

    init() {
        let cars: [CarDTO] = JSONParser.parse(resource: "car_list", intoType: [CarDTO].self) ?? []
        self.cars = cars
        filteredCars = cars
    }
}

// MARK: - TableView Data Source

extension HomeViewModel {
    func numberOfRows() -> Int {
        filteredCars.count
    }

    /// Returns a "ready" (meaning, already formatted) model for `CarDetailCollapsedCellContent`.
    func getCarDetailCollapsedCellContent(at row: Int) -> CarDetailCollapsedCellContent? {
        guard let car = filteredCars[safe: row] else { return nil }

        let name = "\(car.make) \(car.model)"
        let imageName = "\(name.split(separator: " ").joined(separator: "_")).jpg"
        let price = "Price : \(car.marketPrice.roundedWithAbbreviations)"

        var starRatings: [String] = []

        for _ in 0 ..< car.rating {
            starRatings.append("★")
        }

        let rating = starRatings.joined(separator: " ")
        let isLastCell = row == filteredCars.count - 1

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
        guard let car = filteredCars[safe: row],
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
            isLastCell: row == filteredCars.count - 1
        )

        return content
    }
}

// NOTE: Accessible privately since the configuration is very custom to this particular view's needs.
private extension String {
    var attributed: NSMutableAttributedString {
        let string = "• \(self)"
        let attributedString = NSMutableAttributedString(
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold),
            ]
        )

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 4
        paragraphStyle.paragraphSpacingBefore = 3
        paragraphStyle.firstLineHeadIndent = 8
        paragraphStyle.headIndent = 19

        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: string.count)
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

// MARK: - Filter

extension HomeViewModel {
    func didFilterMake(make: String) {
        makeQueryString = make
        filterCars()
    }

    func didFilterModel(model: String) {
        modelQueryString = model
        filterCars()
    }

    func filterCars() {
        let makeQueryStringIsEmpty = makeQueryString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let modelQueryStringIsEmpty = modelQueryString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        if makeQueryStringIsEmpty, modelQueryStringIsEmpty {
            // Set the original cars array if there are no filters
            filteredCars = cars
        } else {
            // Filter the original cars array and set the result to `filteredCars`
            if !makeQueryStringIsEmpty, !modelQueryStringIsEmpty {
                // If both queries/filters are not empty...
                filteredCars = cars.filter { $0.make.contains(makeQueryString) && $0.model.contains(modelQueryString) }
            } else if !makeQueryStringIsEmpty, modelQueryStringIsEmpty {
                // If only make query is not empty...
                filteredCars = cars.filter { $0.make.contains(makeQueryString) }
            } else if makeQueryStringIsEmpty, !modelQueryStringIsEmpty {
                // If only model query is not empty...
                filteredCars = cars.filter { $0.model.contains(modelQueryString) }
            } else {
                // Fallback if both are empty, but this should never happen because
                // of the above check
                filteredCars = cars
            }
        }
    }
}
