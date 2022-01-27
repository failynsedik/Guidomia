//
//  CarDTO.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import Foundation

struct CarDTO: Decodable {
    let consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    let prosList: [String]
    let rating: Int
}
