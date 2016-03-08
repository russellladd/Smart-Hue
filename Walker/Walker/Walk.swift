//
//  Walk.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import Foundation

struct Walk {
    var startDate: NSDate!
    var endDate: NSDate?

    var numberOfSteps: Int!

    init(startDate: NSDate = NSDate(), numberOfSteps: Int = 0) {
        self.startDate = startDate
        self.numberOfSteps = numberOfSteps
    }
}