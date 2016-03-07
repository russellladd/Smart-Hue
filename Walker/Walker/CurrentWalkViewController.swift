//
//  CurrentWalkViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit
import CoreMotion

protocol CurrentWalkViewControllerDelegate: class {
    
    func onWalkViewControllerDidCancel()
    func onWalkViewController(onWalkViewController: CurrentWalkViewController, didFinishWithWalk walk: Int)
}

class CurrentWalkViewController: UIViewController {

    let pedometer = CMPedometer()

    let circleView = CircleView()
    let stepsLabel = UILabel()

    var numberOfSteps: Int = 0 {
        didSet {
            updateNumberOfStepsLabel()
        }
    }

    private func updateNumberOfStepsLabel() {
        stepsLabel.text = numberOfSteps.description
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        circleView.translatesAutoresizingMaskIntoConstraints = false
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false

        updateNumberOfStepsLabel()
        stepsLabel.textAlignment = .Center
        stepsLabel.textColor = UIColor.whiteColor()
        stepsLabel.font = UIFont.systemFontOfSize(22.0)

        self.view.addSubview(circleView)
        self.view.addSubview(stepsLabel)

        NSLayoutConstraint.activateConstraints([
            circleView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5),
            circleView.heightAnchor.constraintEqualToAnchor(circleView.widthAnchor),
            circleView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
            circleView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),

            // Steps Label
            stepsLabel.centerXAnchor.constraintEqualToAnchor(self.circleView.centerXAnchor),
            stepsLabel.centerYAnchor.constraintEqualToAnchor(self.circleView.centerYAnchor)
        ])

        pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: {
            data, error in
            if let err = error {
                print(err)
            } else {
                self.numberOfSteps = data?.numberOfSteps as! Int
            }
        })
    }
}