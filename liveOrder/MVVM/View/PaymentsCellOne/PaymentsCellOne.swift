//
//  PaymentsCellOne.swift
//  liveOrder
//
//  Created by Data Prime on 01/09/21.
//

import UIKit

class PaymentsCellOne: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var payImg: UIImageView!
    @IBOutlet weak var phonePayLbl: UILabel!
    @IBOutlet weak var selectBtn: CheckBox!
    @IBOutlet weak var upiLbl: UILabel!
    @IBOutlet weak var activateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 5
        cellView.layer.masksToBounds = true
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.2980392157, blue: 0.9529411765, alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
