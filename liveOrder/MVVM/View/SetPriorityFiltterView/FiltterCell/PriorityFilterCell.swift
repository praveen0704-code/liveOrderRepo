//
//  PriorityFilterCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/11/21.
//

import UIKit

class PriorityFilterCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var roundLbl: UILabel!
    @IBOutlet weak var listLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
