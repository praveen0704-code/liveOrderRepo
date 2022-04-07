//
//  FbTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 09/09/21.
//

import UIKit

class FbTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var txtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
