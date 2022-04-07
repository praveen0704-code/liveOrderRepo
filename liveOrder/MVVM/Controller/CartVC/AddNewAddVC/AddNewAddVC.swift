//
//  AddNewAddVC.swift
//  liveOrder
//
//  Created by Data Prime on 06/01/22.
//

import UIKit
import iOSDropDown
import Alamofire
import NotificationBannerSwift

class AddNewAddVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var NewAddLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var locImgView: UIImageView!
    @IBOutlet weak var usingGpsLbl: UILabel!
    @IBOutlet weak var lilneView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var innerVIew: UIView!
    @IBOutlet weak var shopTxtField: DesignableUITextField!
    @IBOutlet weak var shopErrorLbl: UILabel!
    @IBOutlet weak var nameTxtField: DesignableUITextField!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var mobileTxtField: DesignableUITextField!
    @IBOutlet weak var mobileErrorLbl: UILabel!
    @IBOutlet weak var addOneTxtField: DesignableUITextField!
    @IBOutlet weak var addOneErrorLbl: UILabel!
    @IBOutlet weak var addTwoTxtField: DesignableUITextField!
    @IBOutlet weak var addTwoLbl: UILabel!
    @IBOutlet weak var pincodeTxtField: DesignableUITextField!
    @IBOutlet weak var pincodeErrorLbl: UILabel!
    @IBOutlet weak var stateTxtField: DesignableUITextField!
    @IBOutlet weak var stateErrorLbl: UILabel!
    @IBOutlet weak var cityTxtField: DesignableUITextField!
    @IBOutlet weak var cityErrorLbl: UILabel!
    @IBOutlet weak var areaTxtField: DropDown!
    @IBOutlet weak var areaErrorLbl: UILabel!
    @IBOutlet weak var addTypeLbl: UILabel!
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var saveBtn: UIButton!
    
    //MARK:- HEIGHT
    
    @IBOutlet weak var shopErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var nameErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var addOneErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var addTwoErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var pincodeErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var stateErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var cityErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var areaErrorHeight: NSLayoutConstraint!
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var getBranchDetailsModel :GetBranchDetailsModel?
    var firmProfileModel : FirmProfileModel?
    var pinWiseStateModel : PinWiseStateModel?
    var firmUpdateModel : FirmUpdateModel?
    var stateName : String?
    var cityName : String?
    var stateCode : String?
    var cityCode : String?
    var areaCode : String?
    var aNameArray = [String]()
    var aCodeArray = [String]()
    var selectedAreaCode : String?
    var selectedAreaName : String?
    
    var pincode : String?
    var edit = 0
    var brCode :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        if edit == 1{
            getBranchDetails(brCodeDetails: brCode ?? "")
        }else{
            
        }
        shopTxtField.isUserInteractionEnabled = false
        nameTxtField.isUserInteractionEnabled = false
        mobileTxtField.isUserInteractionEnabled  = false
        stateTxtField.isUserInteractionEnabled = false
        cityTxtField.isUserInteractionEnabled = false
        shopErrorHeight.constant = 0
        shopErrorLbl.layoutIfNeeded()
        nameErrorHeight.constant = 0
        nameErrorLbl.layoutIfNeeded()
        mobileErrorHeight.constant = 0
        mobileErrorLbl.layoutIfNeeded()
        addOneErrorHeight.constant = 0
        addOneErrorLbl.layoutIfNeeded()
        addTwoErrorHeight.constant = 0
        addTwoLbl.layoutIfNeeded()
        pincodeErrorHeight.constant = 0
        pincodeErrorLbl.layoutIfNeeded()
        stateErrorHeight.constant = 0
        stateErrorLbl.layoutIfNeeded()
        cityErrorHeight.constant = 0
        cityErrorLbl.layoutIfNeeded()
        areaErrorHeight.constant = 0
        areaErrorLbl.layoutIfNeeded()
        shopTxtField.delegate = self
        nameTxtField.delegate = self
        mobileTxtField.delegate = self
        addOneTxtField.delegate = self
        addTwoTxtField.delegate = self
        pincodeTxtField.delegate = self
        stateTxtField.delegate = self
        cityTxtField.delegate = self
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        let arealeft = UIImageView(frame: CGRect(x: 19, y: 15, width: CGFloat(20), height: CGFloat(20)))
        
        arealeft.image = UIImage(named: "areaicon")
        let areaa = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView3.addSubview(arealeft)
        areaa.addSubview(emptyView3)
        areaTxtField.leftView = areaa
        emptyView3.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        areaa.backgroundColor = .white
        emptyView3.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        areaTxtField.translatesAutoresizingMaskIntoConstraints = false
        areaTxtField.leftViewMode = .always
        areaTxtField.arrowSize = 0
       
      
    }

    @IBAction func saveBtnAct(_ sender: Any) {
        if shopTxtField.text!.count > 2 && shopTxtField.text!.count <= 256 && nameTxtField.text!.count > 2 && nameTxtField.text!.count <= 256 &&  mobileTxtField.text!.count == 10 && addOneTxtField.text!.count > 2 && addOneTxtField.text!.count <= 256 && addTwoTxtField.text!.count > 2 && addTwoTxtField.text!.count <= 256 && pincodeTxtField.text!.count == 6 && stateTxtField.text!.count != 0 && cityTxtField.text!.count != 0 && areaTxtField.text!.count != 0{
            updateApi()
        }else{
            print("errr")
        }
        
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
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
extension AddNewAddVC: mobilexist{
    func mobileExisits(type: Int) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
extension AddNewAddVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.shopTxtField{
            shopErrorHeight.constant = 0
            shopErrorLbl.layoutIfNeeded()
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            shopTxtField.placeholder = "Person Name"
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
        }else if textField == self.nameTxtField{
            
            nameErrorHeight.constant = 0
            nameErrorLbl.layoutIfNeeded()
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            nameTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.mobileTxtField{
            
            mobileErrorHeight.constant = 0
            mobileErrorLbl.layoutIfNeeded()
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            mobileTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }else if textField == self.addOneTxtField{
            
            addOneErrorHeight.constant = 0
            addOneErrorLbl.layoutIfNeeded()
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            addOneTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.addTwoTxtField{
            
            addTwoErrorHeight.constant = 0
            addTwoLbl.layoutIfNeeded()
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            addTwoTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
        else if textField == self.pincodeTxtField{
            pincodeErrorHeight.constant = 0
            pincodeErrorLbl.layoutIfNeeded()
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            pincodeTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
        }
        else if textField == self.stateTxtField{
            stateErrorHeight.constant = 0
            stateErrorLbl.layoutIfNeeded()
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            stateTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        }
        else if textField == self.cityTxtField{
            cityErrorHeight.constant = 0
            cityErrorLbl.layoutIfNeeded()
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            cityTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }else {
            areaErrorHeight.constant = 0
            areaErrorLbl.layoutIfNeeded()
            areaTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            areaTxtField.placeholder = "Person Name"
            shopTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            mobileTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            nameTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            addTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            pincodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            stateTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            cityTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == shopTxtField{
            
            if shopTxtField.text!.count > 3 && shopTxtField.text!.count <= 256{
                self.nameTxtField.becomeFirstResponder()
                shopErrorHeight.constant = 0.0
                shopErrorLbl.layoutIfNeeded()
                
            }else{
                
                self.shopTxtField.resignFirstResponder()
                shopErrorHeight.constant = 11.0
                shopErrorLbl.layoutIfNeeded()
                shopErrorLbl.isHidden = false
                shopErrorLbl.text = "Enter the valid name 3 - 16 character"
                
            }
        }
        if textField == nameTxtField {
            if nameTxtField.text!.count > 2 && nameTxtField.text?.count != 0{
                
                nameErrorHeight.constant = 0.0
                nameErrorLbl.layoutIfNeeded()
                self.mobileTxtField.becomeFirstResponder()
            }else{
                self.nameTxtField.resignFirstResponder()
                
                nameErrorHeight.constant = 11.0
                nameErrorLbl.layoutIfNeeded()
                
                nameErrorLbl.isHidden = false
                nameErrorLbl.text = "Please enter the valid Name"
                //                emailTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Please enter the valid Email", view: self.view)
            }
        }
        if textField == mobileTxtField {
            if mobileTxtField.text!.count == 10 && mobileTxtField.text?.count != 0{
                
                mobileErrorHeight.constant = 0.0
                mobileErrorLbl.layoutIfNeeded()
                self.addOneTxtField.becomeFirstResponder()
            }else{
                self.mobileTxtField.resignFirstResponder()
                
                mobileErrorHeight.constant = 11.0
                mobileErrorLbl.layoutIfNeeded()
                
                mobileErrorLbl.isHidden = false
                mobileErrorLbl.text = "Please enter the valid Number"
                //                emailTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Please enter the valid Email", view: self.view)
            }
        }
        if textField == addOneTxtField{
            if addOneTxtField.text?.count != 0 && addOneTxtField.text!.count <= 256{
                
                addOneErrorHeight.constant = 0.0
                addOneErrorLbl.layoutIfNeeded()
                
                self.addTwoTxtField.resignFirstResponder()
            }else{
                self.addOneTxtField.resignFirstResponder()
                
                addOneErrorHeight.constant = 11.0
                addOneErrorLbl.layoutIfNeeded()
                
                addOneErrorLbl.isHidden = false
                addOneErrorLbl.text = "Fill the address - 1"
                //                addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == addTwoTxtField{
            if addTwoTxtField.text?.count != 0 && addTwoTxtField.text!.count <= 256{
                
                addTwoErrorHeight.constant = 0.0
                addTwoLbl.layoutIfNeeded()
                
                self.pincodeTxtField.resignFirstResponder()
            }else{
                self.addTwoTxtField.resignFirstResponder()
                
                addTwoErrorHeight.constant = 11.0
                addTwoLbl.layoutIfNeeded()
                
                addTwoLbl.isHidden = false
                addTwoLbl.text = "Fill the address - 2"
                //                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
            }
        }
        if textField == pincodeTxtField {
            if  pincodeTxtField.text?.count != 0 && pincodeTxtField.text!.count == 6{
                
                pincodeErrorHeight.constant = 0.0
                pincodeErrorLbl.layoutIfNeeded()
                
                self.pincodeTxtField.resignFirstResponder()
            }else{
                self.pincodeTxtField.resignFirstResponder()
                
                pincodeErrorHeight.constant = 11.0
                pincodeErrorLbl.layoutIfNeeded()
                
                pincodeErrorLbl.isHidden = false
                pincodeErrorLbl.text = "Pincode is error"
                //                pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                //                UIView().showToast(message: "Pincode is error", view: self.view)
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == pincodeTxtField{
            if pincodeTxtField.text?.count == 5{
                
                if (pincodeTxtField.text! + string).count == 6{
                    pincodeTxtField.text = pincodeTxtField.text! + string
                    print(pincodeTxtField.text)
                    stateApi(pin:  pincodeTxtField.text ?? "")
                    
                    
                    
                }else{
                    
                    aNameArray.removeAll()
                    areaTxtField.text = ""
                }
               
                
               
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
        case shopTxtField :
            if textField == shopTxtField{
                
                if shopTxtField.text!.count > 3 && shopTxtField.text!.count <= 256{
                    self.nameTxtField.becomeFirstResponder()
                    shopErrorHeight.constant = 0.0
                    shopErrorLbl.layoutIfNeeded()
                    
                }else{
                    
                    self.shopTxtField.resignFirstResponder()
                    shopErrorHeight.constant = 11.0
                    shopErrorLbl.layoutIfNeeded()
                    shopErrorLbl.isHidden = false
                    shopErrorLbl.text = "Enter the valid name 3 - 16 character"
                    
                }
            }
        case self.nameTxtField:
            
            if textField == nameTxtField {
                if nameTxtField.text!.count > 2 && nameTxtField.text?.count != 0{
                    
                    nameErrorHeight.constant = 0.0
                    nameErrorLbl.layoutIfNeeded()
                    self.mobileTxtField.becomeFirstResponder()
                }else{
                    self.nameTxtField.resignFirstResponder()
                    
                    nameErrorHeight.constant = 11.0
                    nameErrorLbl.layoutIfNeeded()
                    
                    nameErrorLbl.isHidden = false
                    nameErrorLbl.text = "Please enter the valid Name"
                    //                emailTxtField.layer.borderColor = UIColor.red.cgColor
                    //                UIView().showToast(message: "Please enter the valid Email", view: self.view)
                }
            }
        case self.mobileTxtField:
            if textField == mobileTxtField {
                if mobileTxtField.text!.count == 10 && mobileTxtField.text?.count != 0{
                    
                    mobileErrorHeight.constant = 0.0
                    mobileErrorLbl.layoutIfNeeded()
                    self.addOneTxtField.becomeFirstResponder()
                }else{
                    self.mobileTxtField.resignFirstResponder()
                    
                    mobileErrorHeight.constant = 11.0
                    mobileErrorLbl.layoutIfNeeded()
                    
                    mobileErrorLbl.isHidden = false
                    mobileErrorLbl.text = "Please enter the valid Number"
                    //                emailTxtField.layer.borderColor = UIColor.red.cgColor
                    //                UIView().showToast(message: "Please enter the valid Email", view: self.view)
                }
            }
        case self.addOneTxtField:
            if textField == addOneTxtField{
                if addOneTxtField.text?.count != 0 && addOneTxtField.text!.count <= 256{
                    
                    addOneErrorHeight.constant = 0.0
                    addOneErrorLbl.layoutIfNeeded()
                    
                    self.addTwoTxtField.resignFirstResponder()
                }else{
                    self.addOneTxtField.resignFirstResponder()
                    
                    addOneErrorHeight.constant = 11.0
                    addOneErrorLbl.layoutIfNeeded()
                    
                    addOneErrorLbl.isHidden = false
                    addOneErrorLbl.text = "Fill the address - 1"
                    //                addressOneTxtField.layer.borderColor = UIColor.red.cgColor
                    //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                }
            }
           
            
        case self.addTwoTxtField:
            if textField == addTwoTxtField{
                if addTwoTxtField.text?.count != 0 && addTwoTxtField.text!.count <= 256{
                    
                    addTwoErrorHeight.constant = 0.0
                    addTwoLbl.layoutIfNeeded()
                    
                    self.pincodeTxtField.resignFirstResponder()
                }else{
                    self.addTwoTxtField.resignFirstResponder()
                    
                    addTwoErrorHeight.constant = 11.0
                    addTwoLbl.layoutIfNeeded()
                    
                    addTwoLbl.isHidden = false
                    addTwoLbl.text = "Fill the address - 2"
                    //                addressTwoTxtField.layer.borderColor = UIColor.red.cgColor
                    //                UIView().showToast(message: "Fill the address - 2 ", view: self.view)
                }
            }
        case self.pincodeTxtField:
            if textField == pincodeTxtField {
                if  pincodeTxtField.text?.count != 0 && pincodeTxtField.text!.count == 6{
                    
                    pincodeErrorHeight.constant = 0.0
                    pincodeErrorLbl.layoutIfNeeded()
                    
                    self.pincodeTxtField.resignFirstResponder()
                }else{
                    self.pincodeTxtField.resignFirstResponder()
                    
                    pincodeErrorHeight.constant = 11.0
                    pincodeErrorLbl.layoutIfNeeded()
                    
                    pincodeErrorLbl.isHidden = false
                    pincodeErrorLbl.text = "Pincode is error"
                    //                pinCocdeTxtField.layer.borderColor = UIColor.red.cgColor
                    //                UIView().showToast(message: "Pincode is error", view: self.view)
                }
                
            }
        default:
            self.shopTxtField.becomeFirstResponder()
        }
        return true
        
    }
    
    
}

extension AddNewAddVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func getBranchDetails(brCodeDetails: String){
        
        
        let getBranchDetails:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getBranchDetails")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let getBranchDetailsParams = ["c_br_code": brCodeDetails]
        
        let getBranchDetailsHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                "Content-Type":"application/json",
        ]
        
        print(getBranchDetailsHeader)
        
        getBranchDetails.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_BRANCH_DETAILS, type: .post, userData: getBranchDetailsParams, apiHeader: getBranchDetailsHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.getBranchDetailsModel = GetBranchDetailsModel(object:dict)
        
            if boolSuccess {
                shopTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cFirmName
                nameTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cContactPersonName
                mobileTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cMobileNo
                addOneTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cAddressNo1
                addTwoTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cAddressNo2
                pincodeTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cPincode
                stateTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cStateName
                stateCode = getBranchDetailsModel?.payloadJson?.data?.cStateCode
                cityTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cCityName
                cityCode = getBranchDetailsModel?.payloadJson?.data?.cCityCode
                areaTxtField.text = getBranchDetailsModel?.payloadJson?.data?.cAreaName
                
//                cityName = getBranchDetailsModel?.payloadJson?.data?.cCityName
//                pinCode = getBranchDetailsModel?.payloadJson?.data?.cPincode
//                defaultBrName = getBranchDetailsModel?.payloadJson?.data?.cFirmName
//                defaultBrCode = getBranchDetailsModel?.payloadJson?.data?.cBrCode
//                cartTableView.reloadData()
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
    func stateApi(pin : String){
        aNameArray.removeAll()
        aCodeArray.removeAll()
        selectedAreaCode?.removeAll()
        selectedAreaName?.removeAll()
        cityCode?.removeAll()
        stateCode?.removeAll()
        let state:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "state")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"nzFXijLYZzDo7ycoym2ZHw==",
        //                                    "X-csquare-api-token":"17921411192f044a",
        //                                    "Content-Type":"application/json",
        //        ]
        
        let stateParams = ["c_pincode": pin]
        let stateHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
        ]
        
        state.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PINCODE_WISE_STATE_SEARCH, type: .post, userData: stateParams, apiHeader: stateHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            pinWiseStateModel = PinWiseStateModel(object: dict)
            if boolSuccess {
                if pinWiseStateModel?.appStatusCode == 0 {
                    stateTxtField.text = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateName = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                    cityTxtField.text = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityName = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""
                    for (ins,element) in (pinWiseStateModel?.payloadJson?.data?.jAreaList)!.enumerated(){
                        aCodeArray.append( element.cAreaCode ?? "")
                        aNameArray.append(element.cAreaName ?? "")
                        
                    }
                
                    // The list of array to display. Can be changed dynamically
                    areaTxtField.optionArray = aNameArray
                    areaTxtField.didSelect{(selectedText , index ,id) in
                        self.selectedAreaCode = self.aCodeArray[index]
                        print(self.selectedAreaCode)
                        self.selectedAreaName = selectedText
                        print(self.selectedAreaName)
                        self.areaTxtField.text = "\(selectedText)"
                        
                }
                    //Its Id Values and its optional
//                    areaTxtField.optionIds = aCodeArray

                }
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

//            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })
        
    }
    
    func updateApi(){

        let update:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "update")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //

        let updateParams: [String: Any] = [
                                           "c_address_no1": addOneTxtField.text ?? "",
                                           "c_address_no2": addTwoTxtField.text ?? "",
                                           "c_area_name": selectedAreaName ?? "",
                                           "c_br_code": brCode ?? "",
                                           "c_city_code": cityCode ?? "",
                                           "c_city_name": cityTxtField.text ?? "",
                                           "c_contact_person_name": nameTxtField.text ?? "",
                                           "c_firm_name": shopTxtField.text ?? "",
                                           "c_mobile_no": mobileTxtField.text ?? "",
                                           "c_pincode": pincodeTxtField.text ?? "" ,
                                           "c_state_code": stateCode ?? "",
                                           "c_state_name": stateName ?? "",
                                           "c_type": "B"
        ]
        print(updateParams)



        let updateHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]

        update.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + FIRM_UPDATE_URL, type: .post, userData: updateParams, apiHeader: updateHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmUpdateModel = FirmUpdateModel(object: dict)
            if boolSuccess {
                if firmUpdateModel?.appStatusCode == 0{
                    let banner = NotificationBanner(title: "Message", subtitle: self.firmUpdateModel?.messages?[0], style: .info)
                    banner.showToast(message: self.firmUpdateModel?.messages?[0] ?? "", view: self.view)
                    self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    isLoginInt = 1

                    self.MobileExistsView?.Mobdelegate = self
                    self.MobileExistsView?.addsellerBtn.setTitle("Cart", for: .normal)
                    self.MobileExistsView?.loopImage.image = UIImage(named: "icon for success ")
                    self.MobileExistsView?.txtLbl.text = self.firmUpdateModel?.messages?[0]
                    self.view.addSubview(self.MobileExistsView!)

                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.firmUpdateModel?.messages?[0], style: .info)
                    banner.showToast(message: self.firmUpdateModel?.messages?[0] ?? "", view: self.view)
                }



            }else{


            }

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

           // self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })


    }
}
