//
//  sellerRegistrationCell.swift
//  liveOrder
//
//  Created by Data Prime on 08/11/21.
//

import UIKit
import iOSDropDown

class sellerRegistrationCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var firmlegalLbl: UILabel!
    @IBOutlet weak var LicenseOneTxtField: DesignableUITextField!
    @IBOutlet weak var licenseTwoTxtField: DesignableUITextField!
    @IBOutlet weak var validTxtField: DesignableUITextField!
    @IBOutlet weak var gstTypeTxtField: DropDown!
    @IBOutlet weak var gstInNumTxtField: DesignableUITextField!
    @IBOutlet weak var naroticNumTxtField: DesignableUITextField!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var flilLbl: UILabel!
    
    
    @IBOutlet weak var licenseOneErrorLbl: UILabel!
    @IBOutlet weak var licensetwoErrorLbl: UILabel!
    @IBOutlet weak var validErrorLbl: UILabel!
    @IBOutlet weak var gsttypeErrorLbl: UILabel!
    @IBOutlet weak var gstinNumErrorLbl: UILabel!
    @IBOutlet weak var naroticErrorLbl: UILabel!
    
    @IBOutlet weak var licenseOneHeight: NSLayoutConstraint!
    
    @IBOutlet weak var licensetwoHeight: NSLayoutConstraint!
    @IBOutlet weak var valitHeight: NSLayoutConstraint!
    @IBOutlet weak var gstTypeHeight: NSLayoutConstraint!
    @IBOutlet weak var gstinNumHeight: NSLayoutConstraint!
    @IBOutlet weak var naroticHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    func setup(){
        licenseOneErrorLbl.isHidden = true
        licensetwoErrorLbl.isHidden = true
        validErrorLbl.isHidden = true
        gsttypeErrorLbl.isHidden = true
        gstinNumErrorLbl.isHidden = true
        naroticErrorLbl.isHidden = true
        
        
        LicenseOneTxtField.delegate = self
        licenseTwoTxtField.delegate = self
        validTxtField.delegate = self
        gstInNumTxtField.delegate = self
        naroticNumTxtField.delegate = self
        
        let gstTxt = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))
        
        gstTxt.image = UIImage(named: "stateicon")
        let stateview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView.addSubview(gstTxt)
        stateview.addSubview(emptyView)
        gstTypeTxtField.leftView = stateview
        emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        stateview.backgroundColor = .white
        emptyView.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        gstTypeTxtField.translatesAutoresizingMaskIntoConstraints = false
        gstTypeTxtField.leftViewMode = .always
        
        
        licenseOneErrorLbl.isHidden = true
        licensetwoErrorLbl.isHidden = true
        validErrorLbl.isHidden = true
        gsttypeErrorLbl.isHidden = true
        gstinNumErrorLbl.isHidden = true
        naroticErrorLbl.isHidden = true
        
        licenseOneHeight.constant = 0.0
        licenseOneErrorLbl.layoutIfNeeded()
        licensetwoHeight.constant = 0.0
        licensetwoErrorLbl.layoutIfNeeded()
        valitHeight.constant = 0.0
        validErrorLbl.layoutIfNeeded()
        gstTypeHeight.constant = 0.0
        gsttypeErrorLbl.layoutIfNeeded()
        gstinNumHeight.constant = 0.0
        gstinNumErrorLbl.layoutIfNeeded()
        naroticHeight.constant = 0.0
        naroticErrorLbl.layoutIfNeeded()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension sellerRegistrationCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.LicenseOneTxtField{
            
            
            //            userNameTxtfiled.layer.shadowRadius = 1
            //            userNameTxtfiled.layer.shadowOffset = CGSize(width: 1, height: 1)
            licenseOneErrorLbl.isHidden = true
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            LicenseOneTxtField.alpha = 0.5
            LicenseOneTxtField.placeholder = "Drug number one"
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
            
            
            
        }else if textField == self.licenseTwoTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            licensetwoErrorLbl.isHidden = true
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            licenseTwoTxtField.alpha = 0.5
            licenseTwoTxtField.placeholder = "Drug number two"
            
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
        }else if textField == self.validTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            validErrorLbl.isHidden = true
            validTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            validTxtField.alpha = 0.5
            validTxtField.placeholder = "Valid"
            
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
        }else if textField == self.gstTypeTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            gsttypeErrorLbl.isHidden = true
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            gstTypeTxtField.alpha = 0.5
            gstTypeTxtField.placeholder = "GST type"
            
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        else if textField == self.gstInNumTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            gstinNumErrorLbl.isHidden = true
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            gstInNumTxtField.alpha = 0.5
            gstInNumTxtField.placeholder = "GST Number"
            
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        else if textField == self.naroticNumTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            naroticErrorLbl.isHidden = true
            naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            naroticNumTxtField.alpha = 0.5
            naroticNumTxtField.placeholder = "narcotic Number"
            //  stateDropDown.textColor = .black
            LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == LicenseOneTxtField{
            
            if LicenseOneTxtField.text!.count > 3 && LicenseOneTxtField.text!.count <= 16{
                self.licenseTwoTxtField.becomeFirstResponder()
                licenseOneHeight.constant = 0.0
                licenseOneErrorLbl.layoutIfNeeded()
            }else{
                
                self.LicenseOneTxtField.resignFirstResponder()
                licenseOneHeight.constant = 11.0
                licenseOneErrorLbl.layoutIfNeeded()
                licenseOneErrorLbl.isHidden = false
                licenseOneErrorLbl.text = "Please enter the valid drug license one"
                //                LicenseOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Please enter the valid drug license one", view: self.view)
            }
        }
        if textField == licenseTwoTxtField {
            if licenseTwoTxtField.text!.count > 3 && licenseTwoTxtField.text!.count <= 16{
                self.validTxtField.becomeFirstResponder()
                licensetwoHeight.constant = 0.0
                licensetwoErrorLbl.layoutIfNeeded()
            }else{
                
                self.licenseTwoTxtField.resignFirstResponder()
                licensetwoHeight.constant = 11.0
                licensetwoErrorLbl.layoutIfNeeded()
                licensetwoErrorLbl.isHidden = false
                licensetwoErrorLbl.text = "Please enter the valid drug license two"
                //                licenseTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
            }
        }
        if textField == validTxtField{
            if  validTxtField.text?.count != 0 && validTxtField.text!.count <= 10{
                self.validTxtField.resignFirstResponder()
                gstTypeTxtField.showList()
                valitHeight.constant = 0.0
                validErrorLbl.layoutIfNeeded()
            }else{
                self.validTxtField.resignFirstResponder()
                valitHeight.constant = 11.0
                validErrorLbl.layoutIfNeeded()
                validErrorLbl.isHidden = false
                validErrorLbl.text = "enter the valid date"
                //                validTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "enter the valid date ", view: self.view)
            }
        }
        if textField == gstInNumTxtField{
            if gstInNumTxtField.text?.count != 0 && gstInNumTxtField.text!.count <= 16{
                self.naroticNumTxtField.becomeFirstResponder()
                gstinNumHeight.constant = 0.0
                gstinNumErrorLbl.layoutIfNeeded()
            }else{
                self.gstInNumTxtField.resignFirstResponder()
                gstinNumHeight.constant = 11.0
                gstinNumErrorLbl.layoutIfNeeded()
                gstinNumErrorLbl.isHidden = false
                gstinNumErrorLbl.text = "GST number"
                //                gstNumTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "GST number  ", view: self.view)
            }
        }
        if textField == naroticNumTxtField {
            if  naroticNumTxtField.text?.count != 0 && naroticNumTxtField.text!.count <= 16{
                naroticNumTxtField.resignFirstResponder()
                naroticHeight.constant = 0.0
                naroticErrorLbl.layoutIfNeeded()
            }else{
                naroticNumTxtField.resignFirstResponder()
                naroticHeight.constant = 11.0
                naroticErrorLbl.layoutIfNeeded()
                naroticErrorLbl.isHidden = false
                naroticErrorLbl.text = "Narotic number"
                //                naroticNumTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Narotic number", view: self.view)
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        
        
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField{
        case LicenseOneTxtField :
            if textField  == LicenseOneTxtField{
                if LicenseOneTxtField.text!.count > 3 && LicenseOneTxtField.text!.count <= 16{
                    licenseOneHeight.constant = 0.0
                    licenseOneErrorLbl.layoutIfNeeded()
                    licenseTwoTxtField.becomeFirstResponder()
                    
                }else{
                    self.LicenseOneTxtField.resignFirstResponder()
                    licenseOneHeight.constant = 11.0
                    licenseOneErrorLbl.layoutIfNeeded()
                    licenseOneErrorLbl.isHidden = false
                    licenseOneErrorLbl.text = "Please enter the valid drug license one"
                    //                        LicenseOneTxtField.layer.borderColor = UIColor.red.cgColor
                    //                        UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
                }
            }
            
        case self.licenseTwoTxtField:
            
            
            if licenseTwoTxtField.text!.count > 3 && licenseTwoTxtField.text!.count <= 16{
                licensetwoHeight.constant = 0.0
                licensetwoErrorLbl.layoutIfNeeded()
                validTxtField.becomeFirstResponder()
            }else{
                licenseTwoTxtField.resignFirstResponder()
                licensetwoHeight.constant = 11.0
                licensetwoErrorLbl.layoutIfNeeded()
                licensetwoErrorLbl.isHidden = false
                licensetwoErrorLbl.text = "Please enter the valid drug license two"
                //                        licenseTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                          UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
            }
        case self.validTxtField:
            if validTxtField.text?.count != 0 && validTxtField.text!.count <= 10{
                self.validTxtField.resignFirstResponder()
                valitHeight.constant = 0.0
                validErrorLbl.layoutIfNeeded()
            }else{
                self.validTxtField.resignFirstResponder()
                valitHeight.constant = 11.0
                validErrorLbl.layoutIfNeeded()
                validErrorLbl.isHidden = false
                validErrorLbl.text = "enter the valid date"
                //                    validTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Valid date error ", view: self.view)
            }
        case self.gstTypeTxtField:
            if gstTypeTxtField.text?.count != 0 && gstTypeTxtField.text!.count <= 20{
                gstTypeHeight.constant = 0.0
                gstTypeTxtField.layoutIfNeeded()
                self.gstInNumTxtField.becomeFirstResponder()
            }else{
                
                self.gstTypeTxtField.resignFirstResponder()
                gstTypeHeight.constant = 11.0
                gstTypeTxtField.layoutIfNeeded()
                gsttypeErrorLbl.isHidden = false
                gsttypeErrorLbl.text = "enter GST"
                //                    gstTypeTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "GST type error ", view: self.view)
            }
        case self.gstInNumTxtField:
            if  gstInNumTxtField.text?.count != 0 && gstInNumTxtField.text!.count <= 16{
                naroticNumTxtField.becomeFirstResponder()
                gstinNumHeight.constant = 0.0
                gstinNumErrorLbl.layoutIfNeeded()
                
            }else{
                gstInNumTxtField.resignFirstResponder()
                gstinNumHeight.constant = 11.0
                gstinNumErrorLbl.layoutIfNeeded()
                gstinNumErrorLbl.isHidden = false
                gstinNumErrorLbl.text = "GSTIN number"
                //                    gstNumTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "GST number is error", view: self.view)
            }
        case self.naroticNumTxtField:
            if  naroticNumTxtField.text?.count != 0 && naroticNumTxtField.text!.count <= 16{
                naroticNumTxtField.resignFirstResponder()
                naroticHeight.constant = 0.0
                naroticErrorLbl.layoutIfNeeded()
                
            }else{
                naroticNumTxtField.resignFirstResponder()
                naroticHeight.constant = 11.0
                naroticErrorLbl.layoutIfNeeded()
                naroticErrorLbl.isHidden = false
                naroticErrorLbl.text = "Narotic number is error"
                //                    naroticNumTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Narotic number is error", view: self.view)
            }
            
        default:
            self.LicenseOneTxtField.becomeFirstResponder()
        }
        return true
        
    }
    
    
}
