//
//  Sleep.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-23.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import Foundation
import CoreData

class Sleep: NSManagedObject {

    @NSManaged var end: NSDate
    @NSManaged var start: NSDate
    @NSManaged var event: Event

}
