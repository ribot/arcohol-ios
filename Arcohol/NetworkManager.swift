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

    let socket = SocketIOClient(socketURL: NSURL(string: Constants.EndPoints.raspberryPiEndPoint)!, options: [.Log(true), .ForcePolling(true)])

    private func connectSocket(completionHandler:(connected: Bool) -> ()) {

        if self.socket.status == SocketIOClientStatus.Connected {
            completionHandler(connected: true)
        }
        self.socket.reconnects = false
        socket.on("error") {data in
            completionHandler(connected: false)
        }
        self.socket.on("control") {data, ack in
            completionHandler(connected: true)
        }
        self.socket.connect()
    }

    private func emit(segmentsArray: [Int]) {
        self.socket.emit("control", ["segmentSet": segmentsArray])
    }

    func emitToSocket(segmentsArray: [Int], completionHandler:(success: Bool) -> ()) {
        self.connectSocket { (connected) in
            if connected {
                self.emit(segmentsArray)
                completionHandler(success: true)
            } else {
                completionHandler(success: false)
            }
        }
    }

    // MARK: - Shared Instance
    static let sharedInstance = NetworkManager()
}
