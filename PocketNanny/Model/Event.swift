//
//  Event.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-23.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var sectionIdentifier: String
    @NSManaged var timeStamp: NSDate
    @NSManaged var diaper: NSManagedObject
    @NSManaged var meal: NSManagedObject
    @NSManaged var sleep: NSManagedObject

}
