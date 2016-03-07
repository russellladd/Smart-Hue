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

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    func commonInit() {

        updatePath()
        updateFillColor()
    }

    // MARK: Properties

    override var bounds: CGRect {
        didSet {
            updatePath()
        }
    }

    // MARK: Shape layer

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }

    private var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }

    private func updatePath() {
        shapeLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    }

    private func updateFillColor() {
        shapeLayer.fillColor = tintColor?.CGColor
    }
}