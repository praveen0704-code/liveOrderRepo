//
//  BuyerRegistrationVC.swift
//  liveOrder
//
//  Created by Data Prime on 08/07/21.
//

import UIKit
import Alamofire
import iOSDropDown
import NotificationBannerSwift


class BuyerRegistrationVC: UIViewController {
    @IBOutlet weak var backBtnview: UIView!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var firmLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollOverView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var personNameTxtField: DesignableUITextField!
    
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var areaDropDown: DropDown!
    
    @IBOutlet weak var emailTxtField: DesignableUITextField!
    @IBOutlet weak var addressOneTxtField: DesignableUITextField!
    @IBOutlet weak var addressTwoTxtField: DesignableUITextField!
    @IBOutlet weak var pinCocdeTxtField: DesignableUITextField!
   
    @IBOutlet weak var skipbtn: UIButton!
    @IBOutlet weak var contactErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var addressOneErrorLbl: UILabel!
    @IBOutlet weak var addressTwoErrorLbl: UILabel!
    @IBOutlet weak var pinCodeErrorLbl: UILabel!
    @IBOutlet weak var stateErrorLbl: UILabel!
    @IBOutlet weak var cityErrorLbl: UILabel!
    @IBOutlet weak var areaErrorLbl: UILabel!
    
    //Height Constrains OutLets
    
   
    @IBOutlet weak var nameErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var emailErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var addOneErrorHeghtConstrains: NSLayoutConstraint!
    @IBOutlet weak var addTwoErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var pincodeErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var stateErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var cityErrorHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var areaErrorHeightConstrains: NSLayoutConstraint!
    
    
    var userName : String?
    var stateArray : [Stateclass] = []
    var citys : [cityClass] = []
    var areaArray : [Areaclass] = []
    var pincode : String?
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
    
    
    var firmupdateModel : FirmUpdateModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    //MARK: - LoadSetup

    
    func setup(){
        pinCocdeTxtField.text = pincode
        personNameTxtField.text = userName
        pinCocdeTxtField.textColor = UIColor(hexString: "5b636a")
        personNameTxtField.textColor = UIColor(hexString: "5b636a")

        stateApiCall()
        stateDropDown.inputView = UIView()
        cityDropDown.inputView = UIView()
        areaDropDown.inputView = UIView()
       
    //FIXME: - DropDown Did select
        stateDropDown.didSelect{ [self](selectedText , index ,id) in
            
            selectedStateCode = cCodeArray[index]
            stateDropDown.textColor = UIColor(hexString: "5b636a")
            cityApiCall(cityCodeStr: selectedStateCode ?? "")
        }
        
      
        cityDropDown.didSelect{ [self](selectedText , index ,id) in
       
        
            selectedCityCode = cCodeArray[index]
            
            cityDropDown.textColor = UIColor(hexString: "5b636a")
            
            areaApiCall(areaCodeStr:selectedCityCode ?? "")
        }
        
       

      
        areaDropDown.didSelect{ [self](selectedText , index ,id) in
            
            
            selectedAreaCode =  cCodeArray[index]
            
            
            
            areaDropDown.textColor = UIColor(hexString: "5b636a")
       
        }

        
        contactErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        addressOneErrorLbl.isHidden = true
        addressTwoErrorLbl.isHidden = true
        pinCodeErrorLbl.isHidden = true
        stateErrorLbl.isHidden = true
        cityErrorLbl.isHidden = true
        areaErrorLbl.isHidden = true
        personNameTxtField.delegate = self
        emailTxtField.delegate = self
        addressOneTxtField.delegate = self
        addressTwoTxtField.delegate = self
        pinCocdeTxtField.delegate = self
//        stateDropDown.delegate = self
//        cityDropDown.delegate = self
//        areaDropDown.delegate = self
        personNameTxtField.textColor = UIColor(hexString: "5b636a")
        emailTxtField.textColor = UIColor(hexString: "5b636a")
        addressOneTxtField.textColor = UIColor(hexString: "5b636a")
        addressTwoTxtField.textColor = UIColor(hexString: "5b636a")
        pinCocdeTxtField.textColor = UIColor(hexString: "5b636a")
        backBtnview.layer.borderWidth = 1
        backBtnview.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.2274509804, blue: 0.2509803922, alpha: 0.3)
        backBtnview.layer.cornerRadius = 8
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.8, blue: 0.8, alpha: 1)
        doneBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
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
        self.backBtnview.addGestureRecognizer(gesture)
        
        nameErrorHeightConstrains.constant = 0.0
        contactErrorLbl.layoutIfNeeded()
        emailErrorHeightConstrains.constant = 0.0
        emailErrorLbl.layoutIfNeeded()
        addOneErrorHeghtConstrains.constant = 0.0
        addressOneErrorLbl.layoutIfNeeded()
        addTwoErrorHeightConstrains.constant = 0.0
        addressTwoErrorLbl.layoutIfNeeded()
        pincodeErrorHeightConstrains.constant = 0.0
        pinCodeErrorLbl.layoutIfNeeded()
        stateErrorHeightConstrains.constant = 0.0
        stateErrorLbl.layoutIfNeeded()
        cityErrorHeightConstrains.constant = 0.0
        cityErrorLbl.layoutIfNeeded()
        areaErrorHeightConstrains.constant = 0.0
        areaErrorLbl.layoutIfNeeded()
      
    }
    
    
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        
      //  self.navigationController?.popViewController(animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtpVC") as? OtpVC
        vc?.mode = 1
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
    @IBAction func doneBtnAct(_ sender: Any) {
        if personNameTxtField.text!.count > 3 && personNameTxtField.text!.count <= 16 && emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true && addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20 && addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20 &&  pinCocdeTxtField.text?.count != 0 && pinCocdeTxtField.text!.count == 6 && stateDropDown.text?.count != 0 && cityDropDown.text?.count != 0 && areaDropDown.text?.count != 0{

            registerApi()


            
        }else if personNameTxtField.text!.count < 3 || personNameTxtField.text!.count >= 16 {
            personNameTxtField.layer.borderColor = UIColor.red.cgColor
            personNameTxtField.placeholder = "    Please enter the valid Name"
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
       
        }else if emailTxtField.text!.count == 0 {
            emailTxtField.layer.borderColor = UIColor.red.cgColor
            emailTxtField.placeholder = "    Please enter the valid Mail"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if addressOneTxtField.text?.count == 0  {
            addressOneTxtField.layer.borderColor = UIColor.red.cgColor
            addressOneTxtField.placeholder = "Enter the address - 1"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
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
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if pinCocdeTxtField.text?.count == 0  {
            pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
            pinCocdeTxtField.placeholder = "PinCode"
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
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if cityDropDown.text?.count == 0  {
            cityDropDown.layer.borderColor = UIColor.red.cgColor
            cityDropDown.placeholder = "Select the city"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        }else if areaDropDown.text?.count == 0  {
            areaDropDown.layer.borderColor = UIColor.red.cgColor
            areaDropDown.placeholder = "Select the area"
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
       
        } else {
            print("check")
            UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
        }
        
       
        
    }
    
    



}

extension BuyerRegistrationVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.personNameTxtField{
            
            contactErrorLbl.isHidden = true
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            personNameTxtField.placeholder = "Person Name"
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
            
        }else if textField == self.emailTxtField{
    
            emailErrorLbl.isHidden = true
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            emailTxtField.placeholder = "Email"
            
            personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        
                     
                    }else if textField == self.addressOneTxtField{
                    
                        addressOneErrorLbl.isHidden = true
                        addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                        addressOneTxtField.placeholder = "Address - 1"
                        personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                    
                                 
            }else if textField == self.addressTwoTxtField{
                                  
                addressTwoErrorLbl.isHidden = true
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                addressTwoTxtField.placeholder = "Address - 2"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                             
                                            }
            else if textField == self.pinCocdeTxtField{
                                   
                pinCodeErrorLbl.isHidden = true
                pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                pinCocdeTxtField.placeholder = "PinCode"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                             
                                            }
            else if textField == self.stateDropDown{
                                 
                stateErrorLbl.isHidden = true
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                stateDropDown.placeholder = "State"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
                                             
                                            }
            else if textField == self.cityDropDown{
                                   
                cityErrorLbl.isHidden = true
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                cityDropDown.placeholder = "City"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                             
                                            }
            else if textField == self.areaDropDown{
                                   
                areaErrorLbl.isHidden = true
                areaDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                areaDropDown.placeholder = "Area"
                personNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                addressTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                pinCocdeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                                             
                                            }
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == personNameTxtField{
           
            if personNameTxtField.text!.count > 3 && personNameTxtField.text!.count <= 16{
                self.emailTxtField.becomeFirstResponder()
                nameErrorHeightConstrains.constant = 0.0
                contactErrorLbl.layoutIfNeeded()
                
            }else{
                
                self.personNameTxtField.resignFirstResponder()
                nameErrorHeightConstrains.constant = 11.0
                contactErrorLbl.layoutIfNeeded()
                contactErrorLbl.isHidden = false
                contactErrorLbl.text = "should contain 4 - 16 character"

            }
        }
        if textField == emailTxtField {
            if emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true && emailTxtField.text?.count != 0{
               
                emailErrorHeightConstrains.constant = 0.0
                emailErrorLbl.layoutIfNeeded()
                self.addressOneTxtField.becomeFirstResponder()
            }else{
                self.emailTxtField.resignFirstResponder()
              
                emailErrorHeightConstrains.constant = 11.0
                emailErrorLbl.layoutIfNeeded()
               
                emailErrorLbl.isHidden = false
                emailErrorLbl.text = "Please enter the valid Email"
//                emailTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid Email", view: self.view)
            }
        }
        if textField == addressOneTxtField{
            if addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20{
               
                addOneErrorHeghtConstrains.constant = 0.0
                addressOneErrorLbl.layoutIfNeeded()
        
                self.addressTwoTxtField.resignFirstResponder()
            }else{
                self.addressOneTxtField.resignFirstResponder()
               
                addOneErrorHeghtConstrains.constant = 11.0
                addressOneErrorLbl.layoutIfNeeded()
                
                addressOneErrorLbl.isHidden = false
                addressOneErrorLbl.text = "Fill the address - 1"
//                addressOneTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == addressTwoTxtField{
            if addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20{
                
                addTwoErrorHeightConstrains.constant = 0.0
                addressTwoErrorLbl.layoutIfNeeded()
                
                self.addressTwoTxtField.resignFirstResponder()
            }else{
                self.addressTwoTxtField.resignFirstResponder()
                
                addTwoErrorHeightConstrains.constant = 11.0
                addressTwoErrorLbl.layoutIfNeeded()
               
                addressTwoErrorLbl.isHidden = false
                addressTwoErrorLbl.text = "Fill the address - 2"
//                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == pinCocdeTxtField {
            if  pinCocdeTxtField.text?.count != 0 && pinCocdeTxtField.text!.count == 6{
               
                pincodeErrorHeightConstrains.constant = 0.0
                pinCodeErrorLbl.layoutIfNeeded()
                
                self.pinCocdeTxtField.resignFirstResponder()
            }else{
                self.pinCocdeTxtField.resignFirstResponder()
              
                pincodeErrorHeightConstrains.constant = 11.0
                pinCodeErrorLbl.layoutIfNeeded()
              
                pinCodeErrorLbl.isHidden = false
                pinCodeErrorLbl.text = "Pincode is error"
//                pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Pincode is error", view: self.view)
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
           
        
        if textField == pinCocdeTxtField{
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
                        nameErrorHeightConstrains.constant = 0.0
                        contactErrorLbl.layoutIfNeeded()
                        
                        emailTxtField.becomeFirstResponder()
                        

                    }else{
                        self.personNameTxtField.resignFirstResponder()
                        nameErrorHeightConstrains.constant = 11.0
                        contactErrorLbl.layoutIfNeeded()
                       
                        contactErrorLbl.isHidden = false
                        contactErrorLbl.text = "should contain 4 - 16 character"
//                        personNameTxtField.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                    }
                }

            case self.emailTxtField:


                      if (emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true) && emailTxtField.text?.count != 0{
                         
                          emailErrorHeightConstrains.constant = 0.0
                          emailErrorLbl.layoutIfNeeded()
                    
                        addressOneTxtField.becomeFirstResponder()
                      }else{
                        emailTxtField.resignFirstResponder()
                         
                          emailErrorHeightConstrains.constant = 11.0
                          emailErrorLbl.layoutIfNeeded()
                       
                        emailErrorLbl.isHidden = false
                        emailErrorLbl.text = "Please enter the valid Email"
//                        emailTxtField.layer.borderColor = UIColor.red.cgColor
//                          UIView().showToast(message: "Please enter the valid email", view: self.view)
                      }
            case self.addressOneTxtField:
                if addressOneTxtField.text?.count != 0 && addressOneTxtField.text!.count <= 20{
                     
                    addOneErrorHeghtConstrains.constant = 0.0
                    addressOneErrorLbl.layoutIfNeeded()
                     
                    self.addressTwoTxtField.becomeFirstResponder()
                }else{
                    self.addressOneTxtField.resignFirstResponder()
                     
                    addOneErrorHeghtConstrains.constant = 11.0
                    addressOneErrorLbl.layoutIfNeeded()
                 
                    addressOneErrorLbl.isHidden = false
                    addressOneErrorLbl.text = "Fill the address - 1"
//                    addressOneTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Fill the address - 1 ", view: self.view)
                }
            case self.addressTwoTxtField:
                if addressTwoTxtField.text?.count != 0 && addressTwoTxtField.text!.count <= 20{
                  
                    addTwoErrorHeightConstrains.constant = 0.0
                    addressTwoErrorLbl.layoutIfNeeded()
                    
                    self.addressTwoTxtField.resignFirstResponder()
                }else{
                    
                    self.addressTwoTxtField.resignFirstResponder()
                   
                    addTwoErrorHeightConstrains.constant = 11.0
                    addressTwoErrorLbl.layoutIfNeeded()
                   
                    addressTwoErrorLbl.isHidden = false
                    addressTwoErrorLbl.text = "Fill the address - 2"
//                    addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                }
            case self.pinCocdeTxtField:
                if  pinCocdeTxtField.text?.count != 0 && pinCocdeTxtField.text!.count == 6{
                    
                    pincodeErrorHeightConstrains.constant = 0.0
                    pinCodeErrorLbl.layoutIfNeeded()
                    
                    pinCocdeTxtField.resignFirstResponder()
                    
                }else{
                    pinCocdeTxtField.resignFirstResponder()
                    
                    pincodeErrorHeightConstrains.constant = 11.0
                    pinCodeErrorLbl.layoutIfNeeded()
                   
                    pinCodeErrorLbl.isHidden = false
                    pinCodeErrorLbl.text = "Pincode is error"
//                    pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Pincode is error", view: self.view)
                }
                
            default:
                self.personNameTxtField.becomeFirstResponder()
            }
            return true

        }
}

extension BuyerRegistrationVC:WebServiceDelegate{
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
    

    
    func registerApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
//        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
//                                    "X-csquare-api-token":"1371757505f37f2c",
//                                    "Content-Type":"application/json",
//                                        ]
//
        
        let registParams: [String: Any] = ["c_firm_name":personNameTxtField.text,
                                   "c_mobile_no":mobile,
                                   "c_pincode":pincode,
                                   "c_firm_img":"",
                                   "c_email_id":emailTxtField.text,
                                   "c_drug_license_no1":"1",
                                   "c_drug_license_no1_img":"yyyyyyy",
                                   "c_drug_license_no1_expiry_date":"2025-09-30",
                                   "c_drug_license_no2":"2",
                                   "c_drug_license_no2_img":"",
                                   "c_drug_license_no2_expiry_date":"2025-09-30",
                                   "c_gst_type":"A",
                                   "c_gst_number":"GST0234567890",
                                   "c_narcotic_no":"3",
                                           "c_contact_person_name":personNameTxtField.text,
                                           "c_address_no1":addressOneTxtField.text,
                                           "c_address_no2":addressTwoTxtField.text,
                                   "c_state_code":selectedStateCode,
                                           "c_state_name":stateDropDown.text,
                                   "c_city_code":selectedCityCode,
                                           "c_city_name":cityDropDown.text,
                                   "c_area_code":selectedAreaCode,
                                           "c_area_name":areaDropDown.text
]
     
     

        
        let bHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        registerApi.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + FIRM_FOR_URL, type: .post, userData: registParams, apiHeader: bHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmupdateModel = FirmUpdateModel(object: dict)
            if boolSuccess {
                if firmupdateModel?.appStatusCode == 0{
                    if #available(iOS 13.0, *) {
                        let banner = NotificationBanner(title: "Message", subtitle: self.firmupdateModel?.messages?[0], style: .info)
                        banner.showToast(message: self.firmupdateModel?.messages?[0] ?? "", view: self.view)
                        let landingVc = self.storyboard?.instantiateViewController(identifier: "LoHomeViewController") as! LoHomeViewController
                        self.navigationController?.pushViewController(landingVc, animated: true)
                    } else {
                        // Fallback on earlier versions
                    }
                   

                }
                
                

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })

        
    }
    

    
}



