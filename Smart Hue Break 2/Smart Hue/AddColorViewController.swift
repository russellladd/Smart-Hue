//
//  AddColorViewController.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class AddColorViewController: UIViewController {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "New Color"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
        
        view.backgroundColor = UIColor.blueColor()
    }
}
