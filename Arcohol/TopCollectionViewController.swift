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
    fileprivate let reuseTopIdentifier = "TopCollectionViewCell"
    var array: [WineCategory] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.collectionView?.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.allowsMultipleSelection = false
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: reuseTopIdentifier, for: indexPath) as! TopCollectionViewCell
        cell.label.text = array[(indexPath as NSIndexPath).row].wineCategoryName
        let image = UIImage(named: cell.isSelected ? array[(indexPath as NSIndexPath).row].wineCategoryImageNameHighlight() : array[(indexPath as NSIndexPath).row].wineCategoryImageNameNormal())
        cell.imageView.image = image
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectCategory(array[(indexPath as NSIndexPath).row].winesArray)
        if let cell = collectionView.cellForItem(at: indexPath) as? TopCollectionViewCell {
            self.categoryCellSelected(true, cell: cell, index: (indexPath as NSIndexPath).row)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TopCollectionViewCell {
            self.categoryCellSelected(false, cell: cell, index: (indexPath as NSIndexPath).row)
        }
    }

    func findItemRowForName(_ name: String) {
        if let index = array.index(where: {$0.wineCategoryName == name}) {
            let indexPath = IndexPath(item:index, section: 0)
            self.collectionView?.scrollToItem(at: IndexPath(item:index, section: 0), at: UICollectionViewScrollPosition.left, animated: false)
            self.collectionView?.reloadData()
            self.collectionView?.layoutIfNeeded()
            if let cell = self.collectionView?.cellForItem(at: indexPath) as? TopCollectionViewCell {
                self.collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
                self.categoryCellSelected(true, cell: cell, index: (indexPath as NSIndexPath).row)
                self.delegate?.didSelectCategory(array[(indexPath as NSIndexPath).row].winesArray)
            }
        }
    }

    func categoryCellSelected(_ selected: Bool, cell: TopCollectionViewCell, index: Int) {
        cell.imageView.image = UIImage(named: selected ? array[index].wineCategoryImageNameHighlight() : array[index].wineCategoryImageNameNormal())
    }
}
