//
//  BranchListTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit

class BranchListTableViewCell: UITableViewCell {
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var branchListLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectBtn.layer.borderWidth = 1
        selectBtn.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        selectBtn.layer.cornerRadius = selectBtn.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
