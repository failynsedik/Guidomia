//
//  Car.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/28/22.
//

import CoreData

@objc(Car)
class Car: NSManagedObject {
    @NSManaged var consList: [String]
    @NSManaged var customerPrice: Double
    @NSManaged var make: String
    @NSManaged var marketPrice: Double
    @NSManaged var model: String
    @NSManaged var prosList: [String]
    @NSManaged var rating: Int
}
