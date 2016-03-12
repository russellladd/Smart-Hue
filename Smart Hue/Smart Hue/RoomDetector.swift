//
//  RoomDetector.swift
//  Walker
//
//  Created by Russell Ladd on 3/11/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import Foundation
import CoreLocation

protocol RoomDetectorDelegate: class {
    
    func roomDetector(roomDetector: RoomDetector, didChangeRoom room: Int?)
}

class RoomDetector: NSObject, CLLocationManagerDelegate {
    
    // MARK: Initialization
    
    override init() {
        
        super.init()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    // MARK: Location manager
    
    let locationManager = CLLocationManager()
    
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "41EF49E6-2CD2-4F0C-A96A-2C23AD612746")!, identifier: "rooms")
    
    // MARK: Delegate
    
    weak var delegate: RoomDetectorDelegate?
    
    // MARK: Current room
    
    private(set) var currentRoom: Int? {
        didSet {
            if currentRoom != oldValue {
                delegate?.roomDetector(self, didChangeRoom: currentRoom)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        if let beacon = beacons.first where beacon.proximity != .Unknown {
            
            currentRoom = beacon.major as Int
            
        } else {
            
            currentRoom = nil
        }
    }
}
