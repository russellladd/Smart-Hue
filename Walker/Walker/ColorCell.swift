//
//  WalkCell.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {

    let circleView = CircleView()
    let imageView = UIImageView(image: UIImage(named: "Checkmark")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(circleView)
        addSubview(imageView)
        
        updateImageViewHidden()
        
        NSLayoutConstraint.activateConstraints([
            circleView.widthAnchor.constraintEqualToAnchor(widthAnchor),
            circleView.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
            circleView.centerYAnchor.constraintEqualToAnchor(centerYAnchor),
            
            imageView.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
            imageView.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var highlighted: Bool {
        didSet {
            circleView.alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    override var selected: Bool {
        didSet {
            updateImageViewHidden()
        }
    }
    
    func updateImageViewHidden() {
        imageView.hidden = !selected
    }
}
