//
//  onProdctTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit

class onProdctTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var checkBtn: CheckBox!
    @IBOutlet weak var listLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
