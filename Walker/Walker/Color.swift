//
//  Walk.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

struct Color {
    
    var hue = 0.0
    var saturation = 1.0
    var brightness = 1.0
    
    var displayColor: UIColor {
        return UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1.0)
    }
    
    var jsonObject: [String: AnyObject] {
        return ["hue": hue, "saturation": saturation, "brightness": brightness]
    }
}
