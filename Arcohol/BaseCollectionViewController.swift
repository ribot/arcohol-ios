//
//  BaseCollectionViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 31/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

protocol ContainterViewControllerProtocol {
    func didSelectItem()
}

class BaseCollectionViewController: UICollectionViewController {
    var delegate: ContainterViewControllerProtocol?

    private let reuseBottomIdentifier = "BottomCollectionViewCell"
    var array: NSMutableArray = ["Meat", "Fish", "Pasta", "Cheese", "Dessert", "Vegetables", "Ocassions"]

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView!.collectionViewLayout.invalidateLayout()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.collectionView!.frame.height, height: self.collectionView!.frame.height)
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectItem()
    }
}
