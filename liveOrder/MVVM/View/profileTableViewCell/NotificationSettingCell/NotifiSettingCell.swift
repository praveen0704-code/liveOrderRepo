//
//  NotifiSettingCell.swift
//  liveOrder
//
//  Created by Data Prime on 20/08/21.
//

import UIKit

class NotifiSettingCell: UITableViewCell {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var switchone: UISwitch!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var offLbl: UILabel!
    @IBOutlet weak var orderRelatedLbl: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var lineOneLbl: UILabel!
    @IBOutlet weak var lineOneHeight: NSLayoutConstraint!
    @IBOutlet weak var lineTwoLbl: UILabel!
    @IBOutlet weak var lineTwoHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
