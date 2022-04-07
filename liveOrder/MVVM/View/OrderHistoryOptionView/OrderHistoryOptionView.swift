//
//  OrderHistoryOptionView.swift
//  liveOrder
//
//  Created by Data Prime on 02/12/21.
//

import UIKit
protocol retrivalBtnDelegate{
    func retrivalBtnAct(taped:String,isDatePickerInt:Int)
}
class OrderHistoryOptionView: UIView {
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var retrievalImgView: UIImageView!
    @IBOutlet weak var filtterBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var roundLbl: UILabel!
    @IBOutlet weak var calenderImgView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var datePickBtn: UIButton!
    var delegate : retrivalBtnDelegate?
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        self.roundLbl.layer.cornerRadius = self.roundLbl.frame.width / 2
        roundLbl.layer.masksToBounds = true
        self.datePickBtn.setTitle("", for: .normal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
             
             // 2. add the gesture recognizer to a view
        removeView.addGestureRecognizer(tapGesture)
        self.roundLbl.text = "\(sellerSelectCount)"
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.bottomView.addGestureRecognizer(swipeDown)
        
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
       }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                self.removeFromSuperview()
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    @IBAction func filtterBtnAct(_ sender: Any) {
        delegate?.retrivalBtnAct(taped: "tapped", isDatePickerInt: 0)
    }
    @IBAction func datePickerAction(_ sender: Any) {
       
        delegate?.retrivalBtnAct(taped: "tapped", isDatePickerInt: 1)

    }
    
}

 
