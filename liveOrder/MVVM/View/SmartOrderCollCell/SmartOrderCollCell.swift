//
//  SmartOrderCollCell.swift
//  liveOrder
//
//  Created by Data Prime on 11/09/21.
//

import UIKit

class SmartOrderCollCell: UICollectionViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var mlLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var dashLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var pharmaLbl: UILabel!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsAnsLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var addtocartBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func wishListBtnAct(_ sender: Any) {
    }
    @IBAction func addtoCartBtnAct(_ sender: Any) {
    }
    @IBAction func shortBookBtnAct(_ sender: Any) {
    }
    
}
