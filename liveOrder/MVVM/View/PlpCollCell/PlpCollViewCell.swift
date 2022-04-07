//
//  PlpCollViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit

class PlpCollViewCell: UICollectionViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var ProductDesLbl: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var contAnswerLbl: UILabel!
    @IBOutlet weak var addtoCartBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
