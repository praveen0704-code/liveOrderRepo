//
//  DiscountDetailsView.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//

import UIKit

class DiscountDetailsView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var disView: UIView!
    @IBOutlet weak var cartTotalLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var toatalRupeeLbl: UILabel!
    @IBOutlet weak var gstRupeeLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalgstRupeeLbl: UILabel!
    
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
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.overView.addGestureRecognizer(gesture)

       

}
     
    @objc func checkAction(sender : UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
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
}
