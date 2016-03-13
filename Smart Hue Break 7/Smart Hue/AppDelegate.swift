//
//  AppDelegate.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        // Create window
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let navigationController = UINavigationController(rootViewController: ColorsViewController())
        window.rootViewController = navigationController
        
        window.backgroundColor = UIColor.whiteColor()
        
        // Display window
        
        self.window = window
        
        window.makeKeyAndVisible()
        
        return true
    }
}
