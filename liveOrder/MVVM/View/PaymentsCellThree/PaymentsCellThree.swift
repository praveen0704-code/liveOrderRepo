//
//  PaymentsCellThree.swift
//  liveOrder
//
//  Created by Data Prime on 01/09/21.
//

import UIKit

class PaymentsCellThree: UITableViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var payImageView: UIImageView!
    @IBOutlet weak var headLbl: UILabel!
    @IBOutlet weak var selectBtn: CheckBox!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overView.layer.cornerRadius = 5
        overView.layer.masksToBounds = true
        overView.layer.borderWidth = 1
        overView.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.2980392157, blue: 0.9529411765, alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
