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
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "TopCollectionView") {
            guard segue.destinationViewController.isKindOfClass(TopCollectionViewController) else { return }
            containerTopCollectionViewController = (segue.destinationViewController as! TopCollectionViewController)
            containerTopCollectionViewController?.delegate = self
        }
        if (segue.identifier == "BottomCollectionView") {
            guard segue.destinationViewController.isKindOfClass(BottomCollectionViewController) else { return }
            containerBottomCollectionViewController = (segue.destinationViewController as! BottomCollectionViewController)
            containerBottomCollectionViewController?.delegate = self
        }
    }
}
