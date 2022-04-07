//
//  ContentTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 22/07/21.
//

import UIKit
protocol CustomCellDelegate: class {
    func animationStarted(index : Int)
    func animationFinished()
}

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var ContentLbl: UILabel!
    @IBOutlet weak var selectedBtn: UIButton!
    @IBOutlet weak var lineLbl: UILabel!
     
    weak var delegate: CustomCellDelegate?
    var index : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    @IBAction func selectedBoxBtn(_ sender: Any) {
        delegate?.animationStarted(index: index!)
        
    }
    
}

