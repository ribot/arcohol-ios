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
    fileprivate let reuseBottomIdentifier = "BottomCollectionViewCell"
    var array: [Wine] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.collectionView?.reloadData()
                // Scroll to the beginning
                let indexPath = IndexPath(item:0, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: reuseBottomIdentifier, for: indexPath) as! BottomCollectionViewCell
        cell.labelName.text = array[(indexPath as NSIndexPath).row].wineName
        cell.labelColour.text = array[(indexPath as NSIndexPath).row].wineColour
        cell.labelCountry.text = array[(indexPath as NSIndexPath).row].wineCountryName
        cell.labelTastingNotes.text = array[(indexPath as NSIndexPath).row].wineNotes
        cell.labelGrape.text = array[(indexPath as NSIndexPath).row].wineGrape
        cell.labelYear.text = array[(indexPath as NSIndexPath).row].wineVintage
        let image = UIImage(named: array[(indexPath as NSIndexPath).row].wineImageName())
        cell.imageView.image = image
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectWine((indexPath as NSIndexPath).row)
    }
}
