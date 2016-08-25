//
//  ViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 17/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let reuseIdentifier = "TopCollectionViewCell"
    @IBOutlet var topCollectionView: UICollectionView!

    var array: NSMutableArray = ["Meat", "Fish", "Pasta", "Cheese", "Dessert", "Vegetables", "Ocassions"]

    let socket = SocketIOClient(socketURL: NSURL(string: "http://rpi-manuel.local")!, options: [.Log(true), .ForcePolling(true)])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket.on("connect") {data, ack in
            print("socket connected")
        }

        self.socket.on("control") {data, ack in
            if let cur = data[0] as? NSDictionary {

                if let segmentCount = cur["segmentCount"] as? NSInteger {
                    self.array.removeAllObjects()
                    for i in 0..<segmentCount + 1 {
                        let myNumber = NSNumber(integer:i)
                        self.array.addObject(myNumber)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        // Reload the data
                    })
                }
            }
        }
        socket.connect()
        // How to emit:
        // self.socket.emit("control", ["segmentSet": [1,2,3]])
        topCollectionView.backgroundColor = UIColor.clearColor()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.topCollectionView.collectionViewLayout.invalidateLayout()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.topCollectionView.frame.height, height: self.topCollectionView.frame.height)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.topCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TopCollectionViewCell
        cell.label.text = array[indexPath.row] as? String
        let image = UIImage(named: "meat.pdf")
        cell.imageView.image = image
        return cell
    }
}
