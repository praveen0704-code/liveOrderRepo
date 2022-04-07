//
//  CombinedStoreListTableViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 06/12/21.
//

import UIKit

class CombinedStoreListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comainMainView: UIView!
    @IBOutlet weak var storeNameLabel: UILabel!
    
    @IBOutlet weak var firmNamelabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var drugLisenceNoLabel: UILabel!
    
    
    @IBOutlet weak var gstLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
