//
//  ViewController.swift
//  RoomSimulator
//
//  Created by Russell Ladd on 3/11/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

import CoreLocation
import CoreBluetooth

class ViewController: UIViewController {
    
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
    
    func broadcastSwitchValueChanged() {
        
        roomSegmentedControl.enabled = broadcastingSwitch.on
    }
    
    func roomSegmentedControlValueChanged() {
        
        
    }
}
