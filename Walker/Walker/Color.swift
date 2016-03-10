//
//  Walk.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

struct Color {

    var brightness = 0.0
    var hue = 0.0
    var saturation = 0.0

    init(brightness: Double, hue: Double, saturation: Double = 1) {
        self.brightness = brightness
        self.hue = hue
        self.saturation = saturation
    }
}