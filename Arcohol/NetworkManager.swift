//
//  NetworkManager.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 25/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import SocketIOClientSwift

// TODO: Fix and Create the network layer

class NetworkManager {

    let socket = SocketIOClient(socketURL: NSURL(string: "http://rpi-manuel.local")!, options: [.Log(true), .ForcePolling(true)])

    func listenControl() {
        // Call this only if the connection is open
        self.socket.on("control") {data, ack in
//            if let cur = data[0] as? NSDictionary {
//                if let segmentCount = cur["segmentCount"] as? NSInteger {
//                    self.array.removeAllObjects()
//                    for i in 0..<segmentCount + 1 {
//                    let myNumber = NSNumber(integer:i)
//                    self.array.addObject(myNumber)
//                    }
//                    dispatch_async(dispatch_get_main_queue(), {
//                        // Reload the data
//                    })
//                }
//            }
        }
    }

    func connectSocket(completionHandler:(connected: Bool) -> ()) {
        self.socket.reconnects = false
        socket.on("error") {data in
            completionHandler(connected:false)
        }
        self.socket.on("connect") {data, ack in
            completionHandler(connected:true)
        }
        self.socket.connect()
    }

    func emitToSocket() {
        // Make sure that we are connected before we do anything else
        if self.socket.status == SocketIOClientStatus.Connected {
            // How to emit:
            self.socket.emit("control", ["segmentSet": [1, 2, 3]])

        }
    }

    // MARK: - Shared Instance

    static let sharedInstance = NetworkManager()
}
