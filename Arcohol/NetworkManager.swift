//
//  NetworkManager.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 25/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import SocketIO
// TODO: Fix and Create the network layer

class NetworkManager {

    let socket = SocketIOClient(socketURL: URL(string: Constants.EndPoints.raspberryPiEndPoint)!)

    fileprivate func connectSocket(_ completionHandler:@escaping (_ connected: Bool) -> ()) {

        if self.socket.status == SocketIOClientStatus.connected {
            completionHandler(true)
        }
        self.socket.reconnects = false
        socket.on("error") {data in
            completionHandler(false)
        }
        self.socket.on("control") {data, ack in
            completionHandler(true)
        }
        self.socket.connect()
    }

    fileprivate func emit(_ segmentsArray: [Int]) {
        self.socket.emit("control", ["segmentSet": segmentsArray])
    }

    func emitToSocket(_ segmentsArray: [Int], completionHandler:@escaping (_ success: Bool) -> ()) {
        self.connectSocket { (connected) in
            if connected {
                self.emit(segmentsArray)
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

    // MARK: - Shared Instance
    static let sharedInstance = NetworkManager()
}
