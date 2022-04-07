//
//  CardOneTableCelll.swift
//  liveOrder
//
//  Created by Data Prime on 02/09/21.
//

import UIKit

class CardOneTableCelll: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var rectImageView: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var BankImg: UIImageView!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var cardNumLbl: UILabel!
    @IBOutlet weak var cardHolderLbl: UILabel!
    @IBOutlet weak var validLbl: UILabel!
    @IBOutlet weak var debitLbl: UILabel!
    @IBOutlet weak var holderName: UILabel!
    @IBOutlet weak var validDateLbl: UILabel!
    @IBOutlet weak var payImage: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        innerView.layer.cornerRadius = 6
        innerView.layer.masksToBounds = true
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = #colorLiteral(red: 0.7921568627, green: 0.8, blue: 0.8196078431, alpha: 0.68)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
