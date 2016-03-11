//
//  ViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class MyColorsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ColorViewControllerDelegate {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "My Colors"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addColor")
        self.navigationItem.setRightBarButtonItem(addButton, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Model
    
    var colors = [Color]()
    
    var selectedIndex: Int? {
        didSet {
            
            UIView.performWithoutAnimation {
                
                if let oldValue = oldValue {
                    self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: oldValue, inSection: 0)])
                }
                
                if let selectedIndex = self.selectedIndex {
                    self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: selectedIndex, inSection: 0)])
                }
            }
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
        collectionView.alwaysBounceVertical = true
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
        cell.imageView.hidden = (indexPath.item != selectedIndex)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        if selectedIndex == indexPath.item {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath.item
        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("Should show")
        return true
    }
    
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true // action == "delete:"
    }
    
    func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        if action == "delete:" {
            print("Delete")
        }
    }
    
    // MARK: Actions
    
    func addColor() {
        
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
        
        collectionView.performBatchUpdates({
            self.collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: self.colors.count - 1, inSection: 0)])
        }, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
