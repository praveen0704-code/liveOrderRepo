//
//  FeedBackTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 21/08/21.
//

import UIKit

class FeedBackTableCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var feedBackLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
