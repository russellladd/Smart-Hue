//
//  AddColorViewController.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit


protocol AddColorViewControllerDelegate: class {
    
    func addColorViewControllerDidCancel(addColorViewController: AddColorViewController)
    func addColorViewController(addColorViewController: AddColorViewController, didFinishWithColor color: Color)
}

class AddColorViewController: UIViewController {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "New Color"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelAction")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneAction")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Delegate
    
    weak var delegate: AddColorViewControllerDelegate?
    
    
    var circleView: CircleView!
    var slider: UISlider!
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        circleView = CircleView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: "hueSliderHasChanged", forControlEvents: .ValueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [circleView, slider])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 44.0
        
        view.addSubview(stackView)
        
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        NSLayoutConstraint.activateConstraints([
            layoutGuide.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            layoutGuide.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            layoutGuide.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            layoutGuide.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor),
            
            stackView.centerXAnchor.constraintEqualToAnchor(layoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraintEqualToAnchor(layoutGuide.centerYAnchor),
            stackView.widthAnchor.constraintEqualToAnchor(layoutGuide.widthAnchor, multiplier: 0.8)
        ])
        
        updateColorView()
    }
    
    var color = Color() {
        didSet {
            updateColorView()
        }
    }
    
    func updateColorView() {
        circleView.color = color.displayColor
    }
    
    func hueSliderHasChanged() {
        color.hue = Double(slider.value)
    }
    
    // MARK: Actions
    
    func cancelAction() {
        
        delegate?.addColorViewControllerDidCancel(self)
    }
    
    func doneAction() {
        
        delegate?.addColorViewController(self, didFinishWithColor: color)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
