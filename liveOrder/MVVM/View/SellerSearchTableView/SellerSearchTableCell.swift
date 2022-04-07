//
//  SellerSearchTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 11/10/21.
//

import UIKit

class SellerSearchTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var sellerNmaeLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
