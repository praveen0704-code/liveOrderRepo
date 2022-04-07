//
//  OptionLIstTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 30/08/21.
//

import UIKit

class OptionLIstTableViewCell: UITableViewCell {
    @IBOutlet weak var optionOverView: UIView!
    @IBOutlet weak var listLbl: UILabel!
    @IBOutlet weak var dotLineView: DashedLineView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
