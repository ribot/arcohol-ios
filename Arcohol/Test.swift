//
//  Test.swift
//  Arcohol
//
//  Created by Manuel Marcos Regalado on 16/09/2016.
//  Copyright © 2016 Manuel Marcos Regalado. All rights reserved.
//

import Foundation
import UIKit

class Test: UIView {
    @IBOutlet private var contentView: UIView?
    @IBOutlet private var textField: UITextField?

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
        NSBundle.mainBundle().loadNibNamed("Test", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.addSubview(content)
    }

    @IBAction func test(sender: AnyObject) {
        NetworkManager.sharedInstance.emitToSocket([Int((self.textField?.text)!)!]) { (success) in
            if !success {
                print("Error")
            }
        }
    }
}
