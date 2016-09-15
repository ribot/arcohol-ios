//
//  TopCollectionViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 30/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class TopCollectionViewController: BaseCollectionViewController {
    private let reuseTopIdentifier = "TopCollectionViewCell"
    var array: [WineCategory] = [] {
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
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(reuseTopIdentifier, forIndexPath: indexPath) as! TopCollectionViewCell
        cell.label.text = array[indexPath.row].wineCategoryName
        let image = UIImage(named: cell.selected ? array[indexPath.row].wineCategoryImageNameHighlight() : array[indexPath.row].wineCategoryImageNameNormal())
        cell.imageView.image = image
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectCategory(array[indexPath.row].winesArray)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TopCollectionViewCell {
            self.categoryCellSelected(true, cell: cell, index: indexPath.row)
        }
    }

    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TopCollectionViewCell {
            self.categoryCellSelected(false, cell: cell, index: indexPath.row)
        }
    }

    func findItemRowForName(name: String) {
        if let index = array.indexOf({$0.wineCategoryName == name}) {
            let indexPath = NSIndexPath(forItem:index, inSection: 0)
            self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem:index, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
            if let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as? TopCollectionViewCell {
                self.categoryCellSelected(true, cell: cell, index: indexPath.row)
            }
        }
    }

    func categoryCellSelected(selected: Bool, cell: TopCollectionViewCell, index: Int) {
        cell.imageView.image = UIImage(named: selected ? array[index].wineCategoryImageNameHighlight() : array[index].wineCategoryImageNameNormal())
    }

}
