//
//  Diaper.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-23.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import Foundation
import CoreData

class Diaper: NSManagedObject {

    @NSManaged var solid: NSNumber
    @NSManaged var wet: NSNumber
    @NSManaged var event: Event

}
