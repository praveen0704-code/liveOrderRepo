//
//  LcOuterSearchTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 06/07/21.
//

import UIKit

class LcOuterSearchTableCell: UITableViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var tabletName: UILabel!
    @IBOutlet weak var microLabsLbl: UILabel!
    @IBOutlet weak var packsizeLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    
    @IBOutlet weak var lineLbl: UILabel!
    
    @IBOutlet weak var addButtonn: UIButton!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var shotBookImgeView: UIImageView!
    @IBOutlet weak var shortBookBtn: UIButton!
    
    @IBOutlet weak var sponserLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sponserLabel: UILabel!
    
    @IBOutlet weak var sponserHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tabletName.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
