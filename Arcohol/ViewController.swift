//
//  ViewController.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 17/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ViewController: UITableViewController {

    var array: NSMutableArray = []

    let socket = SocketIOClient(socketURL: NSURL(string: "http://rpi-manuel.local")!, options: [.Log(true), .ForcePolling(true)])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket.on("connect") {data, ack in
            print("socket connected")
        }

        self.socket.on("control") {data, ack in
            if let cur = data[0] as? NSDictionary {

                if let segmentCount = cur["segmentCount"] as? NSInteger {

                    for i in 0..<segmentCount + 1 {
                        let myNumber = NSNumber(integer:i)
                        self.array.addObject(myNumber)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            }
        }
        socket.connect()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("identifierCell")!
        cell.textLabel?.text = String(array[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.socket.emit("control", ["segmentSet": [array[indexPath.row]]])
    }

}
