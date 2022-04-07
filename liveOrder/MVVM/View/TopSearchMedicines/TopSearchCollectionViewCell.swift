//
//  TopSearchCollectionViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 03/07/21.
//

import UIKit

class TopSearchCollectionViewCell: UICollectionViewCell {
    //FIXME: - Index 1
    
    @IBOutlet weak var productImgView: UIImageView!
    
    
    @IBOutlet weak var containerLabel: UILabel!
    @IBOutlet weak var proNameLabel: UILabel!
    
    @IBOutlet weak var proQutLabel: UILabel!
    
    @IBOutlet weak var prdPricelabel: UILabel!
    
    @IBOutlet weak var proContailsLabel: UILabel!

    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    @IBOutlet weak var comPanyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
