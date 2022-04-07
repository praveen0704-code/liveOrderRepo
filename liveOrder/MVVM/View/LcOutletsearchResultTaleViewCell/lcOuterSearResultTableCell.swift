//
//  lcOuterSearResultTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 06/07/21.
//

import UIKit

class lcOuterSearResultTableCell: UITableViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
