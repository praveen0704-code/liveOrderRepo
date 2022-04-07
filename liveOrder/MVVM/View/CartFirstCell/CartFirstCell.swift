//
//  CartFirstCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit
protocol editBtnDelegate {
    func editBtn(type: String)
}

class CartFirstCell: UITableViewCell {
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var locatinImage: UIImageView!
    @IBOutlet weak var deliverLbl: UILabel!
    @IBOutlet weak var madicalsName: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var storeIMage: UIImageView!
    @IBOutlet weak var orderLbl: UILabel!
    @IBOutlet weak var secndMedicalNameLbl: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    
    var delegate:editBtnDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeBtnAct(_ sender: Any) {
        delegate?.editBtn(type: "1")
    }
    
    @IBAction func editBtnAct(_ sender: Any) {
        delegate?.editBtn(type: "Pizza di Mama")
    }
}
