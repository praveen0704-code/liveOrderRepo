//
//  MfgSearchTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 11/10/21.
//

import UIKit

class MfgSearchTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var mfgLbl: UILabel!
    @IBOutlet weak var schemesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
