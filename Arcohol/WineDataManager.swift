//
//  WineDataManager.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 06/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation

class WineDataManager {

    enum WineCategoryError: Error {
        case fileNotFound
        case fileContentNotFound
        case malformedDictionary
        case wineArrayNotFound
        case wineNotFound
        case categoryNotFound
    }

    func importCollectionOfWineCategories() throws -> [WineCategory] {
        // TODO: do the import on a background thread
        guard let path = Bundle.main.path(forResource: "Wines", ofType: "plist") else {
            throw WineCategoryError.fileNotFound
        }
        guard let arrayOfItems: NSArray = NSArray(contentsOfFile: path) else {
            throw WineCategoryError.fileContentNotFound
        }
        var mutableCategoryArray = [WineCategory]()
        for category in arrayOfItems {
            guard let categoryDictionary = category as? NSDictionary else {
                throw WineCategoryError.malformedDictionary
            }
            guard let wineArray = categoryDictionary["wineArray"] as? NSArray else {
                throw WineCategoryError.wineArrayNotFound
            }
            var mutableWineArray = [Wine]()
            for wine in wineArray {
                guard let wineObject = wine as? NSDictionary else {
                    throw WineCategoryError.malformedDictionary
                }
                guard let wineName = wineObject["wineName"] as? String,
                    let wineCountryName = wineObject["countryName"] as? String,
                    let wineGrape = wineObject["grape"] as? String,
                let wineColour = wineObject["colour"] as? String,
                let wineVintage = wineObject["vintage"] as? String,
                let wineABV = wineObject["abv"] as? String,
                let wineTastingNotes = wineObject["tastingNotes"] as? String,
                let wineSegment = wineObject["wineSegment"] as? String else {
                        throw WineCategoryError.wineNotFound
                }
                let wine: Wine = Wine(wineName: wineName, wineCountryName: wineCountryName, wineGrape: wineGrape, wineColour: wineColour, wineVintage: wineVintage, wineABV: wineABV, wineNotes: wineTastingNotes, wineSegment: Int(wineSegment)!)
                mutableWineArray.append(wine)
            }
            guard let categoryName = categoryDictionary["categoryName"] as? String else {
                    throw WineCategoryError.categoryNotFound
            }
            let category: WineCategory = WineCategory(wineCategoryName: categoryName, winesArray: mutableWineArray)
            mutableCategoryArray.append(category)
        }
        return mutableCategoryArray
    }

    // MARK: - Shared Instance
    static let sharedInstance = WineDataManager()
}
