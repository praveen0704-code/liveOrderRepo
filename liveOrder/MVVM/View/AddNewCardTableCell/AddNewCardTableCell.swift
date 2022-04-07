//
//  AddNewCardTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 02/09/21.
//

import UIKit

class AddNewCardTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var AddLbl: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overView.layer.cornerRadius = 6
        overView.layer.borderWidth = 1
        overView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
