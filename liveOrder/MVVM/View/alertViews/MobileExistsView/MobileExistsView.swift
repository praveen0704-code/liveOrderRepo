//
//  MobileExistsView.swift
//  liveOrder
//
//  Created by Data Prime on 22/09/21.
//

import UIKit
protocol mobilexist {
    func mobileExisits(type: Int)
}
class MobileExistsView: UIView {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loopImage: UIImageView!
    @IBOutlet weak var uhOhlbl: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var addsellerBtn: UIButton!
    @IBOutlet weak var removeView: UIView!
    var Mobdelegate:mobilexist?
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
         
       
        self.frame = UIScreen.main.bounds
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 30
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addsellerBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")]);
        
        let colorString = "Mobile Number "
        self.txtLbl.text = "Entered " + colorString + " is already ExistsClick below to LogIn"
        txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
       
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.mainView.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
                removeView.addGestureRecognizer(tapGesture)
       

}
     
    @objc func handleTap(sender: UITapGestureRecognizer) {
        Mobdelegate?.mobileExisits(type: 1)
        self.removeFromSuperview()
        }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                
            case .down:
                print("Swiped down")
                Mobdelegate?.mobileExisits(type: 1)
                self.removeFromSuperview()
                
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    @IBAction func addSellerBtnAct(_ sender: Any) {
        if isLoginInt == 1{
            Mobdelegate?.mobileExisits(type: 2)

        }else{
            self.removeFromSuperview()

        }
    }
    
}
