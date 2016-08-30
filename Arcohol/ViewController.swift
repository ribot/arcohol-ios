//
//  ViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 17/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let reuseTopIdentifier = "TopCollectionViewCell"
    private let reuseBottomIdentifier = "BottomCollectionViewCell"
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var bottomCollectionView: UICollectionView!

    var array: NSMutableArray = ["Meat", "Fish", "Pasta", "Cheese", "Dessert", "Vegetables", "Ocassions"]

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedInstance.connectSocket({ (connected) in
            print("manolo")
        })
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.topCollectionView.collectionViewLayout.invalidateLayout()
        self.bottomCollectionView.collectionViewLayout.invalidateLayout()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.topCollectionView {
            return CGSize(width: self.topCollectionView.frame.height, height: self.topCollectionView.frame.height)
        } else {
            return CGSize(width: self.bottomCollectionView.frame.height, height: self.bottomCollectionView.frame.height)
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if collectionView == self.topCollectionView {
            let cell = self.topCollectionView.dequeueReusableCellWithReuseIdentifier(reuseTopIdentifier, forIndexPath: indexPath) as! TopCollectionViewCell
            cell.label.text = array[indexPath.row] as? String
            let image = UIImage(named: "meat.pdf")
            cell.imageView.image = image
            return cell

        } else {
            let cell = self.bottomCollectionView.dequeueReusableCellWithReuseIdentifier(reuseBottomIdentifier, forIndexPath: indexPath) as! BottomCollectionViewCell
            cell.label.text = array[indexPath.row] as? String
            let image = UIImage(named: "meat.pdf")
            cell.imageView.image = image
            return cell

        }
      }
}
