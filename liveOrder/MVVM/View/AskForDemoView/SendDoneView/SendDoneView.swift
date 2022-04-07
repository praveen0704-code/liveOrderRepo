//
//  SendDoneView.swift
//  liveOrder
//
//  Created by Data Prime on 20/12/21.
//
protocol closeDelegate{
  func close()
}
import UIKit

class SendDoneView: UIView {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var successfullLbl: UILabel!
    @IBOutlet weak var thankyouLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var rmoveView: UIView!
    var delegate : closeDelegate?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
        rmoveView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        delegate?.close()
        self.removeFromSuperview()
        
        }

    @IBAction func closeBtnAct(_ sender: Any) {
        delegate?.close()
        self.removeFromSuperview()

    }
}
