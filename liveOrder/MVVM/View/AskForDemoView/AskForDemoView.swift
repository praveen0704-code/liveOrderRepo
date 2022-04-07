//
//  AskForDemoView.swift
//  liveOrder
//
//  Created by Data Prime on 17/12/21.
//
protocol cSquareSendDemoDelegate {
    func cSquareDetails(storeName:String,owner:String,mobileNum:String,pincode:String,description:String)
    func demoDetails(storeName:String,owner:String,mobileNum:String,pincode:String,description:String,cProduct:String)
}
import UIKit

class AskForDemoView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var scrolVIew: UIScrollView!
    @IBOutlet weak var innerOverView: UIView!
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var storeNameTxtField: DesignableUITextField!
    @IBOutlet weak var storeErrorLbl: UILabel!
    @IBOutlet weak var ownerTxtField: DesignableUITextField!
    @IBOutlet weak var ownerErrorLbl: UILabel!
    
    @IBOutlet weak var phoneTxtField: DesignableUITextField!
    @IBOutlet weak var phoneErrorLbl: UILabel!
    @IBOutlet weak var pincodeTxtField: DesignableUITextField!
    @IBOutlet weak var pincodeErrorLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var maxNumLbl: UILabel!
    @IBOutlet weak var desTxtView: UITextView!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var areYouLbl: UILabel!
    @IBOutlet weak var sheduleBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var thankLbl: UILabel!
    
    @IBOutlet weak var fillLbl: UILabel!
    // HEIGHT CONSTRAINS FOR ERROR LBL
    @IBOutlet weak var storeErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var ownerErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var phoneErorHeight: NSLayoutConstraint!
    @IBOutlet weak var pincodeErrorHeight: NSLayoutConstraint!
    
    var demobtn = 0
    var delegate : cSquareSendDemoDelegate?
    var productName : String?
    var strCount = "500"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        sheduleBtn.isUserInteractionEnabled = false
        let starTxt = "*"
        self.desLbl.text = "Description " + starTxt
        desLbl.setSubTextColor(pSubString: starTxt, pColor: .red)
        desTxtView.text = "  Yes, I am interested in demo."
        desTxtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        self.maxNumLbl.text = "Max " + strCount + " character"
        maxNumLbl.setSubTextColor(pSubString: strCount, pColor: .init(red: 0, green: 211, blue: 180, alpha: 1))
      
//        storeNameTxtField.becomeFirstResponder()
//        ownerTxtField.isUserInteractionEnabled = false
//        phoneTxtField.isUserInteractionEnabled = false
//        pincodeTxtField.isUserInteractionEnabled = false
        desTxtView.delegate = self
        storeNameTxtField.delegate = self
        ownerTxtField.delegate = self
        phoneTxtField.delegate = self
        pincodeTxtField.delegate = self
        storeErrorHeight.constant = 0
        storeErrorLbl.layoutIfNeeded()
        ownerErrorHeight.constant = 0
        ownerErrorLbl.layoutIfNeeded()
        phoneErorHeight.constant = 0
        phoneErrorLbl.layoutIfNeeded()
        pincodeErrorHeight.constant = 0
        pincodeErrorLbl.layoutIfNeeded()
        self.frame = UIScreen.main.bounds
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
                removeView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        storeNameTxtField.text = ""
        ownerTxtField.text = ""
        phoneTxtField.text = ""
        pincodeTxtField.text = ""
        desTxtView.text = ""
        self.removeFromSuperview()
        }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                
            case .down:
                print("Swiped down")
                storeNameTxtField.text = ""
                ownerTxtField.text = ""
                phoneTxtField.text = ""
                pincodeTxtField.text = ""
                desTxtView.text = ""
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
    func updateCharacterCount() {
        let str = "\((500) - self.desTxtView.text.count )"
        strCount = str
        print(str)
        self.maxNumLbl.text = "Max " + strCount + " character"
        maxNumLbl.setSubTextColor(pSubString: strCount, pColor: .init(red: 0, green: 211, blue: 180, alpha: 1))

    }
    func buttonColorchange(){
        sheduleBtn.backgroundColor = UIColor(hexString: "674cf3")
        sheduleBtn.setTitle("Shedule Demo", for: .normal)
        sheduleBtn.setTitleColor(UIColor.white, for: .normal)
        sheduleBtn.isUserInteractionEnabled = true
        
    }
    func brownColorchange(){
        sheduleBtn.backgroundColor = UIColor(hexString: "5B636A")
        sheduleBtn.setTitle("Shedule Demo", for: .normal)
        sheduleBtn.setTitleColor(UIColor.white, for: .normal)
        sheduleBtn.isUserInteractionEnabled = false
        
    }
    @IBAction func agreeBtnAct(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.backgroundColor = UIColor(hexString: "674cf3")
            sender.setImage(UIImage(named: "tickWhite"), for: .normal)
            
        }else{
            sender.backgroundColor = .white
            sender.setImage(UIImage(named: ""), for: .normal)
        }
    }
    @IBAction func closeBtnAct(_ sender: Any) {
        storeNameTxtField.text = ""
        ownerTxtField.text = ""
        phoneTxtField.text = ""
        pincodeTxtField.text = ""
        desTxtView.text = ""
        self.removeFromSuperview()
    }
    @IBAction func sheduleDemoBtnAct(_ sender: Any) {
     
            if storeNameTxtField.text!.count >= 4 && ownerTxtField.text!.count >= 4 && phoneTxtField.text?.count == 10 && pincodeTxtField.text?.count == 6{
               
               
                
                delegate?.cSquareDetails(storeName: storeNameTxtField.text ?? "", owner: ownerTxtField.text ?? "", mobileNum: phoneTxtField.text ?? "", pincode: pincodeTxtField.text ?? "", description: desTxtView.text ?? "Yes, I am interested in demo.")
                delegate?.demoDetails(storeName: storeNameTxtField.text ?? "", owner: ownerTxtField.text ?? "", mobileNum: phoneTxtField.text ?? "", pincode: pincodeTxtField.text ?? "", description: desTxtView.text ?? "Yes, I am interested in demo.", cProduct: productName ?? "")
                
                storeNameTxtField.text = ""
                ownerTxtField.text = ""
                phoneTxtField.text = ""
                pincodeTxtField.text = ""
                desTxtView.text = ""
            }else{
                if ownerTxtField.text!.count <= 4{
                    storeNameTxtField.borderColor = .systemPink
                    storeErrorHeight.constant = 15
                    storeErrorLbl.layoutIfNeeded()
                }
                
                else if ownerTxtField.text!.count <= 4{
                    ownerTxtField.borderColor = .systemPink
                    ownerErrorHeight.constant = 15
                    ownerErrorLbl.layoutIfNeeded()
                 } else if phoneTxtField.text?.count != 10{
                     phoneTxtField.borderColor = .systemPink
                     phoneErorHeight.constant = 15
                     phoneErrorLbl.layoutIfNeeded()
                 }
                if pincodeTxtField.text?.count != 6{
                    pincodeTxtField.resignFirstResponder()
                    pincodeTxtField.borderColor = .systemPink
                    pincodeErrorHeight.constant = 15
                    pincodeErrorLbl.layoutIfNeeded()
                    
                }
                
            }
           
        }
         
}
extension AskForDemoView : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == storeNameTxtField{
            storeNameTxtField.borderColor = UIColor(hexString: "c3cde4")
            storeErrorHeight.constant = 0
            storeErrorLbl.layoutIfNeeded()
        }else if textField == ownerTxtField{
            ownerTxtField.borderColor = UIColor(hexString: "c3cde4")
            ownerErrorHeight.constant = 0
            ownerErrorLbl.layoutIfNeeded()
        }else if textField == phoneTxtField{
            phoneTxtField.borderColor = UIColor(hexString: "c3cde4")
            phoneErorHeight.constant = 0
            phoneErrorLbl.layoutIfNeeded()
        }else{
            pincodeTxtField.borderColor = UIColor(hexString: "c3cde4")
            pincodeErrorHeight.constant = 0
            pincodeErrorLbl.layoutIfNeeded()
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == storeNameTxtField{
            if storeNameTxtField.text!.count >= 4{
                
                ownerTxtField.becomeFirstResponder()
                
                
            }else{
                storeNameTxtField.borderColor = .systemPink
                storeErrorHeight.constant = 15
                storeErrorLbl.layoutIfNeeded()
            }
           
        }else if textField == ownerTxtField{
            if ownerTxtField.text!.count >= 4{
             
                
                phoneTxtField.becomeFirstResponder()
            }else{
                ownerTxtField.borderColor = .systemPink
                ownerErrorHeight.constant = 15
                ownerErrorLbl.layoutIfNeeded()
            }
            
        }else if textField == phoneTxtField{
            if phoneTxtField.text?.count == 10{
                
                pincodeTxtField.becomeFirstResponder()
            }else{
                phoneTxtField.borderColor = .systemPink
                phoneErorHeight.constant = 15
                phoneErrorLbl.layoutIfNeeded()
            }
            
        }else{
            if pincodeTxtField.text?.count == 6{
                pincodeTxtField.resignFirstResponder()
                self.buttonColorchange()
            }else{
                pincodeTxtField.borderColor = .systemPink
                pincodeErrorHeight.constant = 15
                pincodeErrorLbl.layoutIfNeeded()
            }
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == storeNameTxtField{
            if storeNameTxtField.text!.count >= 4{
                
                ownerTxtField.becomeFirstResponder()
                
                
            }else{
                storeNameTxtField.borderColor = .systemPink
                storeErrorHeight.constant = 15
                storeErrorLbl.layoutIfNeeded()
            }
           
        }else if textField == ownerTxtField{
            if ownerTxtField.text!.count >= 4{
                
                
                phoneTxtField.becomeFirstResponder()
            }else{
                ownerTxtField.borderColor = .systemPink
                ownerErrorHeight.constant = 15
                ownerErrorLbl.layoutIfNeeded()
            }
            
        }else if textField == phoneTxtField{
            if phoneTxtField.text?.count == 10{
                 
                pincodeTxtField.becomeFirstResponder()
            }else{
                phoneTxtField.borderColor = .systemPink
                phoneErorHeight.constant = 15
                phoneErrorLbl.layoutIfNeeded()
            }
            
        }else{
            if pincodeTxtField.text?.count == 6{
                pincodeTxtField.resignFirstResponder()
                self.buttonColorchange()
                
            }else{
                pincodeTxtField.borderColor = .systemPink
                pincodeErrorHeight.constant = 15
                pincodeErrorLbl.layoutIfNeeded()
            }
            
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == storeNameTxtField{
            if storeNameTxtField.text!.count <= 3 || ownerTxtField.text!.count <= 3 || phoneTxtField.text?.count != 10 || pincodeTxtField.text?.count != 6{
                self.brownColorchange()
            }else{
                self.buttonColorchange()
            }
        }
        if textField == ownerTxtField{
            if storeNameTxtField.text!.count <= 3 || ownerTxtField.text!.count <= 3 || phoneTxtField.text?.count != 10 || pincodeTxtField.text?.count != 6{
                self.brownColorchange()
            }else{
                self.buttonColorchange()
            }
        }
        if textField == phoneTxtField{
//            let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789")
//               let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
//               if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
//                   return false
//               }
            if phoneTxtField.text?.checkDataType(text: phoneTxtField.text!) == true{
                
                 
                let first4 = String(phoneTxtField.text!.prefix(1))
                
                let a:Int? = Int(first4)
                if  (1...5).contains(a!) == true{
                   
                    let MAX_LENGTH = 4
                    let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    phoneErorHeight.constant = 15
                    phoneErrorLbl.layoutIfNeeded()
                    
                    return updatedString.count <= MAX_LENGTH
                    
                }else{
                    let maxLength = 10          // set your need
                    let currentString: NSString = textField.text! as NSString
                    let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                    phoneErorHeight.constant = 0
                    phoneErrorLbl.layoutIfNeeded()
                    if storeNameTxtField.text!.count <= 3 || ownerTxtField.text!.count <= 3 || phoneTxtField.text?.count != 10 || pincodeTxtField.text?.count != 6{
                        self.brownColorchange()
                    }else{
                        self.buttonColorchange()
                    }
                    return newString.length <= maxLength
                    
                }
            }
            
            let maxLength = 10         // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            
            return newString.length <= maxLength
        
          
            
            }
        if textField == pincodeTxtField{
            if pincodeTxtField.text?.count == 0 && string == "0" {
                   
                   return false
            }else{
                if pincodeTxtField.text!.count  == 5{
                    if (pincodeTxtField.text! + string).count == 6{
                        let txt = pincodeTxtField.text! + string
                        pincodeTxtField.text = txt
                        pincodeTxtField.resignFirstResponder()
                        if storeNameTxtField.text!.count <= 3 || ownerTxtField.text!.count <= 3 || phoneTxtField.text?.count != 10 || pincodeTxtField.text?.count != 6{
                            self.brownColorchange()
                        }else{
                            self.buttonColorchange()
                        }
                    }else{
                        self.brownColorchange()
                    }
                    
                }else{
                    self.brownColorchange()
                }
                    
            }
            let maxLength = 6          // set your need
                   let currentString: NSString = textField.text! as NSString
                   let newString: NSString =
                       currentString.replacingCharacters(in: range, with: string) as NSString
                   return newString.length <= maxLength
        }
        return true
        
    }
}
extension AskForDemoView : UITextViewDelegate {
     func textViewDidBeginEditing(_ textView: UITextView) {
        if desTxtView.textColor == UIColor(hexString: "5b636a", alpha: 0.50) {
            desTxtView.text = "  Yes, I am interested in demo."
            desTxtView.textColor = UIColor(hexString: "5b636a")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if desTxtView.text.isEmpty {
            desTxtView.text = "  Yes, I am interested in demo."
            desTxtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        }else{
            desTxtView.text = "  Yes, I am interested in demo."
            desTxtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.updateCharacterCount()
        
          return textView.text .count +  (text .count - range.length) < 500
    }
}
