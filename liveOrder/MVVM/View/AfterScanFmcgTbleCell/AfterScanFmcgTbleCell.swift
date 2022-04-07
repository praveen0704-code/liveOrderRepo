//
//  AfterScanFmcgTbleCell.swift
//  liveOrder
//
//  Created by Data Prime on 07/07/21.
//

import UIKit
import iOSDropDown

class AfterScanFmcgTbleCell: UITableViewCell {
    @IBOutlet weak var pharmaNameLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var addtoCardBtn: UIButton!
  
    @IBOutlet weak var numberTextField: DropDown!
    @IBOutlet weak var dotView: DashedLineView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberTextField.optionArray = ["1","10","20","30","40","50","60","70","80","90","100"]
        numberTextField.optionIds = [1,2,3,4,5,6,7,8,9,10,11]
   
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
