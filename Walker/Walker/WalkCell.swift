//
//  WalkCell.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class WalkCell: UICollectionViewCell {

    var circleView: CircleView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {

        circleView = CircleView()
        circleView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(circleView)

        NSLayoutConstraint.activateConstraints([
            circleView.widthAnchor.constraintEqualToAnchor(self.widthAnchor),
            circleView.heightAnchor.constraintEqualToAnchor(self.heightAnchor),
            circleView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor),
            circleView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        ])
    }
}