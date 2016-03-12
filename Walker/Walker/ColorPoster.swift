//
//  ColorPoster.swift
//  Walker
//
//  Created by Russell Ladd on 3/11/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorPoster {
    
    // MARK: Initialization
    
    init() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "post:", userInfo: nil, repeats: true)
    }
    
    deinit {
        timer.invalidate()
    }
    
    // MARK: Properties
    
    var room: Int?
    var color: Color?
    
    // MARK: Timer
    
    private var timer: NSTimer!
    
    private let session = NSURLSession.sharedSession()
    
    @objc func post(timer: NSTimer) {
        
        guard let room = room, let color = color, let deviceID = UIDevice.currentDevice().identifierForVendor else {
            return
        }
        
        let url = NSURL(string: "http://crowd-hue-server.herokuapp.com/api/color")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        var jsonObject = color.jsonObject
        jsonObject["room"] = room
        jsonObject["deviceID"] = deviceID.UUIDString
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonObject, options: [])
        
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard let response = response as? NSHTTPURLResponse else {
                print(error)
                return
            }
            
            if response.statusCode != 200 {
                print(response)
            }
        }
        
        task.resume()
    }
}
