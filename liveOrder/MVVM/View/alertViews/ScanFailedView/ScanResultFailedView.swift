//
//  ScanResultFailedView.swift
//  liveOrder
//
//  Created by Data Prime on 24/07/21.
//

import UIKit

class ScanResultFailedView: UIView {
 
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var traAgainLbl: UILabel!
    @IBOutlet weak var scannedproductLbl: UILabel!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var tryWithSearchLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        let imgSearchs =  UIImageView(image: UIImage(named: "search_icon"))
        imgSearchs.frame = CGRect(x:10 , y: 10, width:  20, height: 20)
        let viewss = UIView.init(frame: CGRect.init(x: 10, y: 0, width: 40, height: 40))
        
        viewss.addSubview(imgSearchs)
        searchTxtField.leftView = viewss
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        overAllView.clipsToBounds = true
        overAllView.layer.cornerRadius = 30
        overAllView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    @IBAction func crossBtnAct(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        //transition.type = .reveal
        transition.subtype = CATransitionSubtype.fromLeft

        self.layer.add(transition, forKey: kCATransition)
        self.removeFromSuperview()

    }
}
