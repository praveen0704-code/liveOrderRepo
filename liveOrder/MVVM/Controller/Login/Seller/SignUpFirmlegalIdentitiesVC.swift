//
//  SignUpFirmlegalIdentitiesVC.swift
//  liveOrder
//
//  Created by Data Prime on 08/07/21.
//

import UIKit
import iOSDropDown
import Alamofire

class SignUpFirmlegalIdentitiesVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var desFillLbl: UILabel!
    @IBOutlet weak var firmContactLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollOverView: UIView!
    @IBOutlet weak var drugNumOneTxtField: DesignableUITextField!
    @IBOutlet weak var drugNumTwoTxtField: DesignableUITextField!
    @IBOutlet weak var validTxtField: DesignableUITextField!
    @IBOutlet weak var gstTypeTxtField: DesignableUITextField!
    @IBOutlet weak var gstNumTxtField: DesignableUITextField!
    @IBOutlet weak var narcoticNumTxtField: DesignableUITextField!
    @IBOutlet weak var nxtBtnNumberLbl: UILabel!
    @IBOutlet weak var NxtBtnRoundDotOneLbl: UILabel!
    @IBOutlet weak var nxtBtnRoundDotTwoLbl: UILabel!
    @IBOutlet weak var nxtBtnTxtLbl: UILabel!
    @IBOutlet weak var gstTypeDropDown: DropDown!
    @IBOutlet weak var drugNumOneErrorLbl: UILabel!
    @IBOutlet weak var drugNumTwoErrorLbl: UILabel!
    @IBOutlet weak var validErrorLbl: UILabel!
    @IBOutlet weak var gstErrorLbl: UILabel!
    @IBOutlet weak var gstinErrorLbl: UILabel!
    @IBOutlet weak var narcoticErrorLbl: UILabel!
    let datePicker = UIDatePicker()
    
    var personName : String?
    var emailadd : String?
    var mobileNum : String?
    var addOne : String?
    var addTwo : String?
    var pincode : String?
    var state : String?
    var city : String?
    var area : String?
    
    var selectedCityCode : String?
    
    var selectedAreaCode : String?
    
    var selectedStateCode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        showDatePicker()
        
        
        // The list of array to display. Can be changed dynamically
        gstTypeDropDown.optionArray = ["IGST", "SGST", "CGST","UTGST"]
        // Its Id Values and its optional
        gstTypeDropDown.optionIds = [1,23,54,22]
        // Image Array its optional
        

        // The the Closure returns Selected Index and String
        gstTypeDropDown.didSelect{(selectedText , index ,id) in
            self.gstTypeDropDown.showList()
            
        }
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        validTxtField.inputAccessoryView = toolbar
        validTxtField.inputView = datePicker

     }
    func setup(){
       
        print(personName)
        print(emailadd)
        print(addOne)
        print(addTwo)
        print(pincode)
        print(state)
        print(city)
        print(area)
                                                  
        drugNumOneErrorLbl.isHidden = true
        drugNumTwoErrorLbl.isHidden = true
        validErrorLbl.isHidden = true
        gstErrorLbl.isHidden = true
        gstinErrorLbl.isHidden = true
        narcoticErrorLbl.isHidden = true
        
        drugNumOneTxtField.delegate = self
        drugNumTwoTxtField.delegate = self
        validTxtField.delegate = self
        gstNumTxtField.delegate = self
        narcoticNumTxtField.delegate = self
        nxtBtnNumberLbl.layer.cornerRadius = nxtBtnNumberLbl.frame.height/2
        nxtBtnNumberLbl.layer.masksToBounds = true
        NxtBtnRoundDotOneLbl.layer.cornerRadius = NxtBtnRoundDotOneLbl.frame.height / 2
        NxtBtnRoundDotOneLbl.layer.masksToBounds = true
        NxtBtnRoundDotOneLbl.layer.borderWidth = 1
        NxtBtnRoundDotOneLbl.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        nxtBtnRoundDotTwoLbl.layer.cornerRadius = NxtBtnRoundDotOneLbl.frame.height / 2
        nxtBtnRoundDotTwoLbl.layer.masksToBounds = true
        
        
        backView.layer.borderWidth = 1
        backView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.2274509804, blue: 0.2509803922, alpha: 1)
        backView.layer.cornerRadius = 8
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.8, blue: 0.8, alpha: 1)
        self.nextBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
       
        
        let cameraone = UIImage(named: "camera")
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        passwordButton.setImage(cameraone, for: .normal)
        passwordButton.addTarget(self, action: #selector(camerataped1), for: .touchUpInside)
        let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        views.addSubview(passwordButton)
        drugNumOneTxtField.rightView = views
        drugNumOneTxtField.translatesAutoresizingMaskIntoConstraints = false
        drugNumOneTxtField.rightViewMode = .always
        
        let cameratwo = UIImage(named: "camera")
        let cameratwobtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        cameratwobtn.setImage(cameratwo, for: .normal)
        cameratwobtn.addTarget(self, action: #selector(camerataped2), for: .touchUpInside)
        let view2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view2.addSubview(cameratwobtn)
        drugNumTwoTxtField.rightView = view2
        drugNumTwoTxtField.translatesAutoresizingMaskIntoConstraints = false
        drugNumTwoTxtField.rightViewMode = .always
        
        let camerathree = UIImage(named: "camera")
        let camerathreebtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        camerathreebtn.setImage(camerathree, for: .normal)
        camerathreebtn.addTarget(self, action: #selector(camerataped3), for: .touchUpInside)
        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view3.addSubview(camerathreebtn)
        narcoticNumTxtField.rightView = view3
        narcoticNumTxtField.translatesAutoresizingMaskIntoConstraints = false
        narcoticNumTxtField.rightViewMode = .always
        
        let downarrow = UIImage(named: "down_arrow")
        let downarrowbtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        downarrowbtn.setImage(downarrow, for: .normal)
        downarrowbtn.addTarget(self, action: #selector(downarrowtaped), for: .touchUpInside)
        let view4 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view4.addSubview(downarrowbtn)
        gstTypeDropDown.rightView = view4
        gstTypeDropDown.translatesAutoresizingMaskIntoConstraints = false
        gstTypeDropDown.rightViewMode = .always
        
        let arealeft = UIImageView(frame: CGRect(x: 24, y: 16, width: CGFloat(15), height: CGFloat(20)))

        arealeft.image = UIImage(named: "gst")
        let areaa = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView3.addSubview(arealeft)
        areaa.addSubview(emptyView3)
        gstTypeDropDown.leftView = areaa
        emptyView3.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        areaa.backgroundColor = .white
        emptyView3.backgroundColor = hexStringToUIColor(hex: "f6f8fd")
        gstTypeDropDown.translatesAutoresizingMaskIntoConstraints = false
        gstTypeDropDown.leftViewMode = .always
        
       
       // BackView Events
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.backView.addGestureRecognizer(gesture)
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpSellerFirmContactRegistration") as? SignUpSellerFirmContactRegistration
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc  func downarrowtaped(sender: UIButton) {
        gstTypeDropDown.showList()
          }
    
    @objc  func camerataped3(sender: UIButton) {
            
          }
    @objc  func camerataped2(sender: UIButton) {
            
          }
    @objc  func camerataped1(sender: UIButton) {
            
          }
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM"
        validTxtField.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    @IBAction func skipBtnAct(_ sender: Any) {
    }
    @IBAction func nextBtnAct(_ sender: Any) {
        
        if  drugNumOneTxtField.text!.count > 3 && drugNumOneTxtField.text!.count <= 16 && drugNumTwoTxtField.text!.count > 3 && drugNumTwoTxtField.text!.count <= 16 && validTxtField.text?.count != 0 && validTxtField.text!.count <= 20 &&  gstNumTxtField.text?.count != 0 && gstNumTxtField.text!.count <= 10 && narcoticNumTxtField.text?.count != 0 && narcoticNumTxtField.text!.count <= 10{
           
           registerApi()
        }else if drugNumOneTxtField.text!.count < 3  {
            drugNumOneTxtField.layer.borderColor = UIColor.red.cgColor
            drugNumOneTxtField.placeholder = "    Please enter the valid Name"
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
       
        }else if drugNumTwoTxtField.text!.count < 3  {
            drugNumTwoTxtField.layer.borderColor = UIColor.red.cgColor
            drugNumTwoTxtField.placeholder = "    Please enter the valid Name"
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
       
        }else if validTxtField.text!.count == 0 {
            validTxtField.layer.borderColor = UIColor.red.cgColor
            validTxtField.placeholder = "    Please enter the valid Mail"
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
       
        }else if gstTypeDropDown.text?.count == 0  {
            gstTypeDropDown.layer.borderColor = UIColor.red.cgColor
            gstTypeDropDown.placeholder = "Enter the address - 1"
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
           
       
        }
        else if gstNumTxtField.text?.count == 0  {
            gstNumTxtField.layer.borderColor = UIColor.red.cgColor
            gstNumTxtField.placeholder = "Enter the address - 2"
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
         
        }else if narcoticNumTxtField.text?.count == 0  {
            narcoticNumTxtField.layer.borderColor = UIColor.red.cgColor
            narcoticNumTxtField.placeholder = "PinCode"
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
           
       
        }
        
        
        else {
            print("check")
            UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
        }
        
    }

}

extension SignUpFirmlegalIdentitiesVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.drugNumOneTxtField{
            
            
//            userNameTxtfiled.layer.shadowRadius = 1
//            userNameTxtfiled.layer.shadowOffset = CGSize(width: 1, height: 1)
            drugNumOneErrorLbl.isHidden = true
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            drugNumOneTxtField.alpha = 0.5
            drugNumOneTxtField.placeholder = "Drug number one"
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
            
            
            
            
            
        }else if textField == self.drugNumTwoTxtField{
            //            passwordTxtField.layer.shadowRadius = 1
            //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
            drugNumTwoErrorLbl.isHidden = true
            drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
            drugNumTwoTxtField.alpha = 0.5
            drugNumTwoTxtField.placeholder = "Drug number two"
            
            drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            
                        
                     
                    }else if textField == self.validTxtField{
                        //            passwordTxtField.layer.shadowRadius = 1
                        //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                        validErrorLbl.isHidden = true
                        validTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                        validTxtField.alpha = 0.5
                        validTxtField.placeholder = "Valid"
                        
                        drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                        
                                    
                                 
            }else if textField == self.gstTypeDropDown{
                                    //            passwordTxtField.layer.shadowRadius = 1
                                    //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                gstErrorLbl.isHidden = true
                gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                gstTypeDropDown.alpha = 0.5
                gstTypeDropDown.placeholder = "GST type"
                
                drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
               
                                             
                                            }
            else if textField == self.gstNumTxtField{
                                    //            passwordTxtField.layer.shadowRadius = 1
                                    //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                gstinErrorLbl.isHidden = true
                gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                gstNumTxtField.alpha = 0.5
                gstNumTxtField.placeholder = "GST Number"
              
                drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
                                             
                                            }
            else if textField == self.narcoticNumTxtField{
                                    //            passwordTxtField.layer.shadowRadius = 1
                                    //            passwordTxtField.layer.shadowOffset = CGSize(width: 1, height: 1)
                narcoticErrorLbl.isHidden = true
                narcoticNumTxtField.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.5607843137, blue: 0.8823529412, alpha: 1)
                narcoticNumTxtField.alpha = 0.5
                narcoticNumTxtField.placeholder = "narcotic Number"
              //  stateDropDown.textColor = .black
                drugNumOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                drugNumTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                gstTypeDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                gstNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            }
           
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == drugNumOneTxtField{
           
            if drugNumOneTxtField.text!.count > 3 && drugNumOneTxtField.text!.count <= 16{
                self.drugNumTwoTxtField.becomeFirstResponder()
            }else{
                
                self.drugNumOneTxtField.resignFirstResponder()
                drugNumOneErrorLbl.isHidden = false
                drugNumOneErrorLbl.text = "Please enter the valid drug license one"
//                drugNumOneTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid drug license one", view: self.view)
            }
        }
        if textField == drugNumTwoTxtField {
            if drugNumTwoTxtField.text!.count > 3 && drugNumTwoTxtField.text!.count <= 16{
                self.validTxtField.becomeFirstResponder()
            }else{
                
                self.drugNumTwoTxtField.resignFirstResponder()
                drugNumTwoErrorLbl.isHidden = false
                drugNumTwoErrorLbl.text = "Please enter the valid drug license two"
//                drugNumTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
            }
        }
        if textField == validTxtField{
             if  validTxtField.text?.count != 0 && validTxtField.text!.count <= 10{
                self.validTxtField.resignFirstResponder()
                 gstTypeDropDown.showList()
            }else{
                self.validTxtField.resignFirstResponder()
                validErrorLbl.isHidden = false
                validErrorLbl.text = "enter the valid date"
//                validTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "enter the valid date ", view: self.view)
            }
        }
        if textField == gstNumTxtField{
            if gstNumTxtField.text?.count != 0 && gstNumTxtField.text!.count <= 16{
                self.narcoticNumTxtField.becomeFirstResponder()
            }else{
                self.gstNumTxtField.resignFirstResponder()
                gstErrorLbl.isHidden = false
                gstErrorLbl.text = "GST number"
//                gstNumTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "GST number  ", view: self.view)
            }
        }
        if textField == narcoticNumTxtField {
            if  narcoticNumTxtField.text?.count != 0 && narcoticNumTxtField.text!.count <= 16{
                narcoticNumTxtField.resignFirstResponder()
            }else{
                narcoticNumTxtField.resignFirstResponder()
                narcoticErrorLbl.isHidden = false
                narcoticErrorLbl.text = "Narotic number"
//                narcoticNumTxtField.layer.borderColor = UIColor.red.cgColor
//                UIView().showToast(message: "Narotic number", view: self.view)
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
           
        
      


            return true

        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            switch textField{
            case drugNumOneTxtField :
                if textField  == drugNumOneTxtField{
                    if drugNumOneTxtField.text!.count > 3 && drugNumOneTxtField.text!.count <= 16{
                        drugNumTwoTxtField.becomeFirstResponder()

                    }else{
                        self.drugNumOneTxtField.resignFirstResponder()
                        drugNumOneErrorLbl.isHidden = false
                        drugNumOneErrorLbl.text = "Please enter the valid drug license one"
//                        drugNumOneTxtField.layer.borderColor = UIColor.red.cgColor
//                        UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
                    }
                }

            case self.drugNumTwoTxtField:


                       if drugNumTwoTxtField.text!.count > 3 && drugNumTwoTxtField.text!.count <= 16{
                        validTxtField.becomeFirstResponder()
                      }else{
                        drugNumTwoTxtField.resignFirstResponder()
                        drugNumTwoErrorLbl.isHidden = false
                        drugNumTwoErrorLbl.text = "Please enter the valid drug license two"
//                        drugNumTwoTxtField.layer.borderColor = UIColor.red.cgColor
//                          UIView().showToast(message: "Please enter the valid drug license two", view: self.view)
                      }
            case self.validTxtField:
                if validTxtField.text?.count != 0 && validTxtField.text!.count <= 10{
                    self.validTxtField.resignFirstResponder()
                }else{
                    self.validTxtField.resignFirstResponder()
                    validErrorLbl.isHidden = false
                    validErrorLbl.text = "enter the valid date"
//                    validTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Valid date error ", view: self.view)
                }
            case self.gstTypeDropDown:
                if gstTypeDropDown.text?.count != 0 && gstTypeDropDown.text!.count <= 20{
                    self.gstNumTxtField.becomeFirstResponder()
                }else{
                    
                    self.gstTypeDropDown.resignFirstResponder()
                    gstErrorLbl.isHidden = false
                    gstErrorLbl.text = "enter GST"
//                    gstTypeDropDown.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "GST type error ", view: self.view)
                }
            case self.gstNumTxtField:
                if  gstNumTxtField.text?.count != 0 && gstNumTxtField.text!.count <= 16{
                    narcoticNumTxtField.becomeFirstResponder()
                    
                }else{
                    gstNumTxtField.resignFirstResponder()
                    gstinErrorLbl.isHidden = false
                    gstinErrorLbl.text = "GSTIN number"
//                    gstNumTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "GST number is error", view: self.view)
                }
            case self.narcoticNumTxtField:
                if  narcoticNumTxtField.text?.count != 0 && narcoticNumTxtField.text!.count <= 16{
                    narcoticNumTxtField.resignFirstResponder()
                    
                }else{
                    narcoticNumTxtField.resignFirstResponder()
                    narcoticErrorLbl.isHidden = false
                    narcoticErrorLbl.text = "Narotic number is error"
//                    narcoticNumTxtField.layer.borderColor = UIColor.red.cgColor
//                    UIView().showToast(message: "Narotic number is error", view: self.view)
                }
                
            default:
                self.drugNumOneTxtField.becomeFirstResponder()
            }
            return true

        }


}
extension SignUpFirmlegalIdentitiesVC : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        
    }
    
    func registerApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
//        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
//                                    "X-csquare-api-token":"1371757505f37f2c",
//                                    "Content-Type":"application/json",
//                                        ]
//
        
        let registParams: [String: Any] = ["c_firm_name":personName,
                                   "c_mobile_no":mobileNum,
                                   "c_pincode":pincode,
                                   "c_firm_img":"",
                                   "c_email_id":emailadd,
                                           "c_drug_license_no1":drugNumOneTxtField.text,
                                   "c_drug_license_no1_img":"yyyyyyy",
                                   "c_drug_license_no1_expiry_date":"2021-09-30",
                                           "c_drug_license_no2":drugNumTwoTxtField.text,
                                   "c_drug_license_no2_img":"",
                                           "c_drug_license_no2_expiry_date":"2021-09-30",
                                           "c_gst_type":gstTypeDropDown.text,
                                           "c_gst_number":gstNumTxtField.text,
                                           "c_narcotic_no":narcoticNumTxtField.text,
                                           "c_contact_person_name":personName,
                                           "c_address_no1":addOne,
                                           "c_address_no2":addTwo,
                                   "c_state_code":selectedStateCode,
                                           "c_state_name":state,
                                   "c_city_code":selectedCityCode,
                                           "c_city_name":city,
                                   "c_area_code":selectedAreaCode,
                                           "c_area_name":area
]
     
     

        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        registerApi.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + FIRM_FOR_URL, type: .post, userData: registParams, apiHeader: sHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            if boolSuccess {
               
                
                

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
        })

        
    }




}
