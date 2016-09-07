//
//  BottomCollectionViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 30/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class BottomCollectionViewController: BaseCollectionViewController {
    private let reuseBottomIdentifier = "BottomCollectionViewCell"
    var array: [Wine] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.collectionView?.reloadData()
            }
        }
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(reuseBottomIdentifier, forIndexPath: indexPath) as! BottomCollectionViewCell
        cell.label.text = array[indexPath.row].wineName
        let image = UIImage(named: "meat.pdf")
        cell.imageView.image = image
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectWine(indexPath.row)
    }
}
