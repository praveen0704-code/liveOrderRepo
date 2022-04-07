//
//  AlternatesCollCell.swift
//  liveOrder
//
//  Created by Data Prime on 06/09/21.
//

import UIKit

class AlternatesCollCell: UICollectionViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var wishListbtn: UIButton!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsresultLbl: UILabel!
    @IBOutlet weak var addtoCartbtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
