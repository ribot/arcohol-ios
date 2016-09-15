//
//  WineCategoriesOverlayView.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 13/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class WineCategoriesOverlayView: UIView {
    @IBOutlet private var contentView: UIView?
    @IBOutlet private var categoryMeat: UIView?
    @IBOutlet private var categoryFish: UIView?
//    @IBOutlet private var categoryMeat: UIView?
//    @IBOutlet private var categoryMeat: UIView?
//    @IBOutlet private var categoryMeat: UIView?
//    @IBOutlet private var categoryMeat: UIView?

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
        self.addSubview(content)
        categoryMeat?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(WineCategoriesOverlayView.viewTapped)))
    }

    func viewTapped() {
        print("hola")
    }
}
