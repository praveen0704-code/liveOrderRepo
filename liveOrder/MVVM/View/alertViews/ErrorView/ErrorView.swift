//
//  ErrorView.swift
//  liveOrder
//
//  Created by Data Prime on 25/08/21.
//

import UIKit
protocol loginDelegate {
    func exitCurrnt(type: String)
}
class ErrorView: UIView {
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var loopImage: UIImageView!
    @IBOutlet weak var uhohLbl: UILabel!
    @IBOutlet weak var errorMessageLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var delegate:loginDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    self.signinBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     
    }

    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        self.frame = UIScreen.main.bounds
        overview.layer.borderWidth = 1
        overview.clipsToBounds = true
        overview.layer.cornerRadius = 30
        overview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        addBtn.addTarget(self, action: #selector(butAct), for: .touchUpInside)
        
    }
    @objc func butAct(){
        print("touched")
         delegate?.exitCurrnt(type: "hi")
    }
}
