//
//  ShortBookCollViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 26/08/21.
//

import UIKit

class ShortBookCollViewCell: UICollectionViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var mlLbl: UILabel!
    @IBOutlet weak var packSize: UILabel!
    @IBOutlet weak var rupeeLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var preSellerLbl: UILabel!
    @IBOutlet weak var containAnswerLbl: UILabel!
    @IBOutlet weak var preSellerAnswerLbl: UILabel!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var addtoCartBtn: UIButton!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var mrpCrossLbl: UILabel!
    @IBOutlet weak var mrpCrossLblTwo: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var wishBtnImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        crossBtn.borderWidth = 0.0
    }

}
