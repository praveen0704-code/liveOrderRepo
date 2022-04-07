//
//  QuickLinksCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit

class QuickLinksCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var quickLinksLbl: UILabel!
    @IBOutlet weak var usageBtn: UIButton!
    @IBOutlet weak var sideEffectBtn: UIButton!
    @IBOutlet weak var contraBtn: UIButton!
    @IBOutlet weak var usageLbl: UILabel!
    @IBOutlet weak var sideeffctLbl: UILabel!
    @IBOutlet weak var usageTxtView: UITextView!
    @IBOutlet weak var sideEffctDesLbl: UILabel!
    @IBOutlet weak var contraLbl: UILabel!
    @IBOutlet weak var contraDesLbl: UILabel!
    @IBOutlet weak var noteTxtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func contraBtnAct(_ sender: Any) {
    }
    @IBAction func sideEffectBtnAct(_ sender: Any) {
    }
    @IBAction func usageBtnAct(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
