//
//  BottomCollectionViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 30/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class BottomCollectionViewController: UICollectionViewController {
    private let reuseBottomIdentifier = "BottomCollectionViewCell"
    var array: NSMutableArray = ["Meat", "Fish", "Pasta", "Cheese", "Dessert", "Vegetables", "Ocassions"]

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView!.collectionViewLayout.invalidateLayout()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.collectionView!.frame.height, height: self.collectionView!.frame.height)
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(reuseBottomIdentifier, forIndexPath: indexPath) as! BottomCollectionViewCell
        cell.label.text = array[indexPath.row] as? String
        let image = UIImage(named: "meat.pdf")
        cell.imageView.image = image
        return cell
    }
}
