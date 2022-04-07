//
//  ImgCollectionViewCell.swift
//  liveOrder
//
//  Created by PraveenMac on 09/07/21.
//

import UIKit

class ImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var imgGView: UIImageView!
    @IBOutlet weak var mfgLbl: UILabel!
    @IBOutlet weak var alterLbl: UILabel!
    @IBOutlet weak var smLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
