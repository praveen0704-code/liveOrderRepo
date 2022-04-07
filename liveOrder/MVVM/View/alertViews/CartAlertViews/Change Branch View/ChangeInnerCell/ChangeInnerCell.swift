//
//  ChangeInnerCell.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//

import UIKit

class ChangeInnerCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
