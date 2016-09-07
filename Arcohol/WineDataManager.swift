//
//  WineDataManager.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 06/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation

class WineDataManager {

    enum WineCategoryError: ErrorType {
        case FileNotFound
        case FileContentNotFound
        case MalformedDictionary
        case WineArrayNotFound
        case WineNotFound
        case CategoryNotFound
    }

    func importCollectionOfWineCategories() throws -> [WineCategory] {
        // TODO: do the import on a background thread
        guard let path = NSBundle.mainBundle().pathForResource("Wines", ofType: "plist") else {
            throw WineCategoryError.FileNotFound
        }
        guard let arrayOfItems: NSArray = NSArray(contentsOfFile: path) else {
            throw WineCategoryError.FileContentNotFound
        }
        var mutableCategoryArray = [WineCategory]()
        for category in arrayOfItems {
            guard let categoryDictionary = category as? NSDictionary else {
                throw WineCategoryError.MalformedDictionary
            }
            guard let wineArray = categoryDictionary["wineArray"] as? NSArray else {
                throw WineCategoryError.WineArrayNotFound
            }
            var mutableWineArray = [Wine]()
            for wine in wineArray {
                guard let wineObject = wine as? NSDictionary else {
                    throw WineCategoryError.MalformedDictionary
                }
                guard let wineName = wineObject["wineName"] as? String,
                    let wineSegment = wineObject["wineSegment"] as? String,
                    let wineImageName = wineObject["wineImageName"] as? String else {
                        throw WineCategoryError.WineNotFound
                }
                let numberFromString: Int = Int(wineSegment)!
                let wine: Wine = Wine(wineName: wineName, wineSegment: numberFromString, wineImageName: wineImageName)
                mutableWineArray.append(wine)
            }
            guard let categoryName = categoryDictionary["categoryName"] as? String,
                let categoryImageName = categoryDictionary["categoryImageName"] as? String else {
                    throw WineCategoryError.CategoryNotFound
            }
            let category: WineCategory = WineCategory(wineCategoryName: categoryName, wineCategoryImageName: categoryImageName, winesArray: mutableWineArray)
            mutableCategoryArray.append(category)
        }
        return mutableCategoryArray
    }

    // MARK: - Shared Instance
    static let sharedInstance = WineDataManager()
}
