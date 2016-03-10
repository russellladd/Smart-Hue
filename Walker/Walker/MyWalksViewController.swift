//
//  ViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class MyWalksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CurrentWalkViewControllerDelegate {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "My Colors"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "startWalk")
        self.navigationItem.setRightBarButtonItem(addButton, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Model
    
    var colors = [Color]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: View
    
    var collectionView: UICollectionView!
    
    // MARK: View life cycle
    
    override func loadView() {
        
        // Create view
        
        view = UIView()
        
        // Create layout
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        layout.itemSize = CGSize(width: 60.0, height: 60.0)
        
        // Create collection view
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(WalkCell.self, forCellWithReuseIdentifier: "Walk Cell")
        
        view.addSubview(collectionView)
        
        // Create constraints
        
        NSLayoutConstraint.activateConstraints([
            collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            collectionView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            collectionView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        ])
    }
    
    // MARK: Collection view data source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Walk Cell", forIndexPath: indexPath) as! WalkCell

        //cell.circleView.color = UIColor.blueColor()

        return cell
    }
    
    // MARK: Actions
    
    func startWalk() {
        
        let currentWalkViewController = CurrentWalkViewController()
        currentWalkViewController.delegate = self
        
        let currentWalkNavigationController = UINavigationController(rootViewController: currentWalkViewController)
        
        presentViewController(currentWalkNavigationController, animated: true, completion: nil)
    }
    
    // MARK: Current walk view controller delegate
    
    func currentWalkViewControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func currentWalkViewController(currentWalkViewController: CurrentWalkViewController, didFinishWithWalk walk: Color) {
        
        colors.append(walk)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
