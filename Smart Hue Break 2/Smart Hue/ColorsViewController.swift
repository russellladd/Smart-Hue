//
//  ColorsViewController.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "My Colors"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addColorAction")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
    }
    
    // MARK: Actions
    
    func addColorAction() {
        
        let addColorViewController = AddColorViewController()
        
        let addColorNavigationController = UINavigationController(rootViewController: addColorViewController)
    
        presentViewController(addColorNavigationController, animated: true, completion: nil)
    }
}














