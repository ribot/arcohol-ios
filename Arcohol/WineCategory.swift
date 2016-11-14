//
//  WineCategory.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 31/08/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation

struct WineCategory {
    let wineCategoryName: String
    let winesArray: [Wine]

    init(wineCategoryName: String, winesArray: [Wine]) {
        self.wineCategoryName = wineCategoryName
        self.winesArray = winesArray
    }

    func wineCategoryImageNameNormal() -> String {
        return "icon\(self.wineCategoryName)Normal"
    }

    func wineCategoryImageNameHighlight() -> String {
        return "icon\(self.wineCategoryName)Highlight"
    }

    func equalToName(_ name: String) -> Bool {
        return true
    }
}
