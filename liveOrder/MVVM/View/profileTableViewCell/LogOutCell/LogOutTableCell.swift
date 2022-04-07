//
//  LogOutTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 21/08/21.
//

import UIKit

class LogOutTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var leftimage: UIImageView!
    @IBOutlet weak var rightimage: UIImageView!
    @IBOutlet weak var logoutTxtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
