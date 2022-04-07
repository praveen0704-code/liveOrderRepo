//
//  Offers&PromotionsTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 25/08/21.
//

import UIKit

class Offers_PromotionsTableViewCell: UITableViewCell {
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var offerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
