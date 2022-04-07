//
//  watchOptionTableViewTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit

class watchOptionTableViewTableViewCell: UITableViewCell {
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var listLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true{
            overview.backgroundColor = .white
        }

        // Configure the view for the selected state
    }
    
}
