//
//  RetrievalOptionView.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit
protocol retrivalDelegate {
    func retrivetapped(type: String)
}
protocol searchdelegate{
    func searchTxt(text : String)
}
class RetrievalOptionView: UIView {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pathImage: UIImageView!
    
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var filtterBtn: UIButton!
    @IBOutlet weak var removeView: UIView!
    var delegate:retrivalDelegate?
    var searchDelegate : searchdelegate?
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
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search_iconblack")
        imageView.image = image
        
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        
        padView.addSubview(imageView)
        searchTxtField.leftView = padView
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        searchTxtField.delegate = self
       
        self.frame = UIScreen.main.bounds
       
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.mainView.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
                removeView.addGestureRecognizer(tapGesture)
       

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

    
  
    
    @IBAction func fillterBtnAct(_ sender: Any) {
        delegate?.retrivetapped(type: "hi")
    }
    
}

extension RetrievalOptionView : UITextFieldDelegate{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count > 2 {
            
            searchDelegate?.searchTxt(text: searchTxtField.text ?? "")
           
            
        }
        return true
        
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//            searchDelegate?.searchTxt(text: searchTxtField.text ?? "")
//            self.removeFromSuperview()
//       
//        return true
//    }
}
