//
//  checkBoxButton.swift
//  liveOrder
//
//  Created by Data Prime on 12/07/21.
//

import Foundation
import UIKit
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "tickWhite")! as UIImage
    //let uncheckedImage = UIImage(named: "")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.backgroundColor = UIColor(hexString: "674CF3")
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.borderColor = UIColor(hexString: "C3CDE4")
                self.borderWidth = 1.0
                self.clipsToBounds = true
                self.backgroundColor = .white
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
