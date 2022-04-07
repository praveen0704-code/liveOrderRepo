//
//  WatchListCollectionViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit



class WatchListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNmeMLLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var mrpLbl1: UILabel!
    @IBOutlet weak var medicalLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var preSellerLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsResulLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var shortBokBtnImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
