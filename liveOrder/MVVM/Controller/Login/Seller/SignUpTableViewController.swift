//
//  SignUpTableViewController.swift
//  liveOrder
//
//  Created by Data Prime on 30/06/21.
//

import UIKit
import Alamofire
class SignUpTableViewController: UITableViewController,mobilexist {
    func mobileExisits(type: Int) {
        if type == 1 {
            self.tableView.isScrollEnabled = true
            
        }else if type == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        
        }
    }
    
    
    
  
    
   
    
    
    @IBOutlet weak var sellerFirmtNameTextFirld: DesignableUITextField!
    @IBOutlet weak var sMobileNumber: DesignableUITextField!
    
    @IBOutlet weak var sCreatePasswordTextField: DesignableUITextField!
    
    
    @IBOutlet weak var sRegisterTextField: UIButton!
    
    @IBOutlet weak var alreadyaccountButton: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var alreadyBuyerLabel: UILabel!
    
    @IBOutlet weak var registerHereButton: UIButton!
    @IBOutlet weak var pinCodeTxtField: DesignableUITextField!
    
    @IBOutlet weak var registerHereLabel: UILabel!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var pinCodeErrorLbl: UILabel!
    @IBOutlet weak var mobileNumErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var PasserrorTxt: UILabel!
    
    
    var sellerRegisterModel:RegisterLO?
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    
    var userexist = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        loadSignUpView()
    }
    
    func loadSignUpView(){
        
        nameErrorLbl.isHidden = true
        pinCodeErrorLbl.isHidden = true
        mobileNumErrorLbl.isHidden = true
        PasserrorTxt.textColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        sellerFirmtNameTextFirld.delegate = self
        sCreatePasswordTextField.delegate = self
        pinCodeTxtField.delegate = self
        self.sMobileNumber.delegate = self
        self.sRegisterTextField.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        registerHereLabel.attributedText = fontchangeAttribtre(bFontNameStr: "Quicksand-Medium", bFontColorStr: UIColor(hexString: "#ff7b20"), bFontSizeFloat: 13.0, bStr:
                                                                "  Register here", rFontNameStr: "Quicksand-Medium", rFontColorStr: UIColor(hexString: "2e3e6a"), rFontSizeFloat: 13.0, rStr: "Are you a Buyer?")
        
        let imageOpenEye = UIImage(named: "eyeclosed")
        let imageCloseEye = UIImage(named: "eye")
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 0, width: CGFloat(52), height: CGFloat(52)))

        passwordButton.setImage(imageOpenEye, for: .normal)
        passwordButton.setImage(imageCloseEye, for: .selected)
        passwordButton.addTarget(self, action: #selector(passViewTap), for: .touchUpInside)
        let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 52, height: 52))
        
        views.addSubview(passwordButton)
        sCreatePasswordTextField.rightView = views
        sCreatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        sCreatePasswordTextField.rightViewMode = .always

    }
    @objc  func passViewTap(sender: UIButton) {
            sender.isSelected = !sender.isSelected
        sCreatePasswordTextField.isSecureTextEntry = !sender.isSelected
          }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
        
    }
    
    
    //MARK: - Button Action
    
   
    @IBAction func registerBtnAct(_ sender: Any) {
       
        
      if sellerFirmtNameTextFirld.text!.count >= 4 && sellerFirmtNameTextFirld.text!.count <= 16 && sMobileNumber.text?.count != 0 && sMobileNumber.text?.count == 10 && pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 && ((sCreatePasswordTextField.text?.isValidPassword(password: (sCreatePasswordTextField.text?.trimmingCharacters(in: .whitespaces))!)) == true) && userexist == true {
          
          registerApiCall()
       
          
            
            
        }else if sellerFirmtNameTextFirld.text?.count == 0 {
            sellerFirmtNameTextFirld.layer.borderColor = UIColor.red.cgColor
            sellerFirmtNameTextFirld.placeholder = "    Please enter the valid name"
            sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if sMobileNumber.text?.count == 0 {
            sMobileNumber.layer.borderColor = UIColor.red.cgColor
            sMobileNumber.placeholder = "    Please enter the valid mobile"
            sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if pinCodeTxtField.text?.count == 0 {
            pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
            pinCodeTxtField.placeholder = "    Please enter the valid pincode"
            sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }
        else if sCreatePasswordTextField.text?.count == 0 {
            sCreatePasswordTextField.layer.borderColor = UIColor.red.cgColor
            sCreatePasswordTextField.placeholder = "    Please enter the valid password"
            sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }
        else{
            print("check")
            UIView().showToast(message: "Mobile Number Exist", view: self.view)
            
        }
        
    }
    
    @IBAction func signinBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    @IBAction func registerbtnAct(_ sender: Any) {

        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerSignupTableViewController") as? BuyerSignupTableViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}
   
extension SignUpTableViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.sellerFirmtNameTextFirld{
            
            
//            userNameTxtfiled.layer.shadowRadius = 1
//            userNameTxtfiled.layer.shadowOffset = CGSize(width: 1, height: 1)
            nameErrorLbl.isHidden = true
            sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            sellerFirmtNameTextFirld.alpha = 0.5
            sellerFirmtNameTextFirld.placeholder = "Seller Firm Name"
            sellerFirmtNameTextFirld.textColor = UIColor(hexString: "5b636a")
            sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            
            
        }else if textField == self.pinCodeTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            pinCodeErrorLbl.isHidden = true
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            pinCodeTxtField.alpha = 0.5
            pinCodeTxtField.placeholder = "PinCode"
            pinCodeTxtField.textColor = UIColor(hexString: "5b636a")
            sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        
                     
                    }else if textField == self.sMobileNumber{
                        //            passwordTxtField.layer.shadowRadius = 1
                        //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
               mobileNumErrorLbl.isHidden = true
               sMobileNumber.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
               sMobileNumber.alpha = 0.5
               sMobileNumber.placeholder = "Mobile Number"
               sMobileNumber.textColor = UIColor(hexString: "5b636a")
               sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
               pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
               pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                    
                                 
            }else if textField == self.sCreatePasswordTextField{
                                    //            passwordTxtField.layer.shadowRadius = 1
                                    //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                PasserrorTxt.textColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
                sCreatePasswordTextField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                sCreatePasswordTextField.alpha = 0.5
                sCreatePasswordTextField.placeholder = "Create Password"
                sCreatePasswordTextField.textColor = UIColor(hexString: "5b636a")
                sellerFirmtNameTextFirld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sMobileNumber.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                
                                             
                                            }
        }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == sellerFirmtNameTextFirld{
            if sellerFirmtNameTextFirld.text!.count > 3 && sellerFirmtNameTextFirld.text!.count <= 16{

              
               pinCodeTxtField.becomeFirstResponder()
            }else{
                
                self.sellerFirmtNameTextFirld.resignFirstResponder()
                nameErrorLbl.isHidden = false
                nameErrorLbl.text = "should contain 4 - 16 character"
//                sellerFirmtNameTextFirld.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
            }
        }
        if textField == pinCodeTxtField {
            if pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 {
                self.sMobileNumber.becomeFirstResponder()
            }else{
                self.pinCodeTxtField.resignFirstResponder()
                pinCodeErrorLbl.isHidden = false
                pinCodeErrorLbl.text = "Please enter the valid pin"
//                pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid password", view: self.view)
            }
        }
        if textField == sMobileNumber{
            if sMobileNumber.text?.count != 0 && sMobileNumber.text?.count == 10{
          
                mobileCheck()
               
            }else{
                self.sMobileNumber.resignFirstResponder()
                mobileNumErrorLbl.isHidden = false
                mobileNumErrorLbl.text = "Please enter the valid number"
//                sMobileNumber.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid number", view: self.view)
            }
        
        }
        if textField == sCreatePasswordTextField {
            if ((sCreatePasswordTextField.text?.isValidPassword(password: sCreatePasswordTextField.text!)) == true){
                sCreatePasswordTextField.resignFirstResponder()
            }else{
                sCreatePasswordTextField.resignFirstResponder()
                PasserrorTxt.textColor = .systemRed
               
//                sCreatePasswordTextField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
            }
             self.sCreatePasswordTextField.resignFirstResponder()
        }

        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         
            return true
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == sellerFirmtNameTextFirld{
           
            if string.rangeOfCharacter(from: .letters) != nil || string == ""{
                
                let maxLength = 16          // set your need
                                          let currentString: NSString = textField.text! as NSString
                                          let newString: NSString =
                                              currentString.replacingCharacters(in: range, with: string) as NSString
                               
                               
                                          return newString.length <= maxLength
                    
                }else {
                    return false
                }
        }
    if textField == pinCodeTxtField{
            let maxLength = 6          // set your need
                       let currentString: NSString = textField.text! as NSString
                       let newString: NSString =
                           currentString.replacingCharacters(in: range, with: string) as NSString
                       return newString.length <= maxLength
        }
    if textField == sMobileNumber{
        if sMobileNumber.text == ""{
            mobileNumErrorLbl.text = "Please enter the valid number"
            mobileNumErrorLbl.isHidden  = true
        }
        if sMobileNumber.text?.checkDataType(text: sMobileNumber.text!) == true{
            let first4 = String(sMobileNumber.text!.prefix(1))
            
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
               
                            if sMobileNumber.text?.count == 9{
                                let json: [String: Any] = ["c_mobile_no": sMobileNumber.text! + string , "c_type":"B-Buyer"]
                                        // create post request
                
                
                                let url = URL(string: baseURL + ApiService.checkMobileUrlStr)
                
                
                                //ApiService.callPost(url: url!, params: json, finish: mobileNumberCheck)
                            }
                       
                
                           return newString.length <= maxLength
            
            }
        }
       
    }
   
    if textField == sCreatePasswordTextField{
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
            case sellerFirmtNameTextFirld :
                if textField  == sellerFirmtNameTextFirld{
                    if sellerFirmtNameTextFirld.text!.count > 3 && sellerFirmtNameTextFirld.text!.count <= 16{
                        let json: [String: Any] = ["c_username": sellerFirmtNameTextFirld.text!]
                                // create post request
                        
                        
                        let url = URL(string: baseURL + ApiService.nameCheck)

                        
                        //ApiService.callPost(url: url!, params: json, finish: mobileNumberCheck)
                        pinCodeTxtField.becomeFirstResponder()
                        
                    }else{
                        self.sellerFirmtNameTextFirld.resignFirstResponder()
                        nameErrorLbl.isHidden = false
                        nameErrorLbl.text = "should contain 4 - 16 character"
//                        sellerFirmtNameTextFirld.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                    }
                }
            
            case self.pinCodeTxtField:
                if pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 {
                    self.sMobileNumber.becomeFirstResponder()
                }else{
                    self.pinCodeTxtField.resignFirstResponder()
                    pinCodeErrorLbl.isHidden = false
                    pinCodeErrorLbl.text = "Please enter the valid pin"
    //                pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
    //                UIView().showToast(message: "Please enter the valid password", view: self.view)
                }
            case self.sMobileNumber:
                if sMobileNumber.text?.count != 0 && sMobileNumber.text?.count == 10{
                  
                        self.sCreatePasswordTextField.becomeFirstResponder()
                    	
                }else{
                    self.sMobileNumber.resignFirstResponder()
                    mobileNumErrorLbl.isHidden = false
                    mobileNumErrorLbl.text = "Please enter the valid number"
    //                mobileNumerTxtField.layer.borderColor = UIColor.red.cgColor
    //                UIView().showToast(message: "Please enter the valid number", view: self.view)
                }
            case self.sCreatePasswordTextField:
                
                     
                      if ((sCreatePasswordTextField.text?.isValidPassword(password: (sCreatePasswordTextField.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                      }else{
                        PasserrorTxt.textColor = .systemRed
//                        passwordTxtField.layer.borderColor = UIColor.red.cgColor
//                          UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
                      }
                self.sCreatePasswordTextField.resignFirstResponder()
            default:
                self.sellerFirmtNameTextFirld .becomeFirstResponder()
            }
        
            return true
   
        }
    
}




extension SignUpTableViewController:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    
    func registerApiCall(){
        //showActivityIndicator(self.view)
        let registerService:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Register")

        let sellerParams = [
            "c_name": sellerFirmtNameTextFirld.text!,
            "c_mobile_no":sMobileNumber.text!,
            "c_pwd": sCreatePasswordTextField.text!,
            "c_pincode": pinCodeTxtField.text!,
            "c_type" : sellerConstantStr
        ]
        
        
        registerService.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REGISTER_URL, type: .post, userData: sellerParams as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.sellerRegisterModel = RegisterLO(object:dict)
            print(dict)
            if boolSuccess {
                if self.sellerRegisterModel?.appStatusCode == 0 {
                    
                    let regiserStatusStr = self.sellerRegisterModel?.messages?[0]
                    if regiserStatusStr == "Registered Successfully!"{
                        UserDefaults.standard.setValue(self.sellerRegisterModel?.payloadJson?.data?.key, forKey: ketConstantStr)
                        UserDefaults.standard.setValue(self.sellerRegisterModel?.payloadJson?.data?.token, forKey: tokenConstantStr)
                        UserDefaults.standard.setValue(self.sellerRegisterModel?.payloadJson?.data?.cType, forKey: typeConstantStr)


                        sendOTP()
                        
                    }else{
                        
                        //do requird function

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
        let urlString = LIVE_ORDER_HOSTURL + OTP_URL + sMobileNumber.text!

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
                                        otpScreenVc.mode = 0
                                        otpScreenVc.mobileStr = self.sMobileNumber.text
                                        otpScreenVc.pincodeStr = self.pinCodeTxtField.text
                                        otpScreenVc.userNameStr = self.sellerFirmtNameTextFirld.text
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
    
    func mobileCheck(){
        let url = LIVE_ORDER_HOSTURL + MOBILE_EXIST_URL
        let params: [String: Any] = ["c_mobile_no": sMobileNumber.text!,"c_type":"B"]
        
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
                                if errormessage == exitUser{
                                   
                                        self.sMobileNumber.resignFirstResponder()
                                    
                                    self.userexist = false
                                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                                     isLoginInt = 1

                                    self.MobileExistsView?.Mobdelegate = self
                                    self.MobileExistsView?.addsellerBtn.setTitle("LogIn", for: .normal)
                                    self.tableView.addSubview(self.MobileExistsView!)
                                    
                                    self.tableView.isScrollEnabled = false
                                        self.mobileNumErrorLbl.isHidden = false
                                        self.mobileNumErrorLbl.text = exitUser
                                 
                                    
                                }else{
                                    self.userexist = true
                                    self.sCreatePasswordTextField.becomeFirstResponder()
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
