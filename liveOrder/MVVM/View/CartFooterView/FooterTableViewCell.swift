//
//  FooterTableViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 09/11/21.
//

import UIKit

class FooterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var totalAmoutLabel: UILabel!
    
    @IBOutlet weak var totalGSTLabel: UILabel!
    
    @IBOutlet weak var totalAmountGSTLael: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
