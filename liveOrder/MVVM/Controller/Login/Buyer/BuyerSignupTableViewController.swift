//
//  BuyerSignupTableViewController.swift
//  liveOrder
//
//  Created by Data Prime on 02/07/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class BuyerSignupTableViewController: UITableViewController,mobilexist {
    func mobileExisits(type: Int) {
        if type == 1 {
            self.tableView.isScrollEnabled = true
            
        }else if type == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        
        }
    }
    
    @IBOutlet weak var buyerFirstNameTxtfield: DesignableUITextField!
    @IBOutlet weak var mobileNumerTxtField: DesignableUITextField!
    @IBOutlet weak var passwordTxtField: DesignableUITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var sellerBtn: UIButton!
    @IBOutlet weak var pinCodeTxtField: DesignableUITextField!
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var pinCodeErrorLbl: UILabel!
    @IBOutlet weak var mobileNumErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var passErrorTxt: UILabel!
    @IBOutlet weak var nameErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var pincodeErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var mobileErrorHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var passwordImageView: UIImageView!
    
    var buyerRegisterModel:RegisterLO?
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    var userexist = false
    var cellheight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setup()
    }
    func setup(){
        sellerBtn.isHidden = true
        registerLbl.isHidden = true
        nameErrorLbl.isHidden = true
        pinCodeErrorLbl.isHidden = true
        mobileNumErrorLbl.isHidden = true
        passErrorTxt.textColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        
        self.registerBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        buyerFirstNameTxtfield.delegate = self
        mobileNumerTxtField.delegate = self
        passwordTxtField.delegate = self
        pinCodeTxtField.delegate = self
        passwordTxtField.isUserInteractionEnabled = false
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 0, width: CGFloat(60), height: CGFloat(60)))
                
            passwordButton.contentMode = .scaleAspectFill
            
            passwordButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            
            passwordButton.addTarget(self, action: #selector(passViewTap), for: .touchUpInside)
            let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        
        views.addSubview(passwordButton)
        passwordTxtField.rightView = views
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.rightViewMode = .always
        
        registerLbl.attributedText = fontchangeAttribtre(bFontNameStr: "Quicksand-Medium", bFontColorStr: UIColor(hexString: "#ff7b20"), bFontSizeFloat: 13.0, bStr:
                                                                "  Register here", rFontNameStr: "Quicksand-Medium", rFontColorStr: UIColor(hexString: "2e3e6a"), rFontSizeFloat: 13.0, rStr: "Are you a Seller?")
        
        nameErrorHeightConstrains.constant = 0.0
        nameErrorLbl.layoutIfNeeded()
        pincodeErrorHeightConstrains.constant = 0.0
        pinCodeErrorLbl.layoutIfNeeded()
        mobileErrorHeightConstrains.constant = 5.0
        mobileNumErrorLbl.layoutIfNeeded()
        

    }
    
    @objc  func passViewTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    
    if sender.isSelected{
        passwordImageView.image = UIImage(named: "eye")

    }else{
        passwordImageView.image = UIImage(named: "eyeclosed")

    }
    
    passwordTxtField.isSecureTextEntry = !sender.isSelected
          }
    
    
   //MARK: - Button Action

    @IBAction func registerBtnAct(_ sender: Any) {
        
        
        if buyerFirstNameTxtfield.text!.count >= 3 && buyerFirstNameTxtfield.text!.count <= 256 && mobileNumerTxtField.text?.count != 0 && mobileNumerTxtField.text?.count == 10 && pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 && ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true) && userexist == true {
           
            registerApiCall()


          
        }else if buyerFirstNameTxtfield.text?.count == 0 && buyerFirstNameTxtfield.text!.count <= 3{
            nameErrorLbl.isHidden = false
            nameErrorLbl.text = "Please enter the valid username 3 - 256 character"
            nameErrorHeightConstrains.constant = 11
            nameErrorLbl.layoutIfNeeded()
//            buyerFirstNameTxtfield.layer.borderColor = UIColor.red.cgColor
//            buyerFirstNameTxtfield.placeholder = "    Please enter the valid name"
            mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if mobileNumerTxtField.text?.count == 0 && mobileNumerTxtField.text?.count != 10  {
            mobileNumErrorLbl.isHidden = false
            mobileNumErrorLbl.text = "Please enter the valid mobile number "
            mobileErrorHeightConstrains.constant = 11
            mobileNumErrorLbl.layoutIfNeeded()
//            mobileNumerTxtField.layer.borderColor = UIColor.red.cgColor
//            mobileNumerTxtField.placeholder = "    Please enter the valid mobile "
            buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if pinCodeTxtField.text?.count == 0 && pinCodeTxtField.text!.count != 6 {
            pinCodeErrorLbl.isHidden = false
            pinCodeErrorLbl.text = "Please enter the valid pincode"
            pincodeErrorHeightConstrains.constant = 11
            pinCodeErrorLbl.layoutIfNeeded()
//            pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//            pinCodeTxtField.placeholder = "    Please enter the valid pincode"
            buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if passwordTxtField.text?.count == 0 && ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == false){
            passErrorTxt.textColor = .systemRed
            mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else{
            print("check")
          //  UIView().showToast(message: "Mobile Number already exist", view: self.view)
            
        }
        
       
    }
    
   
   
    @IBAction func signBtnAct(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func sellerBtnAct(_ sender: Any) {

        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpTableViewController") as? SignUpTableViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

   

}

extension BuyerSignupTableViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.buyerFirstNameTxtfield{
            
            
    
            nameErrorLbl.isHidden = true
            buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            buyerFirstNameTxtfield.placeholder = "Buyer Firm Name"
       //     buyerFirstNameTxtfield.textColor = .black
            passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            
            
        }else if textField == self.mobileNumerTxtField{
           
                mobileNumErrorLbl.isHidden = true
                mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                mobileNumerTxtField.placeholder = "Mobile Number"
           //     mobileNumerTxtField.textColor = .black
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        
                     
                    }else if textField == self.passwordTxtField{
                    
                        
                passErrorTxt.textColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                passwordTxtField.placeholder = "Create Password"
            //    passwordTxtField.textColor = .black
                buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                    
                                 
            }else if textField == self.pinCodeTxtField{
                               
                pinCodeErrorLbl.isHidden = true
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                pinCodeTxtField.placeholder = "PinCode"
               // pinCodeTxtField.textColor = .black
                buyerFirstNameTxtfield.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                mobileNumerTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                
                                             
                                            }
        }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == buyerFirstNameTxtfield{
            if buyerFirstNameTxtfield.text!.count >= 3 && buyerFirstNameTxtfield.text!.count <= 256{
               
                nameErrorHeightConstrains.constant = 0.0
                nameErrorLbl.layoutIfNeeded()

                pinCodeTxtField.becomeFirstResponder()
            }else{
                
                self.buyerFirstNameTxtfield.resignFirstResponder()

                nameErrorHeightConstrains.constant = 10.0
                nameErrorLbl.layoutIfNeeded()
                

                nameErrorLbl.isHidden = false
                nameErrorLbl.text = "Please enter the valid username 3 - 256 character"
//                buyerFirstNameTxtfield.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
            }
        }
        if textField == pinCodeTxtField {
            if pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 {

                pincodeErrorHeightConstrains.constant = 0.0
                pinCodeErrorLbl.layoutIfNeeded()
              

                self.mobileNumerTxtField.becomeFirstResponder()
            }else{
                

                
                pincodeErrorHeightConstrains.constant = 10.0
                pinCodeErrorLbl.layoutIfNeeded()
                self.pinCodeTxtField.resignFirstResponder()
               
                

                pinCodeErrorLbl.isHidden = false
                pinCodeErrorLbl.text = "Please enter valid pincode"
//                pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid password", view: self.view)
            }
        }
        if textField == mobileNumerTxtField{
            if mobileNumerTxtField.text?.count != 0 && mobileNumerTxtField.text?.count == 10{
                
                mobileErrorHeightConstrains.constant = 0.0
                mobileNumErrorLbl.layoutIfNeeded()

                mobileCheck(num: mobileNumerTxtField.text ?? "")
               
            }else{
                self.mobileNumerTxtField.resignFirstResponder()

                mobileErrorHeightConstrains.constant = 11.0
                mobileNumErrorLbl.layoutIfNeeded()

                mobileNumErrorLbl.isHidden = false
                mobileNumErrorLbl.text = "Please enter the valid mobile number"
//                mobileNumerTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid number", view: self.view)
            }
        }
        if textField == passwordTxtField {
            if ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                passwordTxtField.resignFirstResponder()
            }else{
                passErrorTxt.textColor = .systemRed
//              passwordTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
            }
            
        }

        }
      
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == buyerFirstNameTxtfield{
               
               
               
                    let rawString = string
                    let rowrange = rawString.rangeOfCharacter(from: .whitespaces)
                        if ((buyerFirstNameTxtfield.text?.count)! == 0 && rowrange  != nil)
                        || ((buyerFirstNameTxtfield.text?.count)! > 0 && buyerFirstNameTxtfield.text?.last  == " " && rowrange != nil)  {
                            return false
                        }else{
                            let maxLength = 256          // set your need
                                                      let currentString: NSString = textField.text! as NSString
                                                      let newString: NSString =
                                                          currentString.replacingCharacters(in: range, with: string) as NSString
                                           
                                           
                                                      return newString.length <= maxLength
                        }
                    
                        
                    
            }
        if textField == pinCodeTxtField{
            if textField.text?.count == 0 && string == "0" {
                   
                   return false
            }else{
                let maxLength = 6          // set your need
                           let currentString: NSString = textField.text! as NSString
                           let newString: NSString =
                               currentString.replacingCharacters(in: range, with: string) as NSString
                           return newString.length <= maxLength
            }
               
               
            }
        if textField == mobileNumerTxtField{
           
            if mobileNumerTxtField.text?.checkDataType(text: mobileNumerTxtField.text!) == true{
                if mobileNumerTxtField.text?.count == 9 {
                    print(mobileNumerTxtField.text! + string)
                    if (mobileNumerTxtField.text! + string).count == 10{
                        mobileNumerTxtField.text = mobileNumerTxtField.text! + string
                        mobileCheck(num: mobileNumerTxtField.text!)
                    }
                    
                }
                let first4 = String(mobileNumerTxtField.text!.prefix(1))
                
                var a:Int? = Int(first4)
                if  (1...5).contains(a!) == true{
                    mobileNumErrorLbl.isHidden = false
                    let MAX_LENGTH = 4
                            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                            return updatedString.count <= MAX_LENGTH
                    
                
                }else{
                    let maxLength = 10          // set your need
                               let currentString: NSString = textField.text! as NSString
                               let newString: NSString =
                                   currentString.replacingCharacters(in: range, with: string) as NSString
                    
                    
                               return newString.length <= maxLength
                    
                }
                
               
                
            }
           
           
        }
       
        if textField == passwordTxtField{
            let maxLength = 16         // set your need
                       let currentString: NSString = textField.text! as NSString
                       let newString: NSString =
                           currentString.replacingCharacters(in: range, with: string) as NSString
                       return newString.length <= maxLength
        }
        
            
            return true
            
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          
            switch textField{
            case buyerFirstNameTxtfield :
                if textField  == buyerFirstNameTxtfield{
                    if buyerFirstNameTxtfield.text!.count >= 3 && buyerFirstNameTxtfield.text!.count <= 256{
                       
                        cellheight = 0
                        tableView.reloadData()
                        nameErrorHeightConstrains.constant = 0.0
                        nameErrorLbl.layoutIfNeeded()
                       

                        pinCodeTxtField.becomeFirstResponder()
                        
                    }else{
                        self.buyerFirstNameTxtfield.resignFirstResponder()
                        cellheight = 1
                        tableView.reloadData()
                        nameErrorHeightConstrains.constant = 11.0
                        nameErrorLbl.layoutIfNeeded()
        
                        nameErrorLbl.isHidden = false
                        nameErrorLbl.text = "Please enter the valid username 3 - 256 character"
//                        buyerFirstNameTxtfield.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                    }
                }
            case self.pinCodeTxtField:
                if pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 {
                    cellheight = 0
                    tableView.reloadData()
                    pincodeErrorHeightConstrains.constant = 0.0
                    pinCodeErrorLbl.layoutIfNeeded()
            
                    self.mobileNumerTxtField.becomeFirstResponder()
                }else{
                    self.pinCodeTxtField.resignFirstResponder()
                    cellheight = 1
                    tableView.reloadData()
                    
                    pincodeErrorHeightConstrains.constant = 11.0
                    pinCodeErrorLbl.layoutIfNeeded()
                   

                    pinCodeErrorLbl.isHidden = false
                    pinCodeErrorLbl.text = "Please enter valid pincode"
    //                pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
    //                UIView().showToast(message: "Please enter the valid password", view: self.view)
                }
            case self.mobileNumerTxtField:
                if mobileNumerTxtField.text?.count != 0 && mobileNumerTxtField.text?.count == 10{
                  
                     
                   
                    mobileErrorHeightConstrains.constant = 0.0
                    mobileNumErrorLbl.layoutIfNeeded()

                    
                    
                    self.passwordTxtField.becomeFirstResponder()
                }else{
                    self.mobileNumerTxtField.resignFirstResponder()
                    
                    mobileErrorHeightConstrains.constant = 11.0
                    mobileNumErrorLbl.layoutIfNeeded()

                    mobileNumErrorLbl.isHidden = false
                    mobileNumErrorLbl.text = "Please enter the valid mobile number"
    //                mobileNumerTxtField.layer.borderColor = UIColor.red.cgColor
    //                UIView().showToast(message: "Please enter the valid number", view: self.view)
                }
            case self.passwordTxtField:
                
                     
                      if ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                      }else{
                        passErrorTxt.textColor = .systemRed
//                        passwordTxtField.layer.borderColor = UIColor.red.cgColor
//                          UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
                      }
                self.passwordTxtField.resignFirstResponder()
            default:
                self.buyerFirstNameTxtfield.becomeFirstResponder()
            }
            return true
   
        }
}


extension BuyerSignupTableViewController:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    
    func registerApiCall(){
        //showActivityIndicator(self.view)
        let registerService:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Register")

        let dictionaryRegisterRequest = ["c_name": buyerFirstNameTxtfield.text!,
                                       "c_mobile_no":mobileNumerTxtField.text!,
                                       "c_pwd": passwordTxtField.text!,
                                       "c_pincode": pinCodeTxtField.text!,
                                       "c_type" : buyerConstantStr
        ]
        
        
        registerService.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REGISTER_URL, type: .post, userData: dictionaryRegisterRequest as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.buyerRegisterModel = RegisterLO(object:dict)
            print(dict)
            if boolSuccess {
                if self.buyerRegisterModel?.appStatusCode == 0 {
                    
                    let regiserStatusStr = self.buyerRegisterModel?.messages?[0]
                    if regiserStatusStr == "Registered Successfully!"{
                        UserDefaults.standard.setValue(self.buyerRegisterModel?.payloadJson?.data?.key, forKey: ketConstantStr)
                        UserDefaults.standard.setValue(self.buyerRegisterModel?.payloadJson?.data?.token, forKey: tokenConstantStr)
                        UserDefaults.standard.setValue(self.buyerRegisterModel?.payloadJson?.data?.cType, forKey: typeConstantStr)
                        UserDefaults.standard.setValue(self.buyerRegisterModel?.payloadJson?.data?.tokenExpiry, forKey: tokenExpireStr)


                        sendOTP()
                        
                    }else{
                        
                        //do requird function
                        
                    
                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                        isLoginInt = 1
                    self.MobileExistsView?.Mobdelegate = self
                    self.MobileExistsView?.addsellerBtn.setTitle("LogIn", for: .normal)
                       
                  self.tableView.addSubview(self.MobileExistsView!)
                    self.tableView.isScrollEnabled = false
                       


                    }
                    

                }
                else
                {
                }
            }
            else
            {
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })

        
        
        
    }
    
    
    //FIXME: - Send OTP
    
    func sendOTP(){
        let urlString = LIVE_ORDER_HOSTURL + OTP_URL + mobileNumerTxtField.text!

        AF.request(urlString, method: .get,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
          switch response.result {
                        case .success:
                            print(response)
                           do {
                                let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
                                print(json)
                               
                                
                                let mage = json.value(forKey: "messages") as? NSArray
                                let errormessage = mage![0] as! String
                            
                                print(errormessage)
                            let sucess = "OTP sent successfully"
                                
                            if sucess == errormessage{
                                
                    
                                    DispatchQueue.main.async { [self] in

                                        
                                        let otpScreenVc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                                        otpScreenVc.mode = 1
                                        otpScreenVc.mobileStr = self.mobileNumerTxtField.text
                                        otpScreenVc.pincodeStr = self.pinCodeTxtField.text
                                        otpScreenVc.userNameStr = self.buyerFirstNameTxtfield.text

                                        self.navigationController?.pushViewController(otpScreenVc, animated: true)
                                    
                     
                                }
                                }else{
                                    DispatchQueue.main.async {
                                        UIView().showToast(message:errormessage , view: self.view)
                                    }
                                }
                             
                                
                               
                                
                           }catch{
                            
                           }
                            break
                        case .failure(let error):

                            print(error)
                        }
        }
    }
    
    func mobileCheck(num:String){
        let url = LIVE_ORDER_HOSTURL + MOBILE_EXIST_URL
        let params: [String: Any] = ["c_mobile_no": num,"c_type":"B"]
        
        AF.request(url, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
          switch response.result {
                        case .success:
                            
                            print(response)
                            do {
                                let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
                                print(json)
                                let mage = json.value(forKey: "messages") as? NSArray
                                let errormessage = mage![0] as! String
                            
                                print(errormessage)
                            let exitUser = "Already registered!"
                                if errormessage == "Already registered!"{
                                   
                                        self.mobileNumerTxtField.resignFirstResponder()
                                    self.passwordTxtField.isUserInteractionEnabled = false
                                    self.userexist = false
                                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                    isLoginInt = 1

                                    self.MobileExistsView?.Mobdelegate = self
                                    self.MobileExistsView?.addsellerBtn.setTitle("LogIn", for: .normal)
                                    self.tableView.addSubview(self.MobileExistsView!)
                                    self.tableView.isScrollEnabled = false
                                        self.mobileNumErrorLbl.isHidden = false
                                        self.mobileNumErrorLbl.text = errormessage
                                 
                                    
                                }else if errormessage == "Mobile Number exist in LC1"{
                                    self.mobileNumerTxtField.resignFirstResponder()
                                self.passwordTxtField.isUserInteractionEnabled = false
                                self.userexist = false
                                self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                    isLoginInt = 1

                                self.MobileExistsView?.Mobdelegate = self
                                self.MobileExistsView?.addsellerBtn.setTitle("LogIn", for: .normal)
                                self.tableView.addSubview(self.MobileExistsView!)
                                self.tableView.isScrollEnabled = false
                                    self.mobileNumErrorLbl.isHidden = false
                                    self.mobileNumErrorLbl.text = errormessage
                                }else{
                                    self.userexist = true
                                    self.passwordTxtField.isUserInteractionEnabled = true
                                    self.passwordTxtField.becomeFirstResponder()
                                    self.passErrorTxt.textColor = .systemGray
                                    
                                }

                            }catch{
                                
                            }
                          
                            break
                        case .failure(let error ):

                            print(error)
                           
                        }
        }
    }

}
