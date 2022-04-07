//
//  MainSearchFilterTableViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 09/10/21.
//

import UIKit

class MainSearchFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
