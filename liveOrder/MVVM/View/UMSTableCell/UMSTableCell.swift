//
//  UMSTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit

class UMSTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var pharmalbl: UILabel!
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var sellerCode: UILabel!
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var supplyLbl: UILabel!
    @IBOutlet weak var allOverLbl: UILabel!
    @IBOutlet weak var dotLine: DashedLineView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overView.layer.borderWidth = 0.5
        overView.layer.borderColor = #colorLiteral(red: 0.4235294118, green: 0.4588235294, blue: 0.4901960784, alpha: 0.3)
        overView.layer.cornerRadius = 14

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
}
