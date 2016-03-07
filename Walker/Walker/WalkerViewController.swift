//
//  ViewController.swift
//  Walker
//
//  Created by Connor Krupp on 07/03/2016.
//  Copyright © 2016 Michigan Hackers. All rights reserved.
//

import UIKit

class WalkerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Walks"

        let startButton = UIBarButtonItem(title: "Start Walk", style: .Done, target: self, action: "startWalk")

        self.navigationItem.setRightBarButtonItem(startButton, animated: true)

    }

    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 120)

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(WalkCell.self, forCellWithReuseIdentifier: "identifier")

        self.view.addSubview(collectionView)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! WalkCell
        cell.stepsLabel.text = "Hello"

        if indexPath.row == 52 {
            cell.stepsLabel.text = "It's me"
        }

        return cell

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func startWalk() {
        self.navigationController?.pushViewController(CurrentWalkViewController(), animated: true)
    }

}
