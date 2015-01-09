//
//  DayTraffic.swift
//  Traffic
//
//  Created by Anna Liu on 1/8/15.
//  Copyright (c) 2015 Anna Liu. All rights reserved.
//

import Foundation

class DayTraffic {
    var date: NSDate!
    var time: Int = 0
    
    init() {
        date = NSDate()
        time = 0
    }
    
    init(newTime: Int) {
        date = NSDate()
        time = newTime
    }
    
    init(newDate: NSDate, newTime: Int) {
        date = newDate
        time = newTime
    }
}