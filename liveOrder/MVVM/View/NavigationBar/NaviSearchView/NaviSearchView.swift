//
//  NaviSearchView.swift
//  liveOrder
//
//  Created by Data Prime on 10/07/21.
//

import UIKit

class NaviSearchView: UIView{

    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImageBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var microPhonebtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     
    }
 
  
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
      
        
         
      

}
  
}

