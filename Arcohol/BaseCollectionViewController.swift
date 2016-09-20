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
    func didSelectCategory(_ wineArray: [Wine])
    func didSelectWine(_ row: Int)
}

class BaseCollectionViewController: UICollectionViewController {
    var delegate: ContainterViewControllerProtocol?
    fileprivate let reuseBottomIdentifier = "BottomCollectionViewCell"

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView!.collectionViewLayout.invalidateLayout()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView!.frame.height, height: self.collectionView!.frame.height)
    }
}
