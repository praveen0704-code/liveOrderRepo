//
//  FourthInnerCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit

class FourthInnerCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var productAmountLbl: UILabel!
    @IBOutlet weak var deliveryAmountLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
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
