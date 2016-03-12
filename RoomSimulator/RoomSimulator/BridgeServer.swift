//
//  BridgeServer.swift
//  RoomSimulator
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import Foundation

class BridgeServer {
    
    // MARK: Initialization
    
    init() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "put:", userInfo: nil, repeats: true)
    }
    
    deinit {
        timer.invalidate()
    }
    
    // MARK: Timer
    
    private var timer: NSTimer!
    
    private let session = NSURLSession.sharedSession()
    
    @objc func put(timer: NSTimer) {
        
        //let url = NSURL(string: "http://crowd-hue-server.herokuapp.com/api/bridge")!
        let url = NSURL(string: "http://192.168.86.111:3000/api/bridge")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        
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
