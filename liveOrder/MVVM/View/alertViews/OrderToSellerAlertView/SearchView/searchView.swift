//
//  searchView.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//
protocol wlSearchTxt{
    func searchTxt(Txt:String)
}
import UIKit

class searchView: UIView {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var removeView: UIView!
    var delegate : wlSearchTxt?
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
      
        searchTxtField.delegate = self
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search_iconblack")
        imageView.image = image
        
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        
        padView.addSubview(imageView)
        searchTxtField.leftView = padView
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        
       
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

    
  
    

}

extension searchView:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTxtField.resignFirstResponder()
        self.removeFromSuperview()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTxtField.text!.count >= 2{
            delegate?.searchTxt(Txt: searchTxtField.text! + string)
        }else{
            delegate?.searchTxt(Txt: "")
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtField.resignFirstResponder()
        self.removeFromSuperview()
        return true
    }
}
