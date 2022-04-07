//
//  OtpVC.swift
//  liveOrder
//
//  Created by Data Prime on 02/07/21.
//

import UIKit
import OTPFieldView
import Alamofire
import NotificationBannerSwift

class OtpVC: UIViewController, OTPFieldViewDelegate {
    

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var otpImageView: UIImageView!
    @IBOutlet weak var verifyingTxtLbl: UILabel!
    @IBOutlet weak var hintLbl: UILabel!
    @IBOutlet weak var didnotRecevieTxtLbl: UILabel!
    @IBOutlet weak var reseendBtn: UIButton!
    var mode : Int?
    
    @IBOutlet weak var lOtpTextView: OTPFieldView!
    
   // @IBOutlet weak var otpScrollView: UIScrollView!
    
    var sellerRegiInt : Int?
    var buyerReg : Int?
    var mobileStr : String?
    var userNameStr : String?
    var pincodeStr : String?
    var isBuyerStr : String?
    var combineStore : Int?
    var requestOtpModel : RequestOtpModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOTPView()

      
    }
    
   
    
    func loadOTPView(){
        //otpScrollView.scrollToBottom(animated: true)
        hintLbl.text = "Please wait 5 second we are verifying OTP automatically that we have sent to your mobile number \(mobileStr!)."
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor(hexString: "9b9b9b").cgColor
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        self.lOtpTextView.fieldsCount = 4
                self.lOtpTextView.fieldBorderWidth = 2
               
        self.lOtpTextView.defaultBorderColor = UIColor.black
                self.lOtpTextView.filledBorderColor = UIColor.init(hexString: "9b9b9b")
                self.lOtpTextView.cursorColor = UIColor.black
        self.lOtpTextView.displayType = .roundedCorner
                self.lOtpTextView.fieldBorderWidth = 1.0
                self.lOtpTextView.fieldSize = 40
                self.lOtpTextView.separatorSpace = 12
                self.lOtpTextView.shouldAllowIntermediateEditing = false
                self.lOtpTextView.delegate = self
                self.lOtpTextView.initializeUI()
            let myView = UITapGestureRecognizer(target: self, action: #selector(someAction(_:)))
            self.backView.addGestureRecognizer(myView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
        
    }
    //MARK: - Keyboard Show Hide
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0{
                 // self.view.frame.origin.y -= keyboardSize.height
                backView.isHidden = true
              }
         }
     }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            backView.isHidden = false
//              if self.view.frame.origin.y != 0{
//                  self.view.frame.origin.y += keyboardSize.height
//              }
         }
     }
    //MARK: - BackView
    @objc func someAction(_ sender:UITapGestureRecognizer){
//        if mode == 1 {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerSignupTableViewController") as? BuyerSignupTableViewController
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
//        }else{
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpTableViewController") as? SignUpTableViewController
//            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.pushViewController(vc!, animated: true)
//
//        }
        
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
                    self.navigationController?.navigationBar.isHidden = true
                    self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
    }
    //MARK: - Button Action
    @IBAction func resendBtnact(_ sender: Any) {
        otpsend()
    }
    
    
    //MARK: -  OTP Deloegates
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
   
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
  
             return false
    }
    
    func enteredOTP(otp: String) {
        print("OTPString: \(otp)")
        
        if otp.count == 4{
            if combineStore == 2{
                verifyOtpRequest(requestOtpStr:otp)
            }else{
                verifyOTP(otpStr:otp)
            }
            
            
            
            
//            if self.mode == 1{
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerRegiVC") as? BuyerRegiVC
//            vc?.pincode = self.pincodeStr
//            vc?.mobileNum = self.mobileStr
//            vc?.personName = userNameStr
//
//            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.pushViewController(vc!, animated: true)
//            }else{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpSellerFirmContactRegistration") as? SignUpSellerFirmContactRegistration
//                vc?.userName = self.userNameStr!
//                vc?.pincode = self.pincodeStr
//                vc?.mobile = self.mobileStr
//                self.navigationController?.navigationBar.isHidden = true
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
            
        }else{
            DispatchQueue.main.async {
               
                UIView().showToast(message: "Wrong Otp", view: self.view)
             
            }

    
    }
    
   
    }
    
}
extension OtpVC{
    func verifyOTP(otpStr:String) {
    
            
            let json: [String: Any] = ["OTP": otpStr,
                                       "c_mobile_no": mobileStr ?? "",
                               "n_login": 0]
                          // create post request
                  print(mobileStr)
                  print(json)
        let otpHeader :HTTPHeaders = ["Content-Type":"application/json"]

            AF.request(LIVE_ORDER_HOSTURL + VERIFY_OTP_URL , method: .post, parameters: json, encoding: JSONEncoding.default, headers: otpHeader).responseJSON { response in
                switch response.result {
                                case .success:
                                    print(response)
                                    
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
                                    print(json)
                                        let mess = json.value(forKey: "messages") as? NSArray
                                        print(mess![0])
                                        let mes : String = mess![0] as! String
                                        let sucess = "OTP verified successfully!"
                                        if mes  == sucess{
                                            DispatchQueue.main.async {
                                                if self.combineStore == 1{
                                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ComileModuleListViewController") as? ComileModuleListViewController
                                                    vc?.mobileNumStr = self.mobileStr ?? ""
                                                    self.navigationController?.navigationBar.isHidden = true
                                                    self.navigationController?.pushViewController(vc!, animated: true)
                                                }else{
                                                    if self.mode == 1{
                                                        UIView().showToast(message: mes, view:self.view)
                                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerRegiVC") as? BuyerRegiVC
                                                    vc?.pincode = self.pincodeStr
                                                    vc?.mobileNum = self.mobileStr
                                                        vc?.personName = self.userNameStr

                                                    self.navigationController?.navigationBar.isHidden = true
                                                    self.navigationController?.pushViewController(vc!, animated: true)
                                                    }else{
                                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SellerRegiVc") as? SellerRegiVc
                                                        vc?.pincode = self.pincodeStr
                                                        vc?.mobileNum = self.mobileStr
                                                        vc?.personName = self.userNameStr
                                                        self.navigationController?.navigationBar.isHidden = true
                                                        self.navigationController?.pushViewController(vc!, animated: true)
                                                    }
                                                }
                                               
                                            }
                                            
                                        }else{
                                            DispatchQueue.main.async {
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
    func verifyOtpRequest(requestOtpStr:String) {
    
            
            let json: [String: Any] = ["OTP": requestOtpStr,
                                       "c_mobile_no": mobileStr ?? "",
                               "n_login": 1]
                          // create post request
                  print(mobileStr)
                  print(json)
        let otpHeader :HTTPHeaders = ["Content-Type":"application/json"]

            AF.request(LIVE_ORDER_HOSTURL + VERIFY_OTP_URL , method: .post, parameters: json, encoding: JSONEncoding.default, headers: otpHeader).responseJSON { response in
                switch response.result {
                                case .success:
                                    print(response.data)
                    self.requestOtpModel = RequestOtpModel(object: response.data)
                    print(self.requestOtpModel?.appStatusCode)
                                    do {
//                                        let json = try JSONSerialization.jsonObject(with: response.data!) as!NSDictionary
//
//                                        let appCode = json.value(forKey: "appStatusCode") as? NSInteger
//                                       print(appCode)
                                        if self.requestOtpModel?.appStatusCode == 0{
                                            UserDefaults.standard.setValue(self.requestOtpModel?.payloadJson?.key, forKey: ketConstantStr)
                                            print(ketConstantStr)
                                            UserDefaults.standard.setValue(self.requestOtpModel?.payloadJson?.token, forKey: tokenConstantStr)
                                            UserDefaults.standard.setValue(self.requestOtpModel?.payloadJson?.tokenExpiry, forKey: tokenExpireStr)
                                            UserDefaults.standard.setValue(2, forKey: "data") //setObject
                                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
                                            vc?.loged = 1
                                            self.navigationController?.navigationBar.isHidden = true
                                            self.navigationController?.pushViewController(vc!, animated: true)
                                          
                                       
                                        }else{
                                            let banner = NotificationBanner(title: "Message", subtitle: self.requestOtpModel?.messages?[0], style: .info)
                                            banner.showToast(message: self.requestOtpModel?.messages?[0] ?? "", view: self.view)
                                        }
                                        
                                    }catch{
                                        
                                    }
                                    break
                                case .failure(let error):

                                    print(error)
                                }
            }
    }
    func otpsend(){
        let urlString = "https://dev-lc.livc.in/lc/ms/c2/otp/send/" + mobileStr!

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
                                        
                                        UIView().showToast(message:errormessage , view: self.view)
                                    
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
   
}
