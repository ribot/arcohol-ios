//
//  WineCategoriesOverlayView.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 13/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

protocol WineCategoriesOverlayViewProtocol {
    func categoryNameTapped(_ name: String)
}

class WineCategoriesOverlayView: UIView {
    @IBOutlet fileprivate var contentView: Category?
    @IBOutlet fileprivate var categoryMeat: Category?
    @IBOutlet fileprivate var categoryFish: Category?
    @IBOutlet fileprivate var categoryPasta: Category?
    @IBOutlet fileprivate var categoryCheese: Category?
    @IBOutlet fileprivate var categoryVegetables: Category?
    @IBOutlet fileprivate var categoryOccasions: Category?
    var wineCategoryOverlayViewProtocolDelegate: WineCategoriesOverlayViewProtocol?

    // for using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    // for using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    fileprivate func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed("WineCategoriesOverlayView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.setUpViews()
        self.addSubview(content)
    }

    func setUpViews() {
        categoryMeat?.name = "Meat"
        categoryFish?.name = "Fish"
        categoryPasta?.name = "Pasta"
        categoryCheese?.name = "Cheese"
        categoryVegetables?.name = "Vegetables"
        categoryOccasions?.name = "Occasions"

        categoryMeat?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
        categoryFish?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
        categoryPasta?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
        categoryCheese?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
        categoryVegetables?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
        categoryOccasions?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
    }

    func viewTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view as? Category {
            self.wineCategoryOverlayViewProtocolDelegate?.categoryNameTapped(view.name!)
        }
    }
}
