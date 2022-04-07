//
//  MostOrderedProductCollCell.swift
//  liveOrder
//
//  Created by Data Prime on 07/07/21.
//

import UIKit

class MostOrderedProductCollCell: UICollectionViewCell {
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var shortBookImg: UIImageView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var PakageSize: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsName: UILabel!
    @IBOutlet weak var addtoCardBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
