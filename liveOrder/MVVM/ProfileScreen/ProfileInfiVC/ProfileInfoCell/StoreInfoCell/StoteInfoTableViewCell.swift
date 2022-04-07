//
//  StoteInfoTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 31/08/21.
//

import UIKit

class StoteInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var mobileNumTxtField: WhiteUITextField!
    @IBOutlet weak var storeNameTxtField: WhiteUITextField!
    @IBOutlet weak var emailTxtField: WhiteUITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
