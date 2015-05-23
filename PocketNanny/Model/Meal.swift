//
//  Meal.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-23.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import Foundation
import CoreData

class Meal: NSManagedObject {

    @NSManaged var breastMilk: NSNumber
    @NSManaged var cereal: NSNumber
    @NSManaged var formula: NSNumber
    @NSManaged var event: Event

}
