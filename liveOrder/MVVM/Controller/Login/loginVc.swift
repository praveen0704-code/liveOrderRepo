//
//  loginVc.swift
//  liveOrder
//
//  Created by Data Prime on 30/06/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift

class loginVc: UIViewController {
    
    @IBOutlet weak var userNameTxtfiled: DesignableUITextField!
    @IBOutlet weak var passwordTxtField: DesignableUITextField!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var getstartBtn: UIButton!
    
    @IBOutlet weak var userNameErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var responseErrorLbl: UILabel!
   
    @IBOutlet weak var userNameErrorLabelHeightConsraint: NSLayoutConstraint!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var passErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var requstOtpBtn: UIButton!
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var loginModelClass : LoginModel?
    var mobileCheckModel : MobileCheckModel?
    var message : [String]?
    var forget = 0
    var numberCheck = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        if forget == 1{
            UIView().showToast(message: message?[0] ?? "", view: self.view)
        }
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
    }
    
    
    func setup(){
        passErrorHeight.constant = 0.0
        passwordErrorLbl.layoutIfNeeded()
        
       // forgetBtn.isUserInteractionEnabled = false
        UserDefaults.standard.setValue(1, forKey: "data") //setObject
        responseErrorLbl.isHidden = true
        userNameErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        self.signinBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        userNameTxtfiled.delegate = self
        passwordTxtField.delegate = self
        
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 0, width: CGFloat(60), height: CGFloat(60)))
        
        passwordButton.contentMode = .scaleAspectFill
        
        passwordButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        passwordButton.addTarget(self, action: #selector(passViewTap), for: .touchUpInside)
        let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        
        views.addSubview(passwordButton)
        passwordTxtField.rightView = views
        
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.rightViewMode = .always
        //Dev
//        self.userNameTxtfiled.text = "7899899878"
//      self.passwordTxtField.text = "Password@123"

        //uat
//        self.userNameTxtfiled.text = "9702661777"
//      self.passwordTxtField.text = "Password@123"
//        self.userNameTxtfiled.text = "8870847064"
//      self.passwordTxtField.text = "Data123@"

//        self.userNameTxtfiled.text = "8970780086"
//        self.passwordTxtField.text = "Password@123"
        

        
        userNameErrorLabelHeightConsraint.constant = 0.0
        userNameErrorLbl.layoutIfNeeded()
        
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
    
    
    
    
    @IBAction func requestOtpBtnAct(_ sender: Any) {
        if userNameTxtfiled.text?.count == 10{
            if numberCheck == 1{
                sendOTP()
            }else{
                userNameTxtfiled.resignFirstResponder()
                passwordTxtField.resignFirstResponder()
                self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                isLoginInt = 1
                self.MobileExistsView?.Mobdelegate = self
                self.MobileExistsView?.addsellerBtn.setTitle("Register", for: .normal)
                self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
                let colorString = "Mobile Number "
                self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is not registered with us. Click below to Register"
                self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
                self.view.addSubview(self.MobileExistsView!)
            }
    
        }else{
            userNameErrorLbl.text = "Enter the valid Number"
            userNameErrorLbl.isHidden = false
            userNameErrorLabelHeightConsraint.constant = 11.0
            userNameErrorLbl.layoutIfNeeded()
            
        }
    }
    
    
    @IBAction func forgetBtnAct(_ sender: Any) {
        
        if userNameTxtfiled.text?.count == 10{
            if numberCheck == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgetVC") as? ForgetVC
                vc?.mobiletxt = userNameTxtfiled.text
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                userNameTxtfiled.resignFirstResponder()
                passwordTxtField.resignFirstResponder()
                self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                isLoginInt = 1

                self.MobileExistsView?.Mobdelegate = self
                self.MobileExistsView?.addsellerBtn.setTitle("Register", for: .normal)
                self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
                let colorString = "Mobile Number "
                self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is not registered with us. Click below to Register"
                self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
                self.view.addSubview(self.MobileExistsView!)
            }
    
        }else{
            userNameErrorLbl.text = "Enter the valid Number"
            userNameErrorLbl.isHidden = false
            userNameErrorLabelHeightConsraint.constant = 11.0
            userNameErrorLbl.layoutIfNeeded()
            
        }
        
    }
    @IBAction func signinBtnAct(_ sender: Any) {
        if userNameTxtfiled.text!.count >= 4 && ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true) {
            
            loginApiCall()
            
            
        }
        else if userNameTxtfiled.text?.count == 0 {
            userNameTxtfiled.layer.borderColor = UIColor.red.cgColor
            userNameTxtfiled.placeholder = "Username"
            //passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }else if passwordTxtField.text?.count == 0 {
            passwordErrorLbl.isHidden = false
            passErrorHeight.constant = 31
            passwordErrorLbl.layoutIfNeeded()
            //userNameTxtfiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }
        
        
    }
    //    func finishPost (message:String, data:Data?) -> Void
    //        {
    //            do
    //            {
    //                if let jsonData = data
    //                {
    //                    let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary
    //
    //                    let jsonDict = json?.value(forKey: "payloadJson") as? NSArray
    //                    let mage = json?.value(forKey: "messages") as? NSArray
    //                    let errormessage = mage![0]
    //                    print(mage![0])
    //                    print(mage)
    //                    if jsonDict?.count != 0 {
    //
    //                        UserDefaults.standard.setValue(jsonDict?[0] as! NSDictionary, forKey: "LoginKeypayloadJson")
    //
    //                        print(UserDefaults.standard.value(forKey: "LoginKeypayloadJson"))
    //
    //                        DispatchQueue.main.async {
    //                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BubbleTabBarController") as? BubbleTabBarController
    //                            self.navigationController?.navigationBar.isHidden = true
    //                            self.navigationController?.pushViewController(vc!, animated: true)
    //                        }
    //
    //
    //
    //                    }else{
    //                        DispatchQueue.main.async {
    //                            print("no data")
    //                            self.responseErrorLbl.isHidden = false
    //                            self.responseErrorLbl.text = (errormessage as! String)
    //                        }
    //
    //                    }
    //                }
    //            }
    //            catch
    //            {
    //                print("Parse Error: \(error)")
    //            }
    //
    //    }
    
    @IBAction func getStartBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerSignupTableViewController") as? BuyerSignupTableViewController
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension loginVc : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.userNameTxtfiled{
            
            
            userNameTxtfiled.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            userNameTxtfiled.placeholder = "Mobile Number"
            userNameTxtfiled.textColor = UIColor(hexString: "5b636a")
            passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            userNameErrorLbl.isHidden = true
            userNameErrorLabelHeightConsraint.constant = 0.0
            userNameErrorLbl.layoutIfNeeded()
            responseErrorLbl.isHidden = true
            
        }else if textField == self.passwordTxtField{
            passwordErrorLbl.isHidden = true
            passErrorHeight.constant = 0.0
            passwordErrorLbl.layoutIfNeeded()
            if userNameTxtfiled.text!.count < 10{
                self.userNameTxtfiled.resignFirstResponder()
                userNameTxtfiled.placeholder = "Mobile Number"
                userNameErrorLabelHeightConsraint.constant = 11.0
                userNameErrorLbl.layoutIfNeeded()
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                userNameErrorLbl.text = "Please enter valid mobile number"
                userNameErrorLbl.isHidden = false
                responseErrorLbl.isHidden = true
                
            }else {
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                userNameErrorLabelHeightConsraint.constant = 0.0
                userNameErrorLbl.layoutIfNeeded()
                passwordTxtField.placeholder = "Password"
                
                passwordTxtField.textColor = UIColor(hexString: "5b636a")
                userNameTxtfiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                self.passwordTxtField.becomeFirstResponder()
                
            }
            
            
            
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == userNameTxtfiled{
            if userNameTxtfiled.text!.count < 10{
                UserDefaults.standard.setValue(self.userNameTxtfiled.text ?? "", forKey:usernameConstantStr)

                self.userNameTxtfiled.resignFirstResponder()
                // userNameTxtfiled.layer.borderColor = UIColor.red.cgColor
                
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                userNameErrorLbl.text = "Please enter valid mobile number"
                userNameErrorLbl.isHidden = false
                
            }else {
                self.passwordTxtField.becomeFirstResponder()
            }
        }
        
        if textField == passwordTxtField {
            if  ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                self.passwordTxtField.resignFirstResponder()
                passwordErrorLbl.isHidden = true
                passErrorHeight.constant = 0.0
                passwordErrorLbl.layoutIfNeeded()
            }else{
                //  passwordTxtField.layer.borderColor = UIColor.red.cgColor
                passwordErrorLbl.isHidden = false
                passErrorHeight.constant = 31
                passwordErrorLbl.layoutIfNeeded()
                passwordErrorLbl.text = "Password should contain 4 - 16 character & alphanumeric and special character"
               
                self.passwordTxtField.resignFirstResponder()
            }
        }
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == userNameTxtfiled{
            userNameErrorLabelHeightConsraint.constant = 0.0
            userNameErrorLbl.layoutIfNeeded()
            let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789")
               let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
               if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
                   return false
               }
            if userNameTxtfiled.text?.checkDataType(text: userNameTxtfiled.text!) == true{
                
                if userNameTxtfiled.text?.count == 9 {
                    print(userNameTxtfiled.text! + string)
                    let text = userNameTxtfiled.text! + string
                    if text.count == 10{
                        mobilecheckApi(number: text)
                    }
                   
                }
                let first4 = String(userNameTxtfiled.text!.prefix(1))
                
                var a:Int? = Int(first4)
                if  (1...5).contains(a!) == true{
                   
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
            
            let maxLength = 16          // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            
            return newString.length <= maxLength
        }
        if textField == passwordTxtField{
            let maxLength = 16          // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        switch textField {
            
        case self.userNameTxtfiled:
            
            if userNameTxtfiled.text!.count < 4{
                self.userNameTxtfiled.resignFirstResponder()
                // userNameTxtfiled.layer.borderColor = UIColor.red.cgColor
                userNameTxtfiled.placeholder = "Username"
                passwordTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                userNameErrorLbl.text = "Please enter valid mobile number"
                userNameErrorLbl.isHidden = false
                
                
                
            }else {
                self.passwordTxtField.becomeFirstResponder()
            }
            
            
            
        case self.passwordTxtField:
            
            
            if ((passwordTxtField.text?.isValidPassword(password: (passwordTxtField.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                self.passwordTxtField.resignFirstResponder()
                passwordErrorLbl.isHidden = true
                passErrorHeight.constant = 0.0
                passwordErrorLbl.layoutIfNeeded()
            }else{
                //  passwordTxtField.layer.borderColor = UIColor.red.cgColor
                
                passErrorHeight.constant = 31
                passwordErrorLbl.layoutIfNeeded()
                passwordErrorLbl.text = "Password should contain 4 - 16 character & alphanumeric and special character"
                passwordErrorLbl.isHidden = false
            }
            self.passwordTxtField.resignFirstResponder()
            
        default:
            self.userNameTxtfiled.resignFirstResponder()
        }
        
        return true
        
    }
    
    
}
extension loginVc : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerSignupTableViewController") as? BuyerSignupTableViewController
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    
}
//MARK: - Login Api
extension loginVc:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
        
    }
    func mobilecheckApi(number: String){
        UserDefaults.standard.setValue(number, forKey:usernameConstantStr)

        let activity_view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activity_view.frame =  CGRect(x: 5, y: 7, width: 40.0,height: 40.0)
        
        self.view.addSubview(activity_view)
        activity_view.bringSubviewToFront(self.view)
        // activity_view.startAnimating()
        
        userNameTxtfiled.rightViewMode = .always
        let rview = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        rview.addSubview(activity_view)
        userNameTxtfiled.rightView = rview
        activity_view.startAnimating()
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        let mobilecheckParam = [ "c_mobile_no" : number]

        
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+MOBILE_EXIST_URL, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            mobileCheckModel = MobileCheckModel(object: dict)
            print(dict)
            
            if boolSuccess {
                if self.mobileCheckModel?.appStatusCode == 2 {
                    
                    activity_view.stopAnimating()
                    print(mobileCheckModel?.payloadJson?.data?.count ?? 0)
                    
                    if mobileCheckModel?.messages?[0] == "Mobile Number exist in LC1"{
                        
                        sendOTP()
                        
                    }else if mobileCheckModel?.messages?[0] == "Already registered!"{
                        numberCheck = 1
                        
                        forgetBtn.isUserInteractionEnabled = true
                        
                    }else{
                       
                    }
                    
                }else if self.mobileCheckModel?.appStatusCode == 5{
                    activity_view.stopAnimating()
                    userNameTxtfiled.resignFirstResponder()
                    passwordTxtField.resignFirstResponder()
                    isLoginInt = 1
                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                   
                    self.MobileExistsView?.Mobdelegate = self
                    self.MobileExistsView?.addsellerBtn.setTitle("Register", for: .normal)
                    self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
                    let colorString = "Mobile Number "
                    self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is not registered with us. Click below to Register"
                    self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
                    self.view.addSubview(self.MobileExistsView!)
                    numberCheck = 0
                   
                }
                else
                {
                    activity_view.stopAnimating()
                    let banner = NotificationBanner(title: "Message", subtitle: self.mobileCheckModel?.messages?[0], style: .info)
                    banner.showToast(message: self.mobileCheckModel?.messages?[0] ?? "", view: self.view)
                    
                    
                  
                }
            }
            else
            {
                activity_view.stopAnimating()
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            activity_view.stopAnimating()
        })
    }
    //FIXME: - Send OTP
    
    func sendOTP(){
        let urlString = LIVE_ORDER_HOSTURL + OTP_URL + userNameTxtfiled.text!
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

                                        
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtpVC") as? OtpVC
                                        vc?.mobileStr = userNameTxtfiled.text
                                        if numberCheck == 1 {
                                            vc?.combineStore = 2
                                        }else{
                                            vc?.combineStore = 1
                                        }
                                        
                                        self.navigationController?.navigationBar.isHidden = true
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    
                     
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
    func loginApiCall(){
        //showActivityIndicator(self.view)
        let signInService:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        let dictionarySignUpRequest = ["c_mobile_no" :self.userNameTxtfiled.text!,
                                       "c_pwd" : self.passwordTxtField.text!
        ]
        
        
        signInService.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+LOGIN_URL, type: .post, userData: dictionarySignUpRequest as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.loginModelClass = LoginModel(object:dict)
            print(dict)
            print(self.loginModelClass?.appStatusCode)
            if boolSuccess {
                if self.loginModelClass?.appStatusCode == 0 {
                    
                  
                    if loginModelClass?.payloadJson?.data?.cLcUserStatus == "1" {
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.key, forKey: ketConstantStr)
                        print(ketConstantStr)
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.token, forKey: tokenConstantStr)
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.cType, forKey: typeConstantStr)
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ComileModuleListViewController") as? ComileModuleListViewController
                        vc?.mobileNumStr = userNameTxtfiled.text ?? ""
                        vc?.vcViewed = true
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }else{
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.key, forKey: ketConstantStr)
                        print(ketConstantStr)
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.token, forKey: tokenConstantStr)
                        UserDefaults.standard.setValue(self.loginModelClass?.payloadJson?.data?.cType, forKey: typeConstantStr)
                        
                        UserDefaults.standard.setValue(self.userNameTxtfiled.text ?? "", forKey:usernameConstantStr)
    //                    UserDefaults.standard.removeObject(forKey: "data")
                        UserDefaults.standard.setValue(2, forKey: "data") //setObject
                        
                        if #available(iOS 13.0, *) {
                            let landingVc = self.storyboard?.instantiateViewController(identifier: "LoHomeViewController") as! LoHomeViewController
                            self.navigationController?.pushViewController(landingVc, animated: true)
                            
                        } else {
                          
                            
                        }
                    }
                    
                 
                }
                else
                {
//                    let banner = NotificationBanner(title: "Message", subtitle: self.loginModelClass?.messages?[0], style: .info)
//                    banner.showToast(message: self.loginModelClass?.messages?[0] ?? "", view: self.view)
                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                   
                    self.MobileExistsView?.Mobdelegate = self
                    self.MobileExistsView?.addsellerBtn.setTitle("Message", for: .normal)
                    self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
                    let colorString = "Mobile Number "
                    if self.loginModelClass?.messages?[0] != nil{
                        self.MobileExistsView?.txtLbl.text = self.loginModelClass?.messages?[0]
                        self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
                        isLoginInt = 0
                        self.view.addSubview(self.MobileExistsView!)

                    }else{
                        self.MobileExistsView?.txtLbl.text = "Somethig went wrong"
                        self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
                        isLoginInt = 0
                        self.view.addSubview(self.MobileExistsView!)

                    }
                }
            }
            else
            {
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 0
            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Message", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Something went wrong"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })
        
        
        
        
    }
}

extension UIButton {
    
    func setImage(image: UIImage?, inFrame frame: CGRect?, forState state: UIControl.State){
        self.setImage(image, for: state)
        
        if let frame = frame{
            self.imageEdgeInsets = UIEdgeInsets(
                top: frame.minY - self.frame.minY,
                left: frame.minX - self.frame.minX,
                bottom: self.frame.maxY - frame.maxY,
                right: self.frame.maxX - frame.maxX
            )
        }
    }
    
}
