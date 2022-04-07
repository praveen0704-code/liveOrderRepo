//
//  BuyerRegistrationCell.swift
//  liveOrder
//
//  Created by Data Prime on 02/11/21.
//

import UIKit
import iOSDropDown
import Alamofire
protocol pinChangeDelegate{
    func change(pinNum : String)
    
    
}
class BuyerRegistrationCell: UITableViewCell {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    
    @IBOutlet weak var firmContactLbl: UILabel!
    @IBOutlet weak var personNameTxtFiled: DesignableUITextField!
    @IBOutlet weak var contactErrorLbl: UILabel!
    @IBOutlet weak var emailTxtFIeld: DesignableUITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var addOneTxtFiled: DesignableUITextField!
    @IBOutlet weak var addOneErrorLbl: UILabel!
    @IBOutlet weak var addTwoTxtFiled: DesignableUITextField!
    @IBOutlet weak var addTwoErrorLbl: UILabel!
    @IBOutlet weak var pinCodeTxtField: DesignableUITextField!
    @IBOutlet weak var pincodeErrorLbl: UILabel!
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var stateErrorLbl: UILabel!
    
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var cityErrorLbl: UILabel!
    @IBOutlet weak var areaDropDown: DropDown!
    @IBOutlet weak var areaErrorLbl: UILabel!
    
    
    @IBOutlet weak var contactLblHeight: NSLayoutConstraint!
    @IBOutlet weak var emailErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var addOneErrHeight: NSLayoutConstraint!
    @IBOutlet weak var addtwoErrHeight: NSLayoutConstraint!
    @IBOutlet weak var pinErrHeight: NSLayoutConstraint!
    @IBOutlet weak var stateErrHeight: NSLayoutConstraint!
    @IBOutlet weak var cityErrHeight: NSLayoutConstraint!
    @IBOutlet weak var areaerrHeight: NSLayoutConstraint!
    var delegate : pinChangeDelegate?
    var cNameArray = [String]()
    var cCodeArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
        
    }
    func setup(){
        
        
        
        
        contactErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        addOneErrorLbl.isHidden = true
        addTwoErrorLbl.isHidden = true
        pincodeErrorLbl.isHidden = true
        stateErrorLbl.isHidden = true
        cityErrorLbl.isHidden = true
        areaErrorLbl.isHidden = true
        personNameTxtFiled.delegate = self
        emailTxtFIeld.delegate = self
        addOneTxtFiled.delegate = self
        addTwoTxtFiled.delegate = self
        pinCodeTxtField.delegate = self
        
        stateDropDown.isUserInteractionEnabled = false
        cityDropDown.isUserInteractionEnabled = false
        //        let cityimg = UIImage(named: "down_arrow")
        //        let citybtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
        //
        //        citybtn.setImage(cityimg, for: .normal)
        //
        //        let view4 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        //
        //        view4.addSubview(citybtn)
        //        cityDropDown.rightView = view4
        //        cityDropDown.translatesAutoresizingMaskIntoConstraints = false
        //        cityDropDown.rightViewMode = .always
        
//        let areaimg = UIImage(named: "down_arrow")
//        let areabtn = UIButton(frame: CGRect(x: 0, y: 0, width: CGFloat(35), height: CGFloat(35)))
//        areabtn.backgroundColor = .clear
//        let imgView = UIImageView(frame: CGRect(x: 0, y: 14, width: 12, height: 7))
//        imgView.image = imgView.image?.withRenderingMode(.alwaysTemplate)
//        imgView.tintColor = UIColor.black
//        imgView.image = areaimg
//        imgView.contentMode = .scaleAspectFit
//        areabtn.addTarget(self, action: #selector(areaTapped), for: .touchUpInside)
//        
//        
//        let view1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//        
//        view1.addSubview(areabtn)
//        view1.addSubview(imgView)
//        areaDropDown.rightView = view1
//        areaDropDown.translatesAutoresizingMaskIntoConstraints = false
//        areaDropDown.rightViewMode = .always
        
        //        let state = UIImage(named: "down_arrow")
        //        let statebtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
        //
        //        statebtn.setImage(state, for: .normal)
        //
        //        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        //        view3.addSubview(statebtn)
        //        stateDropDown.rightView = view3
        //        stateDropDown.translatesAutoresizingMaskIntoConstraints = false
        //        stateDropDown.rightViewMode = .always
        
        let stateleft = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))
        stateleft.contentMode = .scaleAspectFit
        
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
        
        
        contactLblHeight.constant = 0.0
        contactErrorLbl.layoutIfNeeded()
        emailErrorHeight.constant = 0.0
        emailErrorLbl.layoutIfNeeded()
        addOneErrHeight.constant = 0.0
        addOneErrorLbl.layoutIfNeeded()
        addtwoErrHeight.constant = 0.0
        addTwoErrorLbl.layoutIfNeeded()
        pinErrHeight.constant = 0.0
        pincodeErrorLbl.layoutIfNeeded()
        stateErrHeight.constant = 0.0
        stateErrorLbl.layoutIfNeeded()
        cityErrHeight.constant = 0.0
        cityErrorLbl.layoutIfNeeded()
        areaerrHeight.constant = 0.0
        areaErrorLbl.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    @objc func areaTapped(){
//        areaDropDown.showList()
//    }
}
extension BuyerRegistrationCell: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.personNameTxtFiled{
            
            contactErrorLbl.isHidden = true
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            personNameTxtFiled.placeholder = "Person Name"
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
            
        }else if textField == self.emailTxtFIeld{
            
            emailErrorLbl.isHidden = true
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            emailTxtFIeld.placeholder = "Email"
            
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.addOneTxtFiled{
            
            addOneErrorLbl.isHidden = true
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            addOneTxtFiled.placeholder = "Address - 1"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.addTwoTxtFiled{
            
            addTwoErrorLbl.isHidden = true
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            addTwoTxtFiled.placeholder = "Address - 2"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.pinCodeTxtField{
            
            pincodeErrorLbl.isHidden = true
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            pinCodeTxtField.placeholder = "PinCode"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.stateDropDown{
            self.stateDropDown.resignFirstResponder()
            
            stateErrorLbl.isHidden = true
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            stateDropDown.placeholder = "State"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        else if textField == self.cityDropDown{
            self.cityDropDown.resignFirstResponder()
            
            cityErrorLbl.isHidden = true
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            cityDropDown.placeholder = "City"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.areaDropDown{
            self.areaDropDown.resignFirstResponder()
            
            areaErrorLbl.isHidden = true
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            areaDropDown.placeholder = "Area"
            personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == personNameTxtFiled{
            
            if personNameTxtFiled.text!.count > 3 && personNameTxtFiled.text!.count <= 256{
                self.emailTxtFIeld.becomeFirstResponder()
                contactLblHeight.constant = 0.0
                contactErrorLbl.layoutIfNeeded()
                
            }else{
                
                self.personNameTxtFiled.resignFirstResponder()
                contactLblHeight.constant = 11.0
                contactErrorLbl.layoutIfNeeded()
                contactErrorLbl.isHidden = false
                contactErrorLbl.text = "Enter the valid name 3 - 16 character"
                
            }
        }
        if textField == emailTxtFIeld {
            if emailTxtFIeld.text?.isValidEmail(testStr: emailTxtFIeld.text!) == true && emailTxtFIeld.text?.count != 0{
                
                emailErrorHeight.constant = 0.0
                emailErrorLbl.layoutIfNeeded()
                self.addOneTxtFiled.becomeFirstResponder()
            }else{
                self.emailTxtFIeld.resignFirstResponder()
                
                emailErrorHeight.constant = 11.0
                emailErrorLbl.layoutIfNeeded()
                
                emailErrorLbl.isHidden = false
                emailErrorLbl.text = "Please enter the valid Email"
                //                emailTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Please enter the valid Email", view: self.view)
            }
        }
        if textField == addOneTxtFiled{
            if addOneTxtFiled.text?.count != 0 && addOneTxtFiled.text!.count <= 20{
                
                addOneErrHeight.constant = 0.0
                addOneErrorLbl.layoutIfNeeded()
                
                self.addTwoTxtFiled.resignFirstResponder()
            }else{
                self.addOneTxtFiled.resignFirstResponder()
                
                addOneErrHeight.constant = 11.0
                addOneErrorLbl.layoutIfNeeded()
                
                addOneErrorLbl.isHidden = false
                addOneErrorLbl.text = "Fill the address - 1"
                //                addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == addTwoTxtFiled{
            if addTwoTxtFiled.text?.count != 0 && addTwoTxtFiled.text!.count <= 20{
                
                addtwoErrHeight.constant = 0.0
                addTwoErrorLbl.layoutIfNeeded()
                
                self.addTwoTxtFiled.resignFirstResponder()
            }else{
                self.addTwoTxtFiled.resignFirstResponder()
                
                addtwoErrHeight.constant = 11.0
                addTwoErrorLbl.layoutIfNeeded()
                
                addTwoErrorLbl.isHidden = false
                addTwoErrorLbl.text = "Fill the address - 2"
                //                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == pinCodeTxtField {
            if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6{
                
                pinErrHeight.constant = 0.0
                pincodeErrorLbl.layoutIfNeeded()
                
                self.pinCodeTxtField.resignFirstResponder()
            }else{
                self.pinCodeTxtField.resignFirstResponder()
                
                pinErrHeight.constant = 11.0
                pincodeErrorLbl.layoutIfNeeded()
                
                pincodeErrorLbl.isHidden = false
                pincodeErrorLbl.text = "Pincode is error"
                //                pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Pincode is error", view: self.view)
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == personNameTxtFiled{
            let rawString = string
            let rowrange = rawString.rangeOfCharacter(from: .whitespaces)
                if ((personNameTxtFiled.text?.count)! == 0 && rowrange  != nil)
                || ((personNameTxtFiled.text?.count)! > 0 && personNameTxtFiled.text?.last  == " " && rowrange != nil)  {
                    return false
                }else{
                    let maxLength = 256          // set your need
                    let currentString: NSString = textField.text! as NSString
                    let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                    return newString.length <= maxLength
                }
        }
        if textField == emailTxtFIeld{
         
            if (string == " ") {
                   return false
            }else{
                return true
            }
               
            
        }
        if textField == addOneTxtFiled{
            let rawString = string
            let rowrange = rawString.rangeOfCharacter(from: .whitespaces)
                if ((addOneTxtFiled.text?.count)! == 0 && rowrange  != nil)
                || ((addOneTxtFiled.text?.count)! > 0 && addOneTxtFiled.text?.last  == " " && rowrange != nil)  {
                    return false
                }else{
                    return true
                }
        }
        if textField == addTwoTxtFiled{
            let rawString = string
            let rowrange = rawString.rangeOfCharacter(from: .whitespaces)
                if ((addTwoTxtFiled.text?.count)! == 0 && rowrange  != nil)
                || ((addTwoTxtFiled.text?.count)! > 0 && addTwoTxtFiled.text?.last  == " " && rowrange != nil)  {
                    return false
                }else{
                    return true
                }
        }
        
        if textField == pinCodeTxtField{
            if pinCodeTxtField.text?.count == 5{
                if (pinCodeTxtField.text! + string).count == 6{
                    pinCodeTxtField.text = pinCodeTxtField.text! + string
                    print(pinCodeTxtField.text)
                    delegate?.change(pinNum: pinCodeTxtField.text!)
                    
                    
                }else{
                    stateDropDown.text?.removeAll()
                    cityDropDown.text?.removeAll()
                    areaDropDown.text?.removeAll()
                }
                print(pinCodeTxtField.text! + string)
                
               
            }
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
        case personNameTxtFiled :
            if textField  == personNameTxtFiled{
                if personNameTxtFiled.text!.count > 3 && personNameTxtFiled.text!.count <= 256{
                    contactLblHeight.constant = 0.0
                    contactErrorLbl.layoutIfNeeded()
                    
                    emailTxtFIeld.becomeFirstResponder()
                    
                    
                }else{
                    self.personNameTxtFiled.resignFirstResponder()
                    contactLblHeight.constant = 11.0
                    contactErrorLbl.layoutIfNeeded()
                    
                    contactErrorLbl.isHidden = false
                    contactErrorLbl.text = "Enter the valid name 3 - 16 character"
                    //                        personNameTxtField.layer.borderColor = UIColor.red.cgColor
                    //                        UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                }
            }
        case self.emailTxtFIeld:
            
            
            if (emailTxtFIeld.text?.isValidEmail(testStr: emailTxtFIeld.text!) == true) && emailTxtFIeld.text?.count != 0{
                
                emailErrorHeight.constant = 0.0
                emailErrorLbl.layoutIfNeeded()
                
                addOneTxtFiled.becomeFirstResponder()
            }else{
                emailTxtFIeld.resignFirstResponder()
                
                emailErrorHeight.constant = 11.0
                emailErrorLbl.layoutIfNeeded()
                
                emailErrorLbl.isHidden = false
                emailErrorLbl.text = "Please enter the valid Email"
                //                        emailTxtField.layer.borderColor = UIColor.red.cgColor
                //                          UIView().showToast(message: "Please enter the valid email", view: self.view)
            }
        case self.addOneTxtFiled:
            if addOneTxtFiled.text?.count != 0 && addOneTxtFiled.text!.count <= 20{
                
                addOneErrHeight.constant = 0.0
                addOneErrorLbl.layoutIfNeeded()
                
                self.addTwoTxtFiled.becomeFirstResponder()
            }else{
                self.addOneTxtFiled.resignFirstResponder()
                
                addOneErrHeight.constant = 11.0
                addOneErrorLbl.layoutIfNeeded()
                
                addOneErrorLbl.isHidden = false
                addOneErrorLbl.text = "Fill the address - 1"
                //                    addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Fill the address - 1 ", view: self.view)
            }
        case self.addTwoTxtFiled:
            if addTwoTxtFiled.text?.count != 0 && addTwoTxtFiled.text!.count <= 20{
                
                addtwoErrHeight.constant = 0.0
                addTwoErrorLbl.layoutIfNeeded()
                
                self.pinCodeTxtField.resignFirstResponder()
            }else{
                
                self.addTwoTxtFiled.resignFirstResponder()
                
                addtwoErrHeight.constant = 11.0
                addTwoErrorLbl.layoutIfNeeded()
                
                addTwoErrorLbl.isHidden = false
                addTwoErrorLbl.text = "Fill the address - 2"
                //                    addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        case self.pinCodeTxtField:
            if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6{
                
                pinErrHeight.constant = 0.0
                pincodeErrorLbl.layoutIfNeeded()
                
                pinCodeTxtField.resignFirstResponder()
                
            }else{
                pinCodeTxtField.resignFirstResponder()
                
                pinErrHeight.constant = 11.0
                pincodeErrorLbl.layoutIfNeeded()
                
                pincodeErrorLbl.isHidden = false
                pincodeErrorLbl.text = "Pincode is error"
                //                    pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Pincode is error", view: self.view)
            }
            
        default:
            self.personNameTxtFiled.becomeFirstResponder()
        }
        return true
        
    }
    
}




