//
//  OrderToSellerTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 25/08/21.
//

import UIKit

class OrderToSellerTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var orderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
