//
//  CircleView.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class CircleView: UIView {

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        updatePath()
        updateFillColor()
        
        NSLayoutConstraint.activateConstraints([
            widthAnchor.constraintEqualToAnchor(heightAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layer class
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }

    // MARK: Properties

    override var bounds: CGRect {
        didSet {
            updatePath()
        }
    }
    
    var color: UIColor = UIColor.blackColor() {
        didSet {
            updateFillColor()
        }
    }

    // MARK: Shape layer

    private var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }

    private func updatePath() {
        shapeLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    }

    private func updateFillColor() {
        shapeLayer.fillColor = color.CGColor
    }
}