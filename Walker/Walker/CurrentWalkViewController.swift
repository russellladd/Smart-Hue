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
    func currentWalkViewControllerDidCancel()
    func currentWalkViewController(currentWalkViewController: CurrentWalkViewController, didFinishWithWalk walk: Walk)
}

class CurrentWalkViewController: UIViewController {

    // MARK: Views

    let circleView = CircleView()
    let stepsLabel = UILabel()

    // MARK: Model

    let pedometer = CMPedometer()

    var currentWalk: Walk = Walk() {
        didSet {
            updateNumberOfStepsLabel()
        }
    }

    // MARK: Delegate

    weak var delegate: CurrentWalkViewControllerDelegate?

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        startPedometer()
    }

    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Current Walk"

        // UINavigationBar Content
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Done, target: self, action: "cancelWalk")
        let finishButton = UIBarButtonItem(title: "Finish", style: .Done, target: self, action: "finishWalk")
        self.navigationItem.setLeftBarButtonItem(cancelButton, animated: true)
        self.navigationItem.setRightBarButtonItem(finishButton, animated: true)

        circleView.translatesAutoresizingMaskIntoConstraints = false
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false

        updateNumberOfStepsLabel()
        stepsLabel.textAlignment = .Center
        stepsLabel.textColor = UIColor.whiteColor()
        stepsLabel.font = UIFont.systemFontOfSize(22.0)

        self.view.addSubview(circleView)
        self.view.addSubview(stepsLabel)

        NSLayoutConstraint.activateConstraints([
            // Circle View Constraints
            circleView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5),
            circleView.heightAnchor.constraintEqualToAnchor(circleView.widthAnchor),
            circleView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
            circleView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),

            // Steps Label Constraints
            stepsLabel.centerXAnchor.constraintEqualToAnchor(self.circleView.centerXAnchor),
            stepsLabel.centerYAnchor.constraintEqualToAnchor(self.circleView.centerYAnchor)
            ])
    }

    // MARK: Model Updating

    func startPedometer() {
        pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: {
            pedometerData, error in

            if let data = pedometerData {
                self.currentWalk.numberOfSteps = data.numberOfSteps.integerValue
            } else {
                print(error ?? "Unknown Error")
            }

        })
    }

    // MARK: View Updating

    func updateNumberOfStepsLabel() {
        stepsLabel.text = currentWalk.numberOfSteps.description
    }

    // MARK: Actions

    func cancelWalk() {
        self.delegate!.currentWalkViewControllerDidCancel()
    }

    func finishWalk() {
        currentWalk.endDate = NSDate()
        self.delegate!.currentWalkViewController(self, didFinishWithWalk: currentWalk)
    }
}