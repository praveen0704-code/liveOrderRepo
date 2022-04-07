//
//  SignUpSellerFirmContactRegistration.swift
//  liveOrder
//
//  Created by Data Prime on 08/07/21.
//

import UIKit
import Alamofire
import iOSDropDown


class SignUpSellerFirmContactRegistration: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var desFillLbl: UILabel!
    @IBOutlet weak var firmContactsLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollOverView: UIView!
    @IBOutlet weak var personNameTxtField: DesignableUITextField!
    @IBOutlet weak var emailTxtField: DesignableUITextField!
    @IBOutlet weak var addressOneTxtField: DesignableUITextField!
    @IBOutlet weak var addressTwoTxtField: DesignableUITextField!
    @IBOutlet weak var pinCodeTxtField: DesignableUITextField!
    @IBOutlet weak var stateTxtField: DesignableUITextField!
    @IBOutlet weak var cityTxtField: DesignableUITextField!
    @IBOutlet weak var areaTxtField: DesignableUITextField!
    @IBOutlet weak var nxtBtnNumberLbl: UILabel!
    @IBOutlet weak var nextBtnRountDotLbl: UILabel!
    @IBOutlet weak var nextTxtLbl: UILabel!
    @IBOutlet weak var nxtBtnRoundDotTwoLbl: UILabel!
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var areaDropDown: DropDown!
    @IBOutlet weak var contactErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var addressTwoErrOrLbl: UILabel!
    @IBOutlet weak var addressOneErrorLbl: UILabel!
    @IBOutlet weak var pinCodeErrorLbl: UILabel!
    @IBOutlet weak var stateErrorLbl: UILabel!
    @IBOutlet weak var cityErrorLbl: UILabel!
    @IBOutlet weak var areaErrorrLbl: UILabel!
    
    var stateArray : [Stateclass] = []
    var citys : [cityClass] = []
    var areaArray : [Areaclass] = []
    var pincode : String?
    var userName : String?
    var mobile : String?
    var selectedCityCode : String?
    var selectedAreaCode : String?
    var selectedStateCode : String?
    
    var citylist = [city]()
    
    var stateModeClass:StateListModel?
    var cityModeClass:StateListModel?
    var areaModeClass:StateListModel?


    
    var cNameArray = [String]()
    var cCodeArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinCodeTxtField.text = pincode
        personNameTxtField.text = userName
        // Do any additional setup after loading the view.
        pinCodeTxtField.text = pincode
         setup()
        stateApiCall()
        stateDropDown.inputView = UIView()
        cityDropDown.inputView = UIView()
        areaDropDown.inputView = UIView()
       
    //FIXME: - DropDown Did select
        stateDropDown.didSelect{ [self](selectedText , index ,id) in
            
            selectedStateCode = cCodeArray[index]
            stateDropDown.textColor = UIColor.black
            cityApiCall(cityCodeStr: selectedStateCode ?? "")
        }
        
      
        cityDropDown.didSelect{ [self](selectedText , index ,id) in
       
        
            selectedCityCode = cCodeArray[index]
            
            cityDropDown.textColor = UIColor.black
            
            areaApiCall(areaCodeStr:selectedCityCode ?? "")
        }
        
       

      
        areaDropDown.didSelect{ [self](selectedText , index ,id) in
            
            
            selectedAreaCode =  cCodeArray[index]
            
            
            
            areaDropDown.textColor = UIColor.black
       
        }
    }
    func setup(){
       
        contactErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        addressTwoErrOrLbl.isHidden = true
        addressOneErrorLbl.isHidden = true
        pinCodeErrorLbl.isHidden = true
        stateErrorLbl.isHidden = true
        cityErrorLbl.isHidden = true
        areaErrorrLbl.isHidden = true
        
        personNameTxtField.delegate = self
        emailTxtField.delegate = self
        addressOneTxtField.delegate = self
        addressTwoTxtField.delegate = self
        pinCodeTxtField.delegate = self
        nxtBtnNumberLbl.layer.cornerRadius = nxtBtnNumberLbl.frame.height / 2
        nxtBtnNumberLbl.layer.masksToBounds = true
        nextBtnRountDotLbl.layer.cornerRadius = nextBtnRountDotLbl.frame.height / 2
        nextBtnRountDotLbl.layer.masksToBounds = true
        nxtBtnRoundDotTwoLbl.layer.borderWidth = 1
        nxtBtnRoundDotTwoLbl.layer.borderColor = #colorLiteral(red: 0.8859493371, green: 0.8859493371, blue: 0.8859493371, alpha: 1)
        nxtBtnRoundDotTwoLbl.backgroundColor = UIColor.clear
        nxtBtnRoundDotTwoLbl.layer.cornerRadius = nxtBtnRoundDotTwoLbl.frame.height / 2
        nxtBtnRoundDotTwoLbl.layer.masksToBounds = true
        
        
        

        backView.layer.borderWidth = 1
        backView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.2274509804, blue: 0.2509803922, alpha: 1)
        backView.layer.cornerRadius = 8
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.8, blue: 0.8, alpha: 1)
        nextBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        let cityimg = UIImage(named: "down_arrow")
        let citybtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        citybtn.setImage(cityimg, for: .normal)
        citybtn.addTarget(self, action: #selector(citytaped), for: .touchUpInside)
        let view4 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view4.addSubview(citybtn)
        cityDropDown.rightView = view4
        cityDropDown.translatesAutoresizingMaskIntoConstraints = false
        cityDropDown.rightViewMode = .always
        
        let areaimg = UIImage(named: "down_arrow")
        let areabtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        areabtn.setImage(areaimg, for: .normal)
        areabtn.addTarget(self, action: #selector(areataped), for: .touchUpInside)
        let view1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view1.addSubview(areabtn)
        areaDropDown.rightView = view1
        areaDropDown.translatesAutoresizingMaskIntoConstraints = false
        areaDropDown.rightViewMode = .always
        
        
        let state = UIImage(named: "down_arrow")
        let statebtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        statebtn.setImage(state, for: .normal)
        statebtn.addTarget(self, action: #selector(statetapped), for: .touchUpInside)
        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view3.addSubview(statebtn)
        stateDropDown.rightView = view3
        stateDropDown.translatesAutoresizingMaskIntoConstraints = false
        stateDropDown.rightViewMode = .always
        
    
        
        
        let stateleft = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))
        stateleft.image = UIImage(named: "stateicon")
        let stateview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView.addSubview(stateleft)
        stateview.addSubview(emptyView)
        stateDropDown.leftView = stateview
        emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        stateview.backgroundColor = .white
        emptyView.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        stateDropDown.translatesAutoresizingMaskIntoConstraints = false
        stateDropDown.leftViewMode = .always
        
        
        let cityleft = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))
        cityleft.image = UIImage(named: "cityicon")
        let city = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70  , height: 48))
        let emptyView2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView2.addSubview(cityleft)
        city.addSubview(emptyView2)
        cityDropDown.leftView = city
        emptyView2.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        city.backgroundColor = .white
        emptyView2.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        cityDropDown.translatesAutoresizingMaskIntoConstraints = false
        cityDropDown.leftViewMode = .always
        
        let arealeft = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))
        arealeft.image = UIImage(named: "areaicon")
        let areaa = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView3.addSubview(arealeft)
        areaa.addSubview(emptyView3)
        areaDropDown.leftView = areaa
        emptyView3.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        areaa.backgroundColor = .white
        emptyView3.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        areaDropDown.translatesAutoresizingMaskIntoConstraints = false
        areaDropDown.leftViewMode = .always
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.backView.addGestureRecognizer(gesture)
       
        

    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        
      //  self.navigationController?.popViewController(animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtpVC") as? OtpVC
        vc?.mode = 0 
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc  func statetapped(sender: UIButton) {
        
        stateDropDown.showList()
            
          }
    @objc  func areataped(sender: UIButton) {
        areaDropDown.showList()
          }
    @objc  func citytaped(sender: UIButton) {
        
        cityDropDown.showList()
            
          }
    
    @IBAction func skipBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func nextBtnAct(_ sender: Any) {
        if personNameTxtField.text!.count > 3 && personNameTxtField.text!.count <= 16 && emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true && addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20 && addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20 &&  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 && stateDropDown.text?.count != 0 && cityDropDown.text?.count != 0 && areaDropDown.text?.count != 0{
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpFirmlegalIdentitiesVC") as? SignUpFirmlegalIdentitiesVC
            vc?.personName = personNameTxtField.text
            vc?.emailadd = emailTxtField.text!
            vc?.mobileNum = mobile
            vc?.addOne = addressOneTxtField.text!
            vc?.addTwo = addressTwoTxtField.text!
            vc?.pincode = pinCodeTxtField.text!
            vc?.state = stateDropDown.text!
            vc?.city = cityDropDown.text!
            vc?.area = areaDropDown.text!
            vc?.selectedStateCode = selectedStateCode
            vc?.selectedCityCode = selectedCityCode
            vc?.selectedAreaCode = selectedAreaCode
                let transition = CATransition()
                transition.duration = 0.4
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                transition.subtype = CATransitionSubtype.fromRight
                self.navigationController?.view.layer.add(transition, forKey: nil)
        
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
            
            
        }else if personNameTxtField.text!.count < 3 || personNameTxtField.text!.count >= 16 {
            personNameTxtField.layer.borderColor = UIColor.red.cgColor
            personNameTxtField.placeholder = "    Please enter the valid Name"
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
       
        }else if emailTxtField.text!.count == 0 {
            emailTxtField.layer.borderColor = UIColor.red.cgColor
            emailTxtField.placeholder = "    Please enter the valid Mail"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if addressOneTxtField.text?.count == 0  {
            addressOneTxtField.layer.borderColor = UIColor.red.cgColor
            addressOneTxtField.placeholder = "Enter the address - 1"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }
        else if addressTwoTxtField.text?.count == 0  {
            addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
            addressTwoTxtField.placeholder = "Enter the address - 2"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if pinCodeTxtField.text?.count == 0  {
            pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
            pinCodeTxtField.placeholder = "PinCode"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if stateDropDown.text?.count == 0  {
            stateDropDown.layer.borderColor = UIColor.red.cgColor
            stateDropDown.placeholder = "Select the state"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if cityDropDown.text?.count == 0  {
            cityDropDown.layer.borderColor = UIColor.red.cgColor
            cityDropDown.placeholder = "Select the city"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if areaDropDown.text?.count == 0  {
            areaDropDown.layer.borderColor = UIColor.red.cgColor
            areaDropDown.placeholder = "Select the area"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }
        
        
        else {
            print("check")
            UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
        }
        
       
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
    extension SignUpSellerFirmContactRegistration : UITextFieldDelegate{
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == self.personNameTxtField{
                
                
    //userNameTxtfiled.layer.shadowRadius = 1
    //userNameTxtfiled.layer.shadowOffset = CGSize(width: 1, height: 1)
                contactErrorLbl.isHidden = true
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                personNameTxtField.alpha = 0.5
                personNameTxtField.placeholder = "Person Name"
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
                
                
                
            }else if textField == self.emailTxtField{
                //      passwordTxtField.layer.shadowRadius = 1
                //      passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                
                emailErrorLbl.isHidden = true
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                emailTxtField.alpha = 0.5
                emailTxtField.placeholder = "Email"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                         
                        }else if textField == self.addressOneTxtField{
                             //passwordTxtField.layer.shadowRadius = 1
                             //passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                            addressOneErrorLbl.isHidden = true
                            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                            addressOneTxtField.alpha = 0.5
                            addressOneTxtField.placeholder = "Address - 1"
                            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                        
                                     
                }else if textField == self.addressTwoTxtField{
                        //      passwordTxtField.layer.shadowRadius = 1
                        //      passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                    addressTwoErrOrLbl.isHidden = true
                    addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                    addressTwoTxtField.alpha = 0.5
                    addressTwoTxtField.placeholder = "Address - 2"
                    personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                 
                                                }
                else if textField == self.pinCodeTxtField{
                        //passwordTxtField.layer.shadowRadius = 1
                        //passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                    
                    pinCodeErrorLbl.isHidden = true
                    pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                    pinCodeTxtField.alpha = 0.5
                    pinCodeTxtField.placeholder = "PinCode"
                  
                    personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                 
                                                }
                else if textField == self.stateDropDown{
                        //passwordTxtField.layer.shadowRadius = 1
                        //passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1
                    
                    stateErrorLbl.isHidden = true
                    stateDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                    stateDropDown.alpha = 0.5
                    stateDropDown.placeholder = "State"
                  //  stateDropDown.textColor = .black
                    personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                 
                                                }
                else if textField == self.cityDropDown{
                        //passwordTxtField.layer.shadowRadius = 1
                        //passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                    
                    cityErrorLbl.isHidden = true
                    cityDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                    cityDropDown.alpha = 0.5
                    cityDropDown.placeholder = "City"
                   // cityDropDown.textColor = .black
                    personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                 
                                                }
                else if textField == self.areaDropDown{
                        //passwordTxtField.layer.shadowRadius = 1
                        //passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                    
                    areaErrorrLbl.isHidden = true
                    areaDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                    areaDropDown.alpha = 0.5
                    areaDropDown.placeholder = "Area"
                  //  areaDropDown.textColor = .black
                    personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                                 
                                                }
            }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == personNameTxtField{
               
                if personNameTxtField.text!.count > 3 && personNameTxtField.text!.count <= 16{
                    self.emailTxtField.becomeFirstResponder()
                }else{
                    
                    self.personNameTxtField.resignFirstResponder()
                    contactErrorLbl.isHidden = false
                    contactErrorLbl.text = "should contain 4 - 16 character"
//                    personNameTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                }
            }
            if textField == emailTxtField {
                if emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true && emailTxtField.text?.count != 0{
                    self.addressOneTxtField.becomeFirstResponder()
                }else{
                    self.emailTxtField.resignFirstResponder()
                    emailErrorLbl.isHidden = false
                    emailErrorLbl.text = "Please enter the valid Email"
//                    emailTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Please enter the valid Email", view: self.view)
                }
            }
            if textField == addressOneTxtField{
                if addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20{
                    self.addressTwoTxtField.resignFirstResponder()
                }else{
                    self.addressOneTxtField.resignFirstResponder()
                    addressOneErrorLbl.isHidden = false
                    addressOneErrorLbl.text = "Fill the address - 1"
//                    addressOneTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                }
            }
            if textField == addressTwoTxtField{
                if addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20{
                    self.addressTwoTxtField.resignFirstResponder()
                }else{
                    self.addressTwoTxtField.resignFirstResponder()
                    addressTwoErrOrLbl.isHidden = false
                    addressTwoErrOrLbl.text = "Fill the address - 2"
//                    addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                }
            }
            if textField == pinCodeTxtField {
                if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6{
                    self.pinCodeTxtField.resignFirstResponder()
                }else{
                    self.pinCodeTxtField.resignFirstResponder()
                    pinCodeErrorLbl.isHidden = false
                    pinCodeErrorLbl.text = "Fill the address - 2"
//                    pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Pincode is error", view: self.view)
                }
                
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
               
            
            if textField == pinCodeTxtField{
                let maxLength = 6          // set your need
                           let currentString: NSString = textField.text! as NSString
                           let newString: NSString =
                               currentString.replacingCharacters(in: range, with: string) as NSString
                           return newString.length <= maxLength
            }


                return true

            }
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {

                switch textField{
                case personNameTxtField :
                    if textField  == personNameTxtField{
                        if personNameTxtField.text!.count > 3 && personNameTxtField.text!.count <= 16{
                            emailTxtField.becomeFirstResponder()

                        }else{
                            self.personNameTxtField.resignFirstResponder()
                            contactErrorLbl.isHidden = false
                            contactErrorLbl.text = "should contain 4 - 16 character"
//                            personNameTxtField.layer.borderColor = UIColor.red.cgColor
//                            UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                        }
                    }

                case self.emailTxtField:


                          if (emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true) && emailTxtField.text?.count != 0{
                            addressOneTxtField.becomeFirstResponder()
                          }else{
                            emailTxtField.resignFirstResponder()
                            emailErrorLbl.isHidden = false
                            emailErrorLbl.text = "Please enter the valid Email"
//                            emailTxtField.layer.borderColor = UIColor.red.cgColor
//                              UIView().showToast(message: "Please enter the valid email", view: self.view)
                          }
                case self.addressOneTxtField:
                    if addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20{
                        self.addressTwoTxtField.becomeFirstResponder()
                    }else{
                        self.addressOneTxtField.resignFirstResponder()
                        addressOneErrorLbl.isHidden = false
                        addressOneErrorLbl.text = "Fill the address - 1"
//                        addressOneTxtField.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "Fill the address - 1 ", view: self.view)
                    }
                case self.addressTwoTxtField:
                    if addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20{
                        self.addressTwoTxtField.resignFirstResponder()
                    }else{
                        
                        self.addressTwoTxtField.resignFirstResponder()
                        addressTwoErrOrLbl.isHidden = false
                        addressTwoErrOrLbl.text = "Fill the address - 2"
//                        addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                    }
                case self.pinCodeTxtField:
                    if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6{
                        pinCodeTxtField.resignFirstResponder()
                        
                    }else{
                        pinCodeTxtField.resignFirstResponder()
                        pinCodeErrorLbl.isHidden = false
                        pinCodeErrorLbl.text = "Fill the address - 2"
//                        pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "Pincode is error", view: self.view)
                    }
                    
                default:
                    self.personNameTxtField.becomeFirstResponder()
                }
                return true

            }
    }
extension SignUpSellerFirmContactRegistration:WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    
    func stateApiCall(){
        cNameArray.removeAll()
        cCodeArray.removeAll()
        let stateList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "StateList")
//        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
//                                    "X-csquare-api-token":"1371757505f37f2c",
//                                    "Content-Type":"application/json",
//                                        ]

        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        stateList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+STATE_LIST_URL, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.stateModeClass = StateListModel(object:dict)
            print(dict)
            if boolSuccess {
                for (_,element) in (self.stateModeClass?.payloadJson?.data)!.enumerated() {
                    
                    cNameArray.append(element.cName ?? "")
                    cCodeArray.append(element.cCode ?? "")
                    
                }
                
                self.stateDropDown.optionArray = cNameArray
                
                

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })
        
        
        }
    
    
    func cityApiCall(cityCodeStr:String){
        cNameArray.removeAll()
        cCodeArray.removeAll()
        
        let cityList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "CityList")
//        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
//                                    "X-csquare-api-token":"1371757505f37f2c",
//                                    "Content-Type":"application/json",
//                                        ]

        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        cityList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+CITY_LIST_URL + cityCodeStr, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.cityModeClass = StateListModel(object:dict)
            if boolSuccess {
                for (_,element) in (self.cityModeClass?.payloadJson?.data)!.enumerated() {
                    
                    cNameArray.append(element.cName ?? "")
                    cCodeArray.append(element.cCode ?? "")
                    
                }
                
                self.cityDropDown.optionArray = cNameArray
                
                

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })
        
        
        }
    
    
    func areaApiCall(areaCodeStr:String){
        cNameArray.removeAll()
        cCodeArray.removeAll()
        
        let areaList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AreaList")
//        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
//                                    "X-csquare-api-token":"1371757505f37f2c",
//                                    "Content-Type":"application/json",
//                                        ]

        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        areaList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+AREA_LIST_URL + areaCodeStr, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.areaModeClass = StateListModel(object:dict)
            if boolSuccess {
                for (_,element) in (self.areaModeClass?.payloadJson?.data)!.enumerated() {
                    
                    cNameArray.append(element.cName ?? "")
                    cCodeArray.append(element.cCode ?? "")
                    
                }
                
                self.areaDropDown.optionArray = cNameArray
                
                

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })
        
        
        }
    

    
}



