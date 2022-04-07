//
//  PdpSecCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit
import iOSDropDown

protocol reloadTaleViewDelegate{
    
    func reloadTBData(selectedIndexStr:String)
    
}

class PdpSecCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var pharmaNameLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var quantityDropDown: DropDown!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var reloadDelegate:reloadTaleViewDelegate?
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
  
        quantityDropDown.optionArray = ["1","2","3","4","5","6","7","8","9","10"]
        quantityDropDown.optionIds = [1,23,54,22,55,6,7,8,9,10]
   
       
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    @IBAction func addToCartBtnAct(_ sender: Any) {
        
        
    }
}
