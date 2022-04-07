//
//  MSTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit


class MSTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var pharmaLbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var pendingLbl: UILabel!
    @IBOutlet weak var schemeRupeeLbl: UILabel!
    @IBOutlet weak var pendingRupeeLbl: UILabel!
    @IBOutlet weak var setPriorityBtn: UIButton!
    @IBOutlet weak var dotLineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overView.layer.borderWidth = 0.5
        overView.layer.borderColor = #colorLiteral(red: 0.4235294118, green: 0.4588235294, blue: 0.4901960784, alpha: 0.3)
        overView.layer.cornerRadius = 14
        
        
//        self.dotLineView.drawDottedLine(start: CGPoint(x: dotLineView.bounds.minX, y: dotLineView.bounds.minY), end: CGPoint(x: dotLineView.bounds.maxX, y: dotLineView.bounds.minY), view: dotLineView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
