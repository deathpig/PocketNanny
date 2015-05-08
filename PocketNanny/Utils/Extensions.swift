//
//  Extensions.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-07.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import Foundation

extension NSDate {
    var formattedTimeOnly: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromDate(self)
    }
    
    var formatted: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromDate(self)
    }
}