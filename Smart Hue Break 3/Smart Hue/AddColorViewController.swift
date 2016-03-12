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
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
        
        view.backgroundColor = UIColor.blueColor()
    }
    
    // MARK: Actions
    
    func cancelAction() {
        
        delegate?.addColorViewControllerDidCancel(self)
    }
    
    func doneAction() {
        
        
    }
    
    
    
}
