//
//  CombinePopUpVC.swift
//  liveOrder
//
//  Created by Data Prime on 07/12/21.
//
protocol swipeActDelecate{
    func swipeUp(yes:String)
    func confirm(tapped:Bool)
}
import UIKit
import iOSDropDown
import SystemConfiguration
import Alamofire
import NotificationBannerSwift

class CombinePopUpVC: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var dotView: DashedLineView!
    @IBOutlet weak var PopscrollView: UIScrollView!
    @IBOutlet weak var scrollInnerView: UIView!
    
    @IBOutlet weak var storeNameTxtField: DesignableUITextField!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var fistAidNumTxtField: DesignableUITextField!
    @IBOutlet weak var firstAidErrorLbl: UILabel!
    
    @IBOutlet weak var gstTxtField: DesignableUITextField!
    @IBOutlet weak var gstErrolLbl: UILabel!
    @IBOutlet weak var adddressTxtField: DesignableUITextField!
    @IBOutlet weak var addressErrorLbl: UILabel!
    @IBOutlet weak var pinCodeTxtField: DesignableUITextField!
    @IBOutlet weak var pinErrorLbl: UILabel!
    @IBOutlet weak var stateTxtField: DesignableUITextField!
    @IBOutlet weak var stateErrorLbl: UILabel!
    @IBOutlet weak var cityTxtField: DesignableUITextField!
    @IBOutlet weak var cityErrorLbl: UILabel!
    @IBOutlet weak var areaDropDown: DropDown!
    @IBOutlet weak var areaErrorLbl: UILabel!
    
    @IBOutlet weak var emailTxtField: DesignableUITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    
    //MARK :- ERROR LABEL HEIGHT CONSTRAINS
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var firstaidHeight: NSLayoutConstraint!
    @IBOutlet weak var gstHeight: NSLayoutConstraint!
    @IBOutlet weak var addressHeight: NSLayoutConstraint!
    @IBOutlet weak var pinHeight: NSLayoutConstraint!
    @IBOutlet weak var stateHeight: NSLayoutConstraint!
    @IBOutlet weak var cityHeight: NSLayoutConstraint!
    @IBOutlet weak var areaHeight: NSLayoutConstraint!
    @IBOutlet weak var emailHeight: NSLayoutConstraint!
    
    // MARK :- BOTTOM VIEW OUTLET
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    var pinWiseStateModel:PinWiseStateModel?
    var firmUpdateModel : FirmUpdateModel?
    
    var delegate : swipeActDelecate?
    
    var storeName : String?
    var drugLic : String?
    var gstinNum:String?
    var email:String?
    var address:String?
    var pinCode:String?
    var state:String?
    var city:String?
    var area : String?
    var stateCode:String?
    var cityCode:String?
    var areaCode:String?
    var brCode:String?
    var addTwo:String?
    
   
    var aNameArray = [String]()
    var aCodeArray = [String]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        self.gstTxtField.autocapitalizationType = .allCharacters
        stateApi(pin: pinCode ?? "")
        stateTxtField.isUserInteractionEnabled = false
        cityTxtField.isUserInteractionEnabled = false
        storeNameTxtField.text = storeName
        fistAidNumTxtField.text = drugLic
        gstTxtField.text = gstinNum
        emailTxtField.text = email
        pinCodeTxtField.text = pinCode
        stateTxtField.text = state
        cityTxtField.text = city
        areaDropDown.text = area
        adddressTxtField.text = addTwo
        storeNameTxtField.delegate = self
        fistAidNumTxtField.delegate = self
        emailTxtField.delegate = self
        adddressTxtField.delegate = self
        gstTxtField.delegate = self
        pinCodeTxtField.delegate = self
        stateTxtField.delegate = self
        cityTxtField.delegate = self
      
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
        nameHeight.constant = 0
        nameErrorLbl.layoutIfNeeded()
        firstaidHeight.constant = 0
        firstAidErrorLbl.layoutIfNeeded()
        gstHeight.constant = 0
        gstErrolLbl.layoutIfNeeded()
        emailHeight.constant = 0
        emailErrorLbl.layoutIfNeeded()
        addressHeight.constant = 0
        addressErrorLbl.layoutIfNeeded()
        pinHeight.constant = 0
        pinErrorLbl.layoutIfNeeded()
        stateHeight.constant = 0
        stateErrorLbl.layoutIfNeeded()
        cityHeight.constant = 0
        cityErrorLbl.layoutIfNeeded()
        areaHeight.constant = 0
        areaErrorLbl.layoutIfNeeded()
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.gstTxtField.text = "33AABCU9603R1ZU"

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            // TODO: Do your stuff here.
            delegate?.swipeUp(yes: "Yes")
        }
    }
    @IBAction func confirmBtnAct(_ sender: Any) {
        if storeNameTxtField.text?.count != 0 && fistAidNumTxtField.text?.count != 0 && gstTxtField.text?.count != 0 && gstTxtField.text?.gstValid(gstNum: gstTxtField.text!) == true && pinCodeTxtField.text?.count == 6 && stateTxtField.text?.count != 0 && cityTxtField.text?.count != 0 && areaDropDown.text?.count != 0{
             updateApi()
        }
    }
    
    @IBAction func cancelBtnAct(_ sender: Any) {
        delegate?.confirm(tapped: true)
        delegate?.confirm(tapped: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CombinePopUpVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.stateTxtField{
            
            nameHeight.constant = 0.0
            nameErrorLbl.layoutIfNeeded()
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            storeNameTxtField.placeholder = "Store Name"
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
            
        }else if textField == self.fistAidNumTxtField{
            
            firstaidHeight.constant = 0.0
            firstAidErrorLbl.layoutIfNeeded()
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            fistAidNumTxtField.placeholder = "Drug License Number"
            
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.gstTxtField{
            
            gstHeight.constant = 0.0
            gstErrolLbl.layoutIfNeeded()
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            gstTxtField.placeholder = "GSTIN Number"
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.emailTxtField{
            
            emailHeight.constant = 0.0
            emailErrorLbl.layoutIfNeeded()
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            emailTxtField.placeholder = "Email ID"
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.adddressTxtField{
             
            
            addressHeight.constant = 0.0
            addressErrorLbl.layoutIfNeeded()
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            adddressTxtField.placeholder = "Address"
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.pinCodeTxtField{
            
            pinHeight.constant = 0.0
            pinErrorLbl.layoutIfNeeded()
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            pinCodeTxtField.placeholder = "Pincode"
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.stateTxtField{
            
            stateHeight.constant = 0.0
            stateErrorLbl.layoutIfNeeded()
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            stateTxtField.placeholder = "PinCode"
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.cityTxtField{
        
            cityHeight.constant = 0.0
            cityErrorLbl.layoutIfNeeded()
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            cityTxtField.placeholder = "State"
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        else if textField == self.areaDropDown{
           
            areaHeight.constant = 0.0
            areaErrorLbl.layoutIfNeeded()
            areaDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            areaDropDown.placeholder = "City"
            storeNameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            fistAidNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            emailTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            adddressTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == storeNameTxtField{
            
            if storeNameTxtField.text!.count > 3 && storeNameTxtField.text!.count <= 256{
                fistAidNumTxtField
                nameHeight.constant = 0.0
                nameErrorLbl.layoutIfNeeded()
                
            }else{
                
                self.storeNameTxtField.resignFirstResponder()
                nameHeight.constant = 11.0
                nameErrorLbl.layoutIfNeeded()
                nameErrorLbl.isHidden = false
                nameErrorLbl.text = "Enter the valid name 3 - 256 character"
                
            }
        }
        if textField == fistAidNumTxtField{
            if fistAidNumTxtField.text?.count != 0 && fistAidNumTxtField.text!.count <= 20{
                
                firstaidHeight.constant = 0.0
                firstAidErrorLbl.layoutIfNeeded()
                
                self.gstTxtField.resignFirstResponder()
            }else{
                self.fistAidNumTxtField.resignFirstResponder()
                
                firstaidHeight.constant = 11.0
                firstAidErrorLbl.layoutIfNeeded()
                
                firstAidErrorLbl.isHidden = false
                firstAidErrorLbl.text = " Fill the Drug License Number"
                //                addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == gstTxtField{
            if gstTxtField.text?.count != 0 && gstTxtField.text?.gstValid(gstNum: gstTxtField.text!) == true {
                
                gstHeight.constant = 0.0
                gstErrolLbl.layoutIfNeeded()
                
                self.adddressTxtField.becomeFirstResponder()
            }else{
                self.adddressTxtField.resignFirstResponder()
                
                gstHeight.constant = 11.0
                gstErrolLbl.layoutIfNeeded()
                
                gstErrolLbl.isHidden = false
                gstErrolLbl.text = "Fill the Valid Gstin Number"
                //                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == emailTxtField{
            if emailTxtField.text?.isValidEmail(testStr: emailTxtField.text!) == true {
                let emailTextStr = self.emailTxtField.text ?? ""
                
                if emailTextStr.contains(".com.com") {
                    emailHeight.constant = 11.0
                    emailErrorLbl.layoutIfNeeded()
                    emailErrorLbl.isHidden = false
                    emailErrorLbl.text = "Fill the Valid Email"
                    
                }else{
                    emailHeight.constant = 0.0
                    emailErrorLbl.layoutIfNeeded()
                }
               
                
                self.adddressTxtField.becomeFirstResponder()
            }else{
                self.adddressTxtField.resignFirstResponder()
                
                emailHeight.constant = 11.0
                emailErrorLbl.layoutIfNeeded()
                
                emailErrorLbl.isHidden = false
                emailErrorLbl.text = "Fill the Valid Email"
                //                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == adddressTxtField {
            if  adddressTxtField.text?.count != 0 && adddressTxtField.text!.count <= 256{
                
                addressHeight.constant = 0.0
                addressErrorLbl.layoutIfNeeded()
                
                self.pinCodeTxtField.resignFirstResponder()
            }else{
                self.pinCodeTxtField.resignFirstResponder()
                
                addressHeight.constant = 11.0
                addressErrorLbl.layoutIfNeeded()
                
                addressErrorLbl.isHidden = false
                addressErrorLbl.text = "Fill the Address"
                //                pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Pincode is error", view: self.view)
            }
            
        }
        if textField == pinCodeTxtField {
            
            if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6  {
                print(pinCodeTxtField.text)
                let isValidPinCode = validZipCode(postalCode:pinCodeTxtField.text!)
             
                
                if isValidPinCode == true{
                    stateApi(pin: pinCodeTxtField.text ?? "")

                    pinHeight.constant = 0.0
                    pinErrorLbl.layoutIfNeeded()
                    pinErrorLbl.isHidden = true

                }else{
                    pinErrorLbl.text = "Invalid Pincode"
                    pinCodeTxtField.resignFirstResponder()
                    pinHeight.constant = 11.0
                    pinErrorLbl.layoutIfNeeded()
                    pinErrorLbl.isHidden = false

                }
    
            }else{
               
                    pinErrorLbl.text = "Fill Pincode"
                    pinCodeTxtField.resignFirstResponder()
                    pinHeight.constant = 11.0
                    pinErrorLbl.layoutIfNeeded()
                    pinErrorLbl.isHidden = false

                
               
                //                    pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Pincode is error", view: self.view)
            }

        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == pinCodeTxtField{
            if pinCodeTxtField.text?.count == 5{
                if (pinCodeTxtField.text! + string).count == 6{
                    
                        pinCodeTxtField.text = pinCodeTxtField.text! + string
                        stateApi(pin: pinCodeTxtField.text ?? "")
                
                    
                }else{
                    areaDropDown.text?.removeAll()
                   
                }

            }
            let maxLength = 6          // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField == adddressTxtField{
            let rawString = string
            let rowrange = rawString.rangeOfCharacter(from: .whitespaces)
                if ((adddressTxtField.text?.count)! == 0 && rowrange  != nil)
                || ((adddressTxtField.text?.count)! > 0 && adddressTxtField.text?.last  == " " && rowrange != nil)  {
                    return false
                }else{
                    return true
                }
        }
        if textField == gstTxtField{
            let maxLength = 15
              let currentString: NSString = textField.text! as NSString
              let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
              return newString.length <= maxLength
        }
        
        
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField{
        case storeNameTxtField :
            if textField  == storeNameTxtField{
                if storeNameTxtField.text!.count > 3 && storeNameTxtField.text!.count <= 256{
                    nameHeight.constant = 0.0
                    nameErrorLbl.layoutIfNeeded()
                    
                    fistAidNumTxtField.becomeFirstResponder()
                    
                    
                }else{
                    self.storeNameTxtField.resignFirstResponder()
                    nameHeight.constant = 11.0
                    nameErrorLbl.layoutIfNeeded()
                    
                    nameErrorLbl.isHidden = false
                    nameErrorLbl.text = "Enter the valid name 3 - 16 character"
                    //                        personNameTxtField.layer.borderColor = UIColor.red.cgColor
                    //                        UIView().showToast(message: "should contain 4 - 16 character", view: self.view)
                }
            }
        
        case self.fistAidNumTxtField:
            if fistAidNumTxtField.text?.count != 0 && fistAidNumTxtField.text!.count <= 20{
                
                firstaidHeight.constant = 0.0
                firstAidErrorLbl.layoutIfNeeded()
                
                self.gstTxtField.becomeFirstResponder()
            }else{
                self.fistAidNumTxtField.resignFirstResponder()
                
                firstaidHeight.constant = 11.0
                firstAidErrorLbl.layoutIfNeeded()
                
                firstAidErrorLbl.isHidden = false
                firstAidErrorLbl.text = "Fill Drug License No"
                //                    addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Fill the address - 1 ", view: self.view)
            }
        case self.gstTxtField:
            if gstTxtField.text?.count != 0 && gstTxtField.text?.gstValid(gstNum: gstTxtField.text!) == true{
                
                gstHeight.constant = 0.0
                gstErrolLbl.layoutIfNeeded()
                
                self.adddressTxtField.resignFirstResponder()
            }else{
                
                self.gstTxtField.resignFirstResponder()
                
                gstHeight.constant = 11.0
                gstErrolLbl.layoutIfNeeded()
                
                gstErrolLbl.isHidden = false
                gstErrolLbl.text = "Fill Gstin Number "
                //                    addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        case self.adddressTxtField:
            if  adddressTxtField.text?.count != 0 && adddressTxtField.text!.count <= 256{
                
                addressHeight.constant = 0.0
                addressErrorLbl.layoutIfNeeded()
                
                pinCodeTxtField.resignFirstResponder()
                
            }else{
                pinCodeTxtField.resignFirstResponder()
                
                addressHeight.constant = 11.0
                addressErrorLbl.layoutIfNeeded()
                
                addressErrorLbl.isHidden = false
                addressErrorLbl.text = "Fill Address"
                //                    pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Pincode is error", view: self.view)
            }
        case self.pinCodeTxtField:
            let isValidPinCode = validZipCode(postalCode:pinCodeTxtField.text!)
            
            if  pinCodeTxtField.text?.count != 0 && pinCodeTxtField.text!.count == 6 && isValidPinCode == true {
              
                pinHeight.constant = 0.0
                pinErrorLbl.layoutIfNeeded()
                
                pinCodeTxtField.resignFirstResponder()
                
            }else{
               
                if isValidPinCode == true{
                    pinErrorLbl.text = "Fill Pincode"
                    pinCodeTxtField.resignFirstResponder()
                    
                    pinHeight.constant = 11.0
                    pinErrorLbl.layoutIfNeeded()
                    pinErrorLbl.isHidden = false

                }else{
                    pinErrorLbl.text = "Invalid Pincode"
                    pinCodeTxtField.resignFirstResponder()
                    pinHeight.constant = 11.0
                    pinErrorLbl.layoutIfNeeded()
                    pinErrorLbl.isHidden = false

                }
               
                //                    pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                    UIView().showToast(message: "Pincode is error", view: self.view)
            }
            
        default: break
          
        }
        return true
        
    }
}




extension CombinePopUpVC:WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func stateApi(pin : String){
        aNameArray.removeAll()
        aCodeArray.removeAll()
        areaCode?.removeAll()
        area?.removeAll()
        cityCode?.removeAll()
        stateCode?.removeAll()
        let stateApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "stateApi")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"nzFXijLYZzDo7ycoym2ZHw==",
        //                                    "X-csquare-api-token":"17921411192f044a",
        //                                    "Content-Type":"application/json",
        //        ]
        
        let stateApiParams = ["c_pincode": pin]
        
        let stateApiHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
        ]
        print(stateApiHeader)
        
        stateApi.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PINCODE_WISE_STATE_SEARCH, type: .post, userData: stateApiParams, apiHeader: stateApiHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            pinWiseStateModel = PinWiseStateModel(object: dict)
            if boolSuccess {
                if pinWiseStateModel?.appStatusCode == 0 {
                    state = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateTxtField.text = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                    city = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityTxtField.text = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""
                    for (ins,element) in (pinWiseStateModel?.payloadJson?.data?.jAreaList)!.enumerated(){
                        aCodeArray.append( element.cAreaCode ?? "")
                        aNameArray.append(element.cAreaName ?? "")
                        
                    }
                    areaDropDown.optionArray = aNameArray
                
                    areaDropDown.arrowColor = UIColor(hexString: "5b636a")
                    areaDropDown.didSelect{(selectedText , index ,id) in
                        self.areaCode = self.aCodeArray[index]
                        print(self.areaCode)
                        self.area = selectedText
                        print(self.area)
                        areaDropDown.text = "\(selectedText)"

                        
                }
                    hideActivityIndicator(self.view)

                }else{
                    areaDropDown.optionArray = aNameArray
                    hideActivityIndicator(self.view)

                }
                
                
            }else{
                areaDropDown.optionArray = aNameArray
                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            areaDropDown.optionArray = aNameArray

            hideActivityIndicator(self.view)
        
        })
        
    }
    func updateApi(){

        let update:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "update")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //

        let updateParams: [String: Any] = ["c_address_no1": adddressTxtField.text ?? "",
                                           "c_address_no2": addTwo ?? "",
                                           "c_area_code":  areaCode ?? "",
                                           "c_area_name": area ?? "",
                                           "c_br_code": brCode ?? "",
                                           "c_city_code": cityCode ?? "",
                                           "c_city_name": city ?? "",
                                           "c_drug_license_no": fistAidNumTxtField.text ?? "",
                                           "c_firm_name": storeNameTxtField.text ?? "",
                                           "c_gst_number": gstTxtField.text ?? "",
                                           "c_pincode": pinCodeTxtField.text ?? "",
                                           "c_state_code": stateCode ?? "",
                                           "c_state_name": state ?? ""
        ]
        print(updateParams)



        let updateHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]

        update.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + COMBAIN_FIRM_UPDATE_STORE, type: .post, userData: updateParams, apiHeader: updateHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmUpdateModel = FirmUpdateModel(object: dict)
            if boolSuccess {
                if firmUpdateModel?.appStatusCode == 0{
                    let banner = NotificationBanner(title: "Message", subtitle: self.firmUpdateModel?.messages?[0], style: .info)
                    banner.showToast(message: self.firmUpdateModel?.messages?[0] ?? "", view: self.view)
                    delegate?.confirm(tapped: true)
                    self.dismiss(animated: true, completion: nil)
                    
//                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:          self.view.frame.size.height)
//
//                    self.MobileExistsView?.Mobdelegate = self
//                    self.MobileExistsView?.addsellerBtn.setTitle("Cart", for: .normal)
//                    self.MobileExistsView?.loopImage.image = UIImage(named: "icon for success ")
//                    self.MobileExistsView?.txtLbl.text = self.firmUpdateModel?.messages?[0]
//                    self.view.addSubview(self.MobileExistsView!)

                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.firmUpdateModel?.messages?[0], style: .info)
                    banner.showToast(message: self.firmUpdateModel?.messages?[0] ?? "", view: self.view)
                }



            }else{


            }

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
//            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//
//           // self.MobileExistsView?.Mobdelegate = self
//            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
//            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
//            let colorString = "Mobile Number "
//            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
//            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
//            self.view.addSubview(self.MobileExistsView!)
        })


    }
}
