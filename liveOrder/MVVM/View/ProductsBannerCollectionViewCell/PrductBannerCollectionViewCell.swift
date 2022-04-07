//
//  PrductBannerCollectionViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 03/07/21.
//

import UIKit
import LazyImage

class PrductBannerCollectionViewCell: UICollectionViewCell {
   //FIXME: - Index 0
    @IBOutlet weak var comLogoImgView: UIImageView!
    
    @IBOutlet weak var offerLabel: UILabel!
    
    @IBOutlet weak var DiscountLabel: UILabel!
    
    @IBOutlet weak var offerVAlidatyLabel: UILabel!
    
    @IBOutlet weak var orderNowButton: UIButton!
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

