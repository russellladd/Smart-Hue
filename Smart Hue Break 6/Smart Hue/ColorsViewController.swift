//
//  ColorsViewController.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddColorViewControllerDelegate {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "My Colors"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addColorAction")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Model
    
    var colors = [Color]()
    
    // MARK: Views
    
    var collectionView: UICollectionView!
    
    // MARK: View life cycle
    
    override func loadView() {
        
        view = UIView()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        layout.itemSize = CGSize(width: 120.0, height: 120.0)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Color Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activateConstraints([
            collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            collectionView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            collectionView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        ])
    }
    
    // MARK: Actions
    
    func addColorAction() {
        
        let addColorViewController = AddColorViewController()
        
        addColorViewController.delegate = self
        
        let addColorNavigationController = UINavigationController(rootViewController: addColorViewController)
    
        presentViewController(addColorNavigationController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Color Cell", forIndexPath: indexPath)
        
        cell.backgroundColor = colors[indexPath.row].displayColor
        
        return cell
    }
    
    // MARK: Add color view controller delegate
    
    func addColorViewControllerDidCancel(addColorViewController: AddColorViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addColorViewController(addColorViewController: AddColorViewController, didFinishWithColor color: Color) {

        colors.append(color)
        
        collectionView.performBatchUpdates({
            self.collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: self.colors.count - 1, inSection: 0)])
            }, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}














