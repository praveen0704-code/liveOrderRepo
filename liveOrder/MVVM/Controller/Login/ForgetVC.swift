//
//  ForgetVC.swift
//  liveOrder
//
//  Created by Data Prime on 01/07/21.
//

import UIKit
import Alamofire

class ForgetVC: UIViewController {

    @IBOutlet weak var mobileNumTxtView: DesignableUITextField!
    @IBOutlet weak var otpTxtView: DesignableUITextField!
    @IBOutlet weak var passWordTxtView: DesignableUITextField!
    @IBOutlet weak var SigninBtn: UIButton!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var mobileNumErrorLbl: UILabel!
    @IBOutlet weak var otpErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    
    @IBOutlet weak var mobileHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var otpHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var resendTimeLabel: UILabel!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var OtpDoneLbl: UILabel!
    
    var mobiletxt : String?
    var resenndTimer:Timer?
    var resendCountDownInt = 90
    var generateOtpCountInt = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        mobileNumTxtView.text = mobiletxt
        otpsend()
        
    }
    func setup(){
        SigninBtn.setTitle("SUBMIT", for: .normal)
        OtpDoneLbl.isHidden = true
        passWordTxtView.isUserInteractionEnabled = false
        mobileNumErrorLbl.isHidden = true
        otpErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        
        mobileNumTxtView.delegate = self
        otpTxtView.delegate = self
        passWordTxtView.delegate = self
        SigninBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        let otpResend =  UIButton()
        otpResend.setTitle("Resend OTP?", for: .normal)
        otpResend.setTitleColor(UIColor.init(hexString: "#674CF3"), for: .normal)
        otpResend.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        otpResend.frame = CGRect(x:0 , y: 9, width:  80, height: 16)
        otpResend.addTarget(self, action: #selector(resendOtp), for: .touchUpInside)
        let viewss = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 30))
        
        viewss.addSubview(otpResend)
        mobileNumTxtView.rightView = viewss
        mobileNumTxtView.translatesAutoresizingMaskIntoConstraints = false
        mobileNumTxtView.rightViewMode = .always
        mobileNumTxtView.rightView?.isHidden = true
        
        
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 0, width: CGFloat(60), height: CGFloat(60)))
                
            passwordButton.contentMode = .scaleAspectFill
            
            passwordButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            
            passwordButton.addTarget(self, action: #selector(passViewTap), for: .touchUpInside)
            let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        
        views.addSubview(passwordButton)
        passWordTxtView.rightView = views
        passWordTxtView.translatesAutoresizingMaskIntoConstraints = false
        passWordTxtView.rightViewMode = .always
        
        mobileHeightConstrains.constant = 0.0
        mobileNumErrorLbl.layoutIfNeeded()
        otpHeightConstrains.constant = 0.0
        otpErrorLbl.layoutIfNeeded()
        
        //put this wnem resend button action
        self.resenndTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        
        
    }
    @objc  func passViewTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    
    if sender.isSelected{
        passwordImageView.image = UIImage(named: "eye")

    }else{
        passwordImageView.image = UIImage(named: "eyeclosed")

    }
    
    passWordTxtView.isSecureTextEntry = !sender.isSelected
    
          }
    @objc  func resendOtp(sender: UIButton) {
        self.resenndTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        resendCountDownInt = 90
        print(resendCountDownInt)
        if mobileNumTxtView.text?.count == 10{
            otpsend()
        }else{
            mobileNumErrorLbl.isHidden = false
            mobileNumErrorLbl.text = "Enter Valid Number"
            mobileHeightConstrains.constant = 11.0
            mobileNumErrorLbl.layoutIfNeeded()
        }
      
        
          }
    //MARK: - TimerUpdate
    @objc func updateCounter() {
        //example functionality
        if generateOtpCountInt > 0{
            generateOtpCountInt -= 1
            
        }
        if resendCountDownInt > 0 {
            print("\(resendCountDownInt) seconds to the end of the world")
            resendCountDownInt -= 1
            self.resendTimeLabel.text = timeFormatted(resendCountDownInt)
            mobileNumTxtView.rightView?.isHidden = true
            resendTimeLabel.isHidden = false
            
        }else{
            print("hit")
            self.resenndTimer?.invalidate()
            mobileNumTxtView.rightView?.isHidden = false
            resendTimeLabel.isHidden = true
            //hit api
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func backBtnAct(_ sender: Any) {
        mobiletxt = ""
        self.resenndTimer?.invalidate()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func signInBtnAct(_ sender: Any) {
        if mobileNumTxtView.text?.count != 0 && mobileNumTxtView.text?.count == 10 && otpTxtView.text?.count != 0 && otpTxtView.text!.count >= 4 && passWordTxtView.text?.count != 0 && ((passWordTxtView.text?.isValidPassword(password: (passWordTxtView.text?.trimmingCharacters(in: .whitespaces))!)) == true){
            passwordUpdate()
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
//            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.pushViewController(vc!, animated: true)
           
        }else if mobileNumTxtView.text?.count == 0 && mobileNumTxtView.text?.count != 10 {
            mobileNumTxtView.layer.borderColor = UIColor.red.cgColor
            mobileNumErrorLbl.text = "Please enter the valid mobile"
            mobileNumErrorLbl.isHidden = false
            //mobileNumTxtView.placeholder = "    Please enter the valid mobile"
            passWordTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            otpTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }else if otpTxtView.text?.count == 0 && otpTxtView.text!.count < 3{
            
            otpTxtView.layer.borderColor = UIColor.red.cgColor
            otpErrorLbl.text = "please enter the valid otp"
            otpErrorLbl.isHidden = false
            //otpTxtView.placeholder = "   please enter the valid otp"
            passWordTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileNumTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }else if passWordTxtView.text?.count == 0 && ((passWordTxtView.text?.isValidPassword(password: (passWordTxtView.text?.trimmingCharacters(in: .whitespaces))!)) == false) {
            
            passWordTxtView.layer.borderColor = UIColor.red.cgColor
            passwordErrorLbl.text = "please enter the valid password"
            passwordErrorLbl.isHidden = false
           // passWordTxtView.placeholder = "   please enter the valid password"
            otpTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileNumTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }
        
      
    }
//    func mobileNumberCheck (message:String, data:Data?) -> Void
//    {
//        do
//        {
//            if let jsonData = data
//            {
//                let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary
//                print(json)
//                let payload =  json?.value(forKey: "payloadJson") as! [String]
//                print(payload)
//                
//                let record = ["Record not found"]
//  
//                let message =  json?.value(forKey: "messages") as! [String]
//                print(message)
//                
//                if message == record{
//                    
//                }else{
//                   
//                }
//                
////                    DispatchQueue.main.async { [self] in
////
////                        let alert = UIAlertController(title: "Alert", message: message[0], preferredStyle: UIAlertController.Style.alert)
////                        alert.addAction(UIAlertAction(title: "Ok" , style: UIAlertAction.Style.default, handler: nil))
////                        self.present(alert, animated: true, completion: nil)
////
////
////                }
////
//            }
//        }
//        catch
//        {
//            print("Parse Error: \(error)")
//        }
//    }
    
}



extension ForgetVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.mobileNumTxtView{
            
            OtpDoneLbl.isHidden = true
//            userNameTxtfiled.layer.shadowRadius = 1
//            userNameTxtfiled.layer.shadowOffset = CGSize(width: 1, height: 1)
            mobileNumTxtView.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            mobileNumTxtView.placeholder = "Mobile Number"
            mobileNumTxtView.textColor = UIColor(hexString: "5b636a")
            mobileNumErrorLbl.isHidden = true
            passWordTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            otpTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            
            
        }else if textField == self.otpTxtView{
            OtpDoneLbl.isHidden = true
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            otpTxtView.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            otpTxtView.placeholder = "Enter OTP"
            otpTxtView.textColor = UIColor(hexString: "5b636a")
            otpErrorLbl.isHidden = true
            mobileNumTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            passWordTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
           
                        
                     
      }else if textField == self.passWordTxtView{
          self.OtpDoneLbl.isHidden = true
                        //            passwordTxtField.layer.shadowRadius = 1
                        //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            passWordTxtView.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            passWordTxtView.placeholder = "Create New Password"
            passWordTxtView.textColor = UIColor(hexString: "5b636a")
            passwordErrorLbl.isHidden = true
            mobileNumTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            otpTxtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        
                                    
                                 
            }
        }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileNumTxtView{
            if mobileNumTxtView.text?.count != 0 && mobileNumTxtView.text?.count == 10{
                
                mobileHeightConstrains.constant = 0.0
                mobileNumErrorLbl.layoutIfNeeded()
                
                mobileNumTxtView.resignFirstResponder()
                otpsend()
                
                
                
            }else{
                self.mobileNumTxtView.resignFirstResponder()
                mobileNumTxtView.layer.borderColor = UIColor.red.cgColor
                mobileHeightConstrains.constant = 11.0
                mobileNumErrorLbl.layoutIfNeeded()
                mobileNumErrorLbl.text = "Please enter the valid number"
                mobileNumErrorLbl.isHidden = false
               // UIView().showToast(message: "Please enter the valid number", view: self.view)
            }
        }
        if textField == otpTxtView {
            if otpTxtView.text?.count != 0 && otpTxtView.text!.count == 4 {
                otpHeightConstrains.constant = 0.0
                otpErrorLbl.layoutIfNeeded()
                self.passWordTxtView.becomeFirstResponder()
            }else{
                self.otpTxtView.resignFirstResponder()
                otpTxtView.layer.borderColor = UIColor.red.cgColor
                otpHeightConstrains.constant = 11.0
                otpErrorLbl.layoutIfNeeded()
                otpErrorLbl.text = "Please enter the valid otp"
                otpErrorLbl.isHidden = false
                //UIView().showToast(message: "Please enter the valid otp", view: self.view)
            }
        }
        
        if textField == passWordTxtView {
            if ((passWordTxtView.text?.isValidPassword(password: passWordTxtView.text!)) == true){
            }else{
              passWordTxtView.layer.borderColor = UIColor.red.cgColor
                passwordErrorLbl.text = "Password should contain 4 - 16 character & should contain alphanumeric and special character"
                passwordErrorLbl.isHidden = false
              //  UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
            }
             self.mobileNumTxtView.resignFirstResponder()
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
           
            
        if textField == mobileNumTxtView{
            mobileHeightConstrains.constant = 0.0
            mobileNumErrorLbl.layoutIfNeeded()
            if mobileNumTxtView.text == ""{
                mobileNumErrorLbl.text = "Please enter the valid number"
                mobileNumErrorLbl.isHidden = false
               // UIView().showToast(message:  "Please enter the valid number", view: self.view)
                
            }
            if mobileNumTxtView.text?.checkDataType(text: mobileNumTxtView.text!) == true{
                let first4 = String(mobileNumTxtView.text!.prefix(1))
                
                var a:Int? = Int(first4)
                if  (1...5).contains(a!) == true{
                    let MAX_LENGTH = 4
                            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                     mobileNumErrorLbl.text = "Please enter the valid number"
                     mobileNumErrorLbl.isHidden = false
                            return updatedString.count <= MAX_LENGTH
                    
                
                }else{
                    let maxLength = 10          // set your need
                               let currentString: NSString = textField.text! as NSString
                               let newString: NSString =
                                   currentString.replacingCharacters(in: range, with: string) as NSString
                    
                               mobileNumErrorLbl.isHidden = true
                               return newString.length <= maxLength
                
                }
                
            }
           
        
       
        }
        if textField == otpTxtView{
           
            if otpTxtView.text?.count == 3{
                OtpDoneLbl.isHidden = true
                if (otpTxtView.text! + string).count == 4{
                    otpTxtView.text = otpTxtView.text! + string
                    verifyOTP(otpStr: otpTxtView.text!, mobNum: mobileNumTxtView.text!)
                }
            }
            let maxLength = 4          // set your need
                       let currentString: NSString = textField.text! as NSString
                       let newString: NSString =
                           currentString.replacingCharacters(in: range, with: string) as NSString
                       return newString.length <= maxLength
           
            
        }
        
            
            return true
            
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          
            switch textField{
            case mobileNumTxtView :
                if textField  == mobileNumTxtView{
                    if mobileNumTxtView.text?.count != 0 && mobileNumTxtView.text?.count == 10{
                        
                        mobileHeightConstrains.constant = 0.0
                        mobileNumErrorLbl.layoutIfNeeded()
                    }else{
                        self.mobileNumTxtView.resignFirstResponder()
                        mobileHeightConstrains.constant = 11.0
                        mobileNumErrorLbl.layoutIfNeeded()
                        mobileNumTxtView.layer.borderColor = UIColor.red.cgColor
                        mobileNumErrorLbl.text = "Please enter the valid number"
                        mobileNumErrorLbl.isHidden = false
                        //UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                    }
                }
            case self.otpTxtView:
                if otpTxtView.text?.count != 0 && otpTxtView.text!.count == 4{
                    otpHeightConstrains.constant = 0.0
                    otpErrorLbl.layoutIfNeeded()
                }else{
                    self.otpTxtView.resignFirstResponder()
                    otpTxtView.layer.borderColor = UIColor.red.cgColor
                    otpHeightConstrains.constant = 11.0
                    otpErrorLbl.layoutIfNeeded()
                    otpErrorLbl.text = "Please enter the valid otp"
                    otpErrorLbl.isHidden = false
                    //UIView().showToast(message: "invalid OTP", view: self.view)
                }
            
            case self.passWordTxtView:
                
                     
                      if ((passWordTxtView.text?.isValidPassword(password: (passWordTxtView.text?.trimmingCharacters(in: .whitespaces))!)) == true){
                      }else{
                        passWordTxtView.layer.borderColor = UIColor.red.cgColor
                        passwordErrorLbl.text = "Password should contain 4 - 16 character & should contain alphanumeric and special character"
                        passwordErrorLbl.isHidden = false
                          //UIView().showToast(message: "Password should contain 4 - 16 character & should contain alphanumeric and special character", view: self.view)
                      }
                self.passWordTxtView.resignFirstResponder()
            default:
                self.mobileNumTxtView.becomeFirstResponder()
            }
            return true
   
        }
    func otpsend(){
        let urlString = LIVE_ORDER_HOSTURL + OTP_SEND_URL + mobileNumTxtView.text!

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
                                        mobileNumTxtView.resignFirstResponder()
                                        UIView().showToast(message:errormessage , view: self.view)
                                       
                                                                   }
                                }else{
                                    DispatchQueue.main.async {
                                        self.mobileNumTxtView.resignFirstResponder()
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
    func verifyOTP(otpStr:String,mobNum : String) {
    
        let activity_view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activity_view.frame =  CGRect(x: 5, y: 7, width: 40.0,height: 40.0)
        
        self.view.addSubview(activity_view)
        activity_view.bringSubviewToFront(self.view)
       // activity_view.startAnimating()
        
        otpTxtView.rightViewMode = .always
        let rview = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        rview.addSubview(activity_view)
        otpTxtView.rightView = rview
        activity_view.startAnimating()
            let json: [String: Any] = ["OTP": otpStr,
                               "c_mobile_no": mobNum,
                               "n_login": 0]
                          // create post request
                  
                  

            AF.request(LIVE_ORDER_HOSTURL + VERIFY_OTP_URL , method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                switch response.result {
                                case .success:
                                    print(response)
                                    
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
                                    print(json)
                                        let mess = json.value(forKey: "messages") as? NSArray
                                        print(mess![0])
                                        let mes : String = mess![0] as! String
                                        activity_view.stopAnimating()
                                        let sucess = "OTP verified successfully!"
                                        if mes  == sucess{
                                            DispatchQueue.main.async {
                                                self.OtpDoneLbl.isHidden = false
                                                self.OtpDoneLbl.text = "    Done"
                                                self.otpTxtView.isUserInteractionEnabled = false
                                                self.passWordTxtView.isUserInteractionEnabled = true
                                                self.passWordTxtView.becomeFirstResponder()
                                            }
                                            
                                        }else{
                                            DispatchQueue.main.async {
                                                activity_view.stopAnimating()
                                                self.OtpDoneLbl.isHidden = false
                                                self.OtpDoneLbl.text = "Not Match"
                                                UIView().showToast(message: mes, view:self.view)
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
    
    
    func passwordUpdate(){
        let urlString = LIVE_ORDER_HOSTURL + FORGET_PASSWORD_URL
        let json: [String: Any] = ["c_mobile_no":mobileNumTxtView.text ?? "",
                                   "c_new_pwd":passWordTxtView.text ?? "",
                                   "c_type":"B"]
        AF.request(urlString, method: .post,parameters: json ,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
          switch response.result {
                        case .success:
                            print(response)
                           do {
                                let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
                                print(json)
                               
                                
                                let mage = json.value(forKey: "messages") as? NSArray
                               print(mage)
                               let statusCode = json.value(forKey: "appStatusCode") as? NSInteger
                                print(statusCode)
                               if statusCode == 0{
                                   
                                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
                                   vc?.forget = 1
                                   vc?.message = mage as? [String]
                                         self.navigationController?.navigationBar.isHidden = true
                                         self.navigationController?.pushViewController(vc!, animated: true)
                               }else{
                                   UIView().showToast(message: mage![0] as! String, view: self.view)
                               }
                                
                           }catch{
                            
                           }
                            break
                        case .failure(let error):

                            print(error)
                        }
        }
    }
}
