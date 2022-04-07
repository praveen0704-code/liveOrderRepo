//
//  PriorityTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit

class PriorityTableCell: UITableViewCell {
    @IBOutlet weak var txtlbl: UILabel!
    
    @IBOutlet weak var priorityButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
