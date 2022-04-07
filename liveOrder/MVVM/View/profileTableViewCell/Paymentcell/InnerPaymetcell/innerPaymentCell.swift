//
//  innerPaymentCell.swift
//  liveOrder
//
//  Created by Data Prime on 21/08/21.
//

import UIKit
protocol CustomDelegate: class {
    func didSelectItem(record: Int)
}
class innerPaymentCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var paylistLbl: UILabel!
    var delegate: CustomDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
