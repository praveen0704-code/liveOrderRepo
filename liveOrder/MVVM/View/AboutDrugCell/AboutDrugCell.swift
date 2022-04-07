//
//  AboutDrugCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit

class AboutDrugCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var aboutDrugLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var desTxtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
