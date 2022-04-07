//
//  OtherWalletCell.swift
//  liveOrder
//
//  Created by Data Prime on 03/09/21.
//

import UIKit

class OtherWalletCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
  
    @IBOutlet weak var payImage: UIImageView!
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var getEasyLbl: UILabel!
    @IBOutlet weak var activeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overView.layer.cornerRadius = 6
        overView.layer.masksToBounds = true
        overView.layer.borderWidth = 1
        overView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
