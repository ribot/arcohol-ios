//
//  ViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 17/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

// There are 32 sections

import UIKit

class ViewController: UIViewController, ContainterViewControllerProtocol, WineCategoriesOverlayViewProtocol {

    var topContainerCollectionViewController: TopCollectionViewController?
    var bottomContainerCollectionViewController: BottomCollectionViewController?
    let overlayView: WineCategoriesOverlayView = WineCategoriesOverlayView()

    // MARK: - Life cycle and Navigation

    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.wineCategoryOverlayViewProtocolDelegate = self
        self.view.addSubview(overlayView)
        self.view.addConstraints([NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)])

//        let testView: Test = Test()
//
//        self.view.addSubview(testView)
//        self.view.addConstraints([NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)])
//


        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)) {
            do {
                self.topContainerCollectionViewController?.array = try WineDataManager.sharedInstance.importCollectionOfWineCategories()
            } catch WineDataManager.WineCategoryError.FileNotFound {
                print("FileNotFound")
            } catch WineDataManager.WineCategoryError.MalformedDictionary {
                print("MalformedDictionary")
            } catch WineDataManager.WineCategoryError.WineArrayNotFound {
                print("WineArrayNotFound")
            } catch WineDataManager.WineCategoryError.WineNotFound {
                print("WineNotFound")
            } catch WineDataManager.WineCategoryError.CategoryNotFound {
                print("CategoryNotFound")
            } catch {
                print("some error")
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.SegueIdentifiers.topCollectionView) {
            guard segue.destinationViewController.isKindOfClass(TopCollectionViewController) else { return }
            topContainerCollectionViewController = (segue.destinationViewController as! TopCollectionViewController)
            topContainerCollectionViewController?.delegate = self
        }
        if (segue.identifier == Constants.SegueIdentifiers.bottomCollectionView) {
            guard segue.destinationViewController.isKindOfClass(BottomCollectionViewController) else { return }
            bottomContainerCollectionViewController = (segue.destinationViewController as! BottomCollectionViewController)
            bottomContainerCollectionViewController?.delegate = self
        }
    }

    // MARK: - Delegation

    func didSelectCategory(wineArray: [Wine]) {
        self.bottomContainerCollectionViewController?.array = wineArray
        // TODO: Create a clousure that returns an array with all the winesegments

        var mutableArray = [Int]()
        for wine: Wine in wineArray {
            mutableArray.append(wine.wineSegment)
        }

        NetworkManager.sharedInstance.emitToSocket(mutableArray) { (success) in
            if !success {
                print("Error")
            }
        }
    }

    func didSelectWine(row: Int) {
        NetworkManager.sharedInstance.emitToSocket([(self.bottomContainerCollectionViewController?.array[row].wineSegment)!]) { (success) in
            if !success {
                print("Error")
            }
        }
    }

    func categoryNameTapped(name: String) {
        self.overlayView.alpha = 1
        UIView.animateWithDuration(0.5, animations: {
            self.overlayView.alpha = 0
            }) { (completion) in
                self.overlayView.removeFromSuperview()
        }

        self.topContainerCollectionViewController?.findItemRowForName(name)
    }
}
