//
//  TopSearchedMedicinesCollCell.swift
//  liveOrder
//
//  Created by Data Prime on 05/07/21.
//

import UIKit

class TopSearchedMedicinesCollCell: UICollectionViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productMgLbl: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsNameLbl: UILabel!
    @IBOutlet weak var addToCardBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overAllView.layer.cornerRadius =  5
        overAllView.layer.cornerRadius = 1
        
    }

}
