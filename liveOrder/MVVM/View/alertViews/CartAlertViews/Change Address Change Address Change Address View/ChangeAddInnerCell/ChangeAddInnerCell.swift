//
//  ChangeAddInnerCell.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//

import UIKit


class ChangeAddInnerCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var pharmaLbl: UILabel!
    @IBOutlet weak var warehouseLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var addTxtView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editBtnAct(_ sender: Any) {
        
        addTxtView.isUserInteractionEnabled = true
    }
}
