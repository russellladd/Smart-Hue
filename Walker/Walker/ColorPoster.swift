//
//  ColorPoster.swift
//  Walker
//
//  Created by Russell Ladd on 3/11/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorPoster {
    
    var color: Color? {
        didSet {
            
            timer?.invalidate()
            timer = nil
            
            if color != nil {
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "post:", userInfo: nil, repeats: true)
                post(timer!)
            }
        }
    }
    
    private var timer: NSTimer?
    
    private let session = NSURLSession.sharedSession()
    
    @objc func post(timer: NSTimer) {
        
        guard let color = color, let deviceID = UIDevice.currentDevice().identifierForVendor else {
            return
        }
        
        let url = NSURL(string: "http://NAME.herokuapp.com")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        var jsonObject = color.jsonObject
        jsonObject["deviceID"] = deviceID.UUIDString
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonObject, options: [])
        
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if let data = data, let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                print(json)
            } else {
                print(response)
            }
        }
        
        task.resume()
    }
}
