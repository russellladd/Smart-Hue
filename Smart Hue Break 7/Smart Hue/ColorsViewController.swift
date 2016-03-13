//
//  ColorsViewController.swift
//  Smart Hue
//
//  Created by Russell Ladd on 3/12/16.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddColorViewControllerDelegate, RoomDetectorDelegate {
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "My Colors"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addColorAction")
        
        roomDetector.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Model
    
    var colors = [Color]()
    
    var selectedColorIndex: Int? {
        didSet {
            
            if let oldValue = oldValue {
               collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: oldValue, inSection: 0)])
            }
            
            if let selectedColorIndex = selectedColorIndex {
                
                collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: selectedColorIndex, inSection: 0)])
                
                colorServer.color = colors[selectedColorIndex]
                
            } else {
                
                colorServer.color = nil
            }
        }
    }
    
    let roomDetector = RoomDetector()
    
    func roomDetector(roomDetector: RoomDetector, didChangeRoom room: Int?) {
        colorServer.room = room
    }
    
    let colorServer = ColorServer()
    
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
        collectionView.registerClass(ColorCell.self, forCellWithReuseIdentifier: "Color Cell")
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Color Cell", forIndexPath: indexPath) as! ColorCell
        
        cell.imageView.hidden = (indexPath.item != selectedColorIndex)
        
        cell.backgroundColor = colors[indexPath.row].displayColor
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
        selectedColorIndex = indexPath.item
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














