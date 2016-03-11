//
//  ViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class MyWalksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ColorViewControllerDelegate {
    
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
        collectionView.registerClass(ColorCell.self, forCellWithReuseIdentifier: "Color Cell")
        
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

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Color Cell", forIndexPath: indexPath) as! ColorCell

        cell.circleView.color = colors[indexPath.item].displayColor

        return cell
    }
    
    // MARK: Actions
    
    func startWalk() {
        
        let addColorViewController = ColorViewController()
        addColorViewController.delegate = self
        
        let addColorNavigationController = UINavigationController(rootViewController: addColorViewController)
        
        presentViewController(addColorNavigationController, animated: true, completion: nil)
    }
    
    // MARK: Color view controller delegate
    
    func colorViewControllerDidCancel(colorViewController: ColorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func colorViewControllerDidFinish(colorViewController: ColorViewController, withColor color: Color) {
        
        colors.append(color)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func currentWalkViewControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
