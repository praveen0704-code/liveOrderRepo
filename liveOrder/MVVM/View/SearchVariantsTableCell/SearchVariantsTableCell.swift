//
//  SearchVariantsTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/10/21.
//

import UIKit

class SearchVariantsTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var variantsLbl: UILabel!
    @IBOutlet weak var microLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
