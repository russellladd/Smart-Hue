//
//  WalkCell.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class WalkCell: UICollectionViewCell {

    var stepsLabel: UILabel!
    var circleView: CircleView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {

        stepsLabel = UILabel()
        stepsLabel.textColor = UIColor.whiteColor()
        stepsLabel.font = UIFont.systemFontOfSize(18)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false

        let stepsLabelConstraints: [NSLayoutConstraint] = [
            stepsLabel.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor),
            stepsLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        ]


        circleView = CircleView()
        circleView.translatesAutoresizingMaskIntoConstraints = false


        let circleViewContraints: [NSLayoutConstraint] = [
            circleView.widthAnchor.constraintEqualToAnchor(self.widthAnchor),
            circleView.heightAnchor.constraintEqualToAnchor(self.heightAnchor),
            circleView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor),
            circleView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        ]

        self.addSubview(circleView)
        self.addSubview(stepsLabel)

        NSLayoutConstraint.activateConstraints(stepsLabelConstraints + circleViewContraints)
    }
}