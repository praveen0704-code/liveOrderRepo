//
//  OtoSColCell.swift
//  liveOrder
//
//  Created by Data Prime on 28/10/21.
//

import UIKit

class OtoSColCell: UICollectionViewCell {
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var dotView: UIView!
    
    @IBOutlet weak var widthConstrainntConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
    }

}
