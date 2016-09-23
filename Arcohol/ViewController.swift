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
        self.view.addConstraints([NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: overlayView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)])

//        let testView: Test = Test()
//
//        self.view.addSubview(testView)
//        self.view.addConstraints([NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: testView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)])


        DispatchQueue.global().async {
            do {
                self.topContainerCollectionViewController?.array = try WineDataManager.sharedInstance.importCollectionOfWineCategories()
            } catch WineDataManager.WineCategoryError.fileNotFound {
                print("FileNotFound")
            } catch WineDataManager.WineCategoryError.malformedDictionary {
                print("MalformedDictionary")
            } catch WineDataManager.WineCategoryError.wineArrayNotFound {
                print("WineArrayNotFound")
            } catch WineDataManager.WineCategoryError.wineNotFound {
                print("WineNotFound")
            } catch WineDataManager.WineCategoryError.categoryNotFound {
                print("CategoryNotFound")
            } catch {
                print("some error")
            }
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.SegueIdentifiers.topCollectionView) {
            guard segue.destination.isKind(of: TopCollectionViewController.self) else { return }
            topContainerCollectionViewController = (segue.destination as! TopCollectionViewController)
            topContainerCollectionViewController?.delegate = self
        }
        if (segue.identifier == Constants.SegueIdentifiers.bottomCollectionView) {
            guard segue.destination.isKind(of: BottomCollectionViewController.self) else { return }
            bottomContainerCollectionViewController = (segue.destination as! BottomCollectionViewController)
            bottomContainerCollectionViewController?.delegate = self
        }
    }

    // MARK: - Delegation

    func didSelectCategory(_ wineArray: [Wine]) {
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

    func didSelectWine(_ row: Int) {
        NetworkManager.sharedInstance.emitToSocket([(self.bottomContainerCollectionViewController?.array[row].wineSegment)!]) { (success) in
            if !success {
                print("Error")
            }
        }
    }

    func categoryNameTapped(_ name: String) {
        self.overlayView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
            }, completion: { (completion) in
                self.overlayView.removeFromSuperview()
        }) 

        self.topContainerCollectionViewController?.findItemRowForName(name)
    }
}
