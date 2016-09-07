//
//  Wine.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 31/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation

struct Wine {
    let wineName: String
    let wineSegment: Int
    let wineImageName: String

    init(wineName: String, wineSegment: Int, wineImageName: String) {
        self.wineName = wineName
        self.wineSegment = wineSegment
        self.wineImageName = wineImageName
    }
}
