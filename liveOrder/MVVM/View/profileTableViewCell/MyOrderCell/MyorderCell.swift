//
//  MyorderCell.swift
//  liveOrder
//
//  Created by Data Prime on 21/08/21.
//

import UIKit

class MyorderCell: UITableViewCell {
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var rightlbl: UIImageView!
    @IBOutlet weak var linelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
