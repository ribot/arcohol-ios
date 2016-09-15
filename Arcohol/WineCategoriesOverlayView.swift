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
    func categoryNameTapped(name: String)
}

class WineCategoriesOverlayView: UIView {
    @IBOutlet private var contentView: Category?
    @IBOutlet private var categoryMeat: Category?
    @IBOutlet private var categoryFish: Category?
    @IBOutlet private var categoryPasta: Category?
    @IBOutlet private var categoryCheese: Category?
    @IBOutlet private var categoryVegetables: Category?
    @IBOutlet private var categoryOccasions: Category?
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

    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSBundle.mainBundle().loadNibNamed("WineCategoriesOverlayView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
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

    func viewTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view as? Category {
            self.wineCategoryOverlayViewProtocolDelegate?.categoryNameTapped(view.name!)
        }
    }
}
