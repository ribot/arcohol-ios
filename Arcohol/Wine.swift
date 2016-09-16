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
    let wineCountryName: String
    let wineGrape: String
    let wineColour: String
    let wineVintage: String
    let wineABV: String
    let wineNotes: String
    let wineSegment: Int

    init(wineName: String, wineCountryName: String, wineGrape: String, wineColour: String, wineVintage: String, wineABV: String, wineNotes: String, wineSegment: Int) {
        self.wineName = wineName
        self.wineCountryName = wineCountryName
        self.wineGrape = wineGrape
        self.wineColour = wineColour
        self.wineVintage = wineVintage
        self.wineABV = wineABV
        self.wineNotes = wineNotes
        self.wineSegment = wineSegment
    }

    func wineImageName() -> String {
        return "bottle\(self.wineColour)"
    }
}
