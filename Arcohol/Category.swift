//
//  Category.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 13/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class Category: UIView {
    @IBOutlet fileprivate var contentView: UIView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var labelName: UILabel?
    var name: String? {
        didSet {
            self.imageView?.image = UIImage.init(named: "icon\(self.name!)Normal")
            self.labelName?.text = self.name
        }
    }

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
        Bundle.main.loadNibNamed("Category", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }
}
