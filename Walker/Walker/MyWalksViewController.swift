//
//  ViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class MyWalksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CurrentWalkViewControllerDelegate {

    // MARK: Constants

    let collectionViewTag = 10

    // MARK: Model

    var pastWalks = [Walk]()

    // MARK: View Controller Lifecycle

    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.title = "Walks"

        // UINavigationBar content

        let startButton = UIBarButtonItem(title: "Start Walk", style: .Done, target: self, action: "startWalk")
        self.navigationItem.setRightBarButtonItem(startButton, animated: true)

        // UICollectionView layout settings

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 120)

        // UICollectionView instantiation

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = collectionViewTag
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(WalkCell.self, forCellWithReuseIdentifier: "identifier")

        self.view.addSubview(collectionView)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! WalkCell
        cell.stepsLabel.text = pastWalks[indexPath.row].numberOfSteps.description

        return cell

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastWalks.count
    }

    func startWalk() {
        let currentWalkViewController = CurrentWalkViewController()
        let currentWalkNavigationController = UINavigationController(rootViewController: currentWalkViewController)
        currentWalkViewController.delegate = self

        presentViewController(currentWalkNavigationController, animated: true, completion: nil)
    }

    // MARK: CurrentWalkViewController Delegate

    func currentWalkViewControllerDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func currentWalkViewController(currentWalkViewController: CurrentWalkViewController, didFinishWithWalk walk: Walk) {
        pastWalks.append(walk)
        dismissViewControllerAnimated(true, completion: nil)
        (self.view.viewWithTag(collectionViewTag) as! UICollectionView).reloadData()
    }
    
}
