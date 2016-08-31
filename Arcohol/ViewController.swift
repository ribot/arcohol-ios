//
//  ViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 17/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ContainterViewControllerProtocol {

    var containerTopCollectionViewController: TopCollectionViewController?
    var containerBottomCollectionViewController: BottomCollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func didSelectItem() {
        print("didSelectItem")
        containerBottomCollectionViewController?.array = ["manu", "manu"]
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.SegueIdentifiers.topCollectionView) {
            guard segue.destinationViewController.isKindOfClass(TopCollectionViewController) else { return }
            containerTopCollectionViewController = (segue.destinationViewController as! TopCollectionViewController)
            containerTopCollectionViewController?.delegate = self
        }
        if (segue.identifier == Constants.SegueIdentifiers.bottomCollectionView) {
            guard segue.destinationViewController.isKindOfClass(BottomCollectionViewController) else { return }
            containerBottomCollectionViewController = (segue.destinationViewController as! BottomCollectionViewController)
            containerBottomCollectionViewController?.delegate = self
        }
    }
}
