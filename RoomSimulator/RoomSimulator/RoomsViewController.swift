//
//  RoomsViewController.swift
//  RoomSimulator
//
//  Created by Russell Ladd on 3/11/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

import CoreLocation
import CoreBluetooth

class RoomsViewController: UIViewController {
    
    // MARK: Peripheral manager
    
    let peripheralManager = CBPeripheralManager()
    
    func beaconRegionForRoom(room: Int) -> CLBeaconRegion {
        
        return CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "41EF49E6-2CD2-4F0C-A96A-2C23AD612746")!, major: UInt16(room), minor: 0, identifier: "rooms")
    }
    
    // MARK: Model
    
    var currentRoom: Int? {
        didSet {
            
            if oldValue != nil {
                peripheralManager.stopAdvertising()
            }
            
            if let currentRoom = currentRoom {
                let beaconPeripheralData = beaconRegionForRoom(currentRoom).peripheralDataWithMeasuredPower(nil)
                peripheralManager.startAdvertising(beaconPeripheralData.copy() as? [String: AnyObject])
            }
        }
    }
    
    // MARK: View
    
    var broadcastingSwitch: UISwitch!
    var roomSegmentedControl: UISegmentedControl!
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        let broadcastingLabel = UILabel()
        broadcastingLabel.translatesAutoresizingMaskIntoConstraints = false
        broadcastingLabel.text = "Broadcasting"
        
        broadcastingSwitch = UISwitch()
        broadcastingSwitch.translatesAutoresizingMaskIntoConstraints = false
        broadcastingSwitch.on = false
        broadcastingSwitch.addTarget(self, action: "broadcastSwitchValueChanged", forControlEvents: .ValueChanged)
        
        let broadcastingStackView = UIStackView(arrangedSubviews: [broadcastingLabel, broadcastingSwitch])
        broadcastingStackView.translatesAutoresizingMaskIntoConstraints = false
        broadcastingStackView.axis = .Horizontal
        
        roomSegmentedControl = UISegmentedControl(items: ["Room 1", "Room 2", "Room 3"])
        roomSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        roomSegmentedControl.enabled = false
        roomSegmentedControl.selectedSegmentIndex = 0
        roomSegmentedControl.addTarget(self, action: "roomSegmentedControlValueChanged", forControlEvents: .ValueChanged)
        
        let containerStackView = UIStackView(arrangedSubviews: [broadcastingStackView, roomSegmentedControl])
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .Vertical
        containerStackView.spacing = 20.0
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activateConstraints([
            containerStackView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            containerStackView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        ])
    }
    
    // MARK: Actions
    
    func broadcastSwitchValueChanged() {
        
        roomSegmentedControl.enabled = broadcastingSwitch.on
        
        updateCurrentRoom()
    }
    
    func roomSegmentedControlValueChanged() {
        
        updateCurrentRoom()
    }
    
    func updateCurrentRoom() {
        currentRoom = broadcastingSwitch.on ? roomSegmentedControl.selectedSegmentIndex : nil
    }
}
