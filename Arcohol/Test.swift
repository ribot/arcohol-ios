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
    @IBOutlet fileprivate var contentView: UIView?
    @IBOutlet fileprivate var textField: UITextField?

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
        Bundle.main.loadNibNamed("Test", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }

    @IBAction func test(_ sender: AnyObject) {
        NetworkManager.sharedInstance.emitToSocket([Int((self.textField?.text)!)!]) { (success) in
            if !success {
                print("Error")
            }
        }
    }
}
