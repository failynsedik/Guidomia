//
//  CarDetailExpandedCellContent.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import Foundation

struct CarDetailExpandedCellContent {
    let collapsedContent: CarDetailCollapsedCellContent
    let pros: [NSMutableAttributedString]
    let cons: [NSMutableAttributedString]
    let isLastCell: Bool
}
