//
//  ColorViewController.swift
//  Walker
//
//  Created by Russell Ladd on 3/10/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

protocol ColorViewControllerDelegate: class {
    
    func colorViewControllerDidCancel(colorViewController: ColorViewController)
    func colorViewControllerDidFinish(colorViewController: ColorViewController, withColor color: Color)
}

class ColorViewController: UIViewController {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = NSLocalizedString("New Color", comment: "ColorViewController title")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneAction")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Color
    
    var color = Color() {
        didSet {
            updateColorView()
        }
    }
    
    // MARK: Delegate
    
    weak var delegate: ColorViewControllerDelegate?
    
    // MARK: Views
    
    var colorView: CircleView!
    var hueSlider: UISlider!
    
    func updateColorView() {
        colorView.color = color.displayColor
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        colorView = CircleView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        hueSlider = UISlider()
        hueSlider.translatesAutoresizingMaskIntoConstraints = false
        hueSlider.minimumTrackTintColor = UIColor(white: 0.8, alpha: 1.0)
        hueSlider.maximumTrackTintColor = UIColor(white: 0.8, alpha: 1.0)
        hueSlider.value = Float(color.hue)
        
        hueSlider.addTarget(self, action: "hueSliderValueChanged", forControlEvents: .ValueChanged)
        
        let containerStackView = UIStackView(arrangedSubviews: [colorView, hueSlider])
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .Vertical
        containerStackView.spacing = 44.0
        
        view.addSubview(containerStackView)
        
        let contentLayoutGuide = UILayoutGuide()
        contentLayoutGuide.identifier = "Content Layout Guide"
        view.addLayoutGuide(contentLayoutGuide)
        
        // Add constraints
        
        NSLayoutConstraint.activateConstraints([
            contentLayoutGuide.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            contentLayoutGuide.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor),
            
            containerStackView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            containerStackView.centerYAnchor.constraintEqualToAnchor(contentLayoutGuide.centerYAnchor),
            containerStackView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.8)
        ])
        
        // Update views
        
        updateColorView()
    }
    
    // MARK: Actions
    
    func cancelAction() {
        delegate?.colorViewControllerDidCancel(self)
    }
    
    func doneAction() {
        delegate?.colorViewControllerDidFinish(self, withColor: color)
    }
    
    func hueSliderValueChanged() {
        
        color.hue = Double(hueSlider.value)
    }
}
