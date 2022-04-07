//
//  favouriteSellerCollCell.swift
//  liveOrder
//
//  Created by Data Prime on 07/07/21.
//

import UIKit

class favouriteSellerCollCell: UICollectionViewCell {
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imageLetterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        imgView.layer.cornerRadius = 5
        fullView.layer.borderWidth = 1
        fullView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        fullView.layer.cornerRadius = 5
        fullView.layer.masksToBounds = true

    }

}
