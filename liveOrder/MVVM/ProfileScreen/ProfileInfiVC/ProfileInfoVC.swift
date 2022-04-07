//
//  ProfileInfoVC.swift
//  liveOrder
//
//  Created by Data Prime on 31/08/21.
//

import UIKit
import Alamofire
import iOSDropDown
import NotificationBannerSwift
import FSCalendar

class ProfileInfoVC: UIViewController{
   
    
    @IBOutlet weak var tabBarCon: UITabBar!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var etidBtn: UIButton!
    @IBOutlet weak var proInfoLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var oneLbl: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var unselectBtn: UIButton!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    //MARK: - Store Info
    @IBOutlet weak var storeInfoView: UIView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mobileNoTextField: WhiteUITextField!
    @IBOutlet weak var storeNameTextField: WhiteUITextField!
    @IBOutlet weak var emailTextField: WhiteUITextField!
    
    //MARK: - Business Innfo
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var drugLicOneTextField: WhiteUITextField!
    
    @IBOutlet weak var valiedTillOneTextField: WhiteUITextField!
    
    @IBOutlet weak var gstOneTextField: DropDown!
    
    @IBOutlet weak var gstNumOneTextField: WhiteUITextField!
    
    //MARK: - AddressLine 2 View
    
    @IBOutlet weak var addressLineTwoView: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var drugLicTwoTextField: WhiteUITextField!
    
    @IBOutlet weak var valiedTillTwoTextField: WhiteUITextField!
    
    
    //MARK: - AddressLine 2 View
    
    @IBOutlet weak var addressLineThreeView: UIView!
    
    @IBOutlet weak var deleteThreeButton: UIButton!
    
    @IBOutlet weak var drugLicThreeTextField: WhiteUITextField!
    
    @IBOutlet weak var valiedTillThreeTextField: WhiteUITextField!
    
    @IBOutlet weak var drugOneCameraBtn: UIButton!
    
    @IBOutlet weak var drugTwoCameraBtn: UIButton!
    
    @IBOutlet weak var drugThreeCameraBtn: UIButton!
    
    
    
    @IBOutlet weak var addressLineTwoHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var addressLineThreeHeightConstraint: NSLayoutConstraint!
    
 
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    var firmProfileModel : FirmProfileModel?
    var gstTypeModel : GstTypeModel?
    var firmUpdateModel : FirmUpdateModel?
    var gstType = [String]()
    var gstId = [Int]()
    var selectedGstType : String?
    var selectedGstId : Int?
    
    var selectedGstTypeTwo : String?
    var selectedGstIdTwo : Int?
    
    var selectedGstTypeThree: String?
    var selectedGstIdThree  : Int?
    
    var selectedIndex : Bool?
    var editBtnTapped = 0
    var nextBtnTapped = 0
    var firmProModArray = [String]()
    var pin : String?
    
    // Mark Pass the Value Variable
    var mobile : String?
    var email : String?
    var medicalName : String?
    var drugLisenceOne : String?
    var validOne : String?
    var gstInOne : String?
    var gstNumOne:String?
    var drugLisenceTwo : String?
    var validTwo : String?
    var gstInTwo : String?
    var gstNumTwo:String?
    var drugLisenceThree : String?
    var validThree : String?
    var gstInThree : String?
    var gstNumThree:String?
    var toolBar = UIToolbar()
    var picker:UIDatePicker?
    var personName : String?
    var add1:String?
    var add2:String?
    var pincode:String?
    var state:String?
    var stateCode:String?
    var city:String?
    var cityCode:String?
    var area:String?
    var areaCode:String?
    var datePicker = UIDatePicker()
    var finalDateStr = String()
    
    var isValidOneDateInt = Int()
    var isValidTwoDateInt = Int()
    var isValidThreeDateInt = Int()
    var todayDate = Date()
    var gstTypeStrP:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getProfile()
        getGstType()
        setup()
       
        
    }
    func setup (){
        
      
        datePicker.minimumDate = todayDate

        self.gstNumOneTextField.autocapitalizationType = .allCharacters
        mobileNoTextField.delegate = self
        storeNameTextField.delegate = self
        emailTextField.delegate = self
        drugLicOneTextField.delegate = self
        valiedTillOneTextField.delegate = self
        gstNumOneTextField.delegate = self
        drugLicTwoTextField.delegate = self
        valiedTillTwoTextField.delegate = self
       
        
       
        drugLicThreeTextField.delegate = self
        valiedTillThreeTextField.delegate = self
        
       // self.valiedTillOneTextField.text = validOne
        
        let gstoneTpe = UIImageView(frame: CGRect(x: 20, y: 15, width: CGFloat(18), height: CGFloat(18)))
        
        gstoneTpe.image = UIImage(named: "gst")
        let gstoneTpeview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let gstoneTpeView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        gstoneTpeView.addSubview(gstoneTpe)
        gstoneTpeview.addSubview(gstoneTpeView)
        gstOneTextField.leftView = gstoneTpeview
        gstoneTpeView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        gstoneTpeview.backgroundColor = .white
        gstoneTpeView.backgroundColor = .white//hexStringToUIColor(hex: "f6f8fd")
        gstOneTextField.translatesAutoresizingMaskIntoConstraints = false
        gstOneTextField.leftViewMode = .always
     
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        bottomView.layer.borderColor = #colorLiteral(red: 0.8367125392, green: 0.8367125392, blue: 0.8367125392, alpha: 1)
        bottomView.layer.borderWidth = 0.5
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        oneLbl.layer.masksToBounds = true
        oneLbl.layer.cornerRadius = oneLbl.frame.height / 2
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
        
        self.addButton.isSelected = true
        
        self.addressLineTwoHeightConstrait.constant = 0.0
        self.addressLineTwoView.layoutIfNeeded()
        self.addressLineTwoView.isHidden = true
        if validOne == ""{
            self.valiedTillOneTextField.text = ""
        }else{
            self.valiedTillOneTextField.text = validOne

        }
        self.gstNumOneTextField.text = "gst type"
        self.addressLineThreeHeightConstraint.constant = 0.0
        self.addressLineThreeView.layoutIfNeeded()
        self.addressLineThreeView.isHidden = true
//        self.addButton.isSelected = false
        
    }
   //MARK: - DatePicker
    func showDatePicker(){
        datePicker.datePickerMode = UIDatePicker.Mode.date
      
                if #available(iOS 13.4, *) {
                    if #available(iOS 14.0, *) {
                        datePicker.preferredDatePickerStyle = .inline
                        datePicker.backgroundColor = .white
                    } else {
                        datePicker.preferredDatePickerStyle = .wheels
                    }
                } else {
                  
                    // Fallback on earlier versions
                }
    
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDatePicker))
        toolBar.setItems([doneButton], animated: false)
       
        if isValidOneDateInt == 1{
            valiedTillOneTextField.inputView = datePicker
            valiedTillOneTextField.inputAccessoryView = toolBar
        }else if isValidTwoDateInt == 1{
            valiedTillTwoTextField.inputView = datePicker
            valiedTillTwoTextField.inputAccessoryView = toolBar
        }else if isValidThreeDateInt == 1{
            valiedTillThreeTextField.inputView = datePicker
            valiedTillThreeTextField.inputAccessoryView = toolBar
        }
      
        
     }
    //Date picker function
    @objc func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" //Change your date formate
        let strDate = dateFormatter.string(from: self.datePicker.date)
        
        if isValidOneDateInt == 1{
            valiedTillOneTextField.text = strDate
            valiedTillOneTextField.resignFirstResponder()

        }else if isValidTwoDateInt == 1{
            self.valiedTillTwoTextField.text = strDate
            self.valiedTillTwoTextField.resignFirstResponder()


        }else if isValidThreeDateInt == 1{
            print(strDate)
            valiedTillThreeTextField.text = strDate
            valiedTillThreeTextField.resignFirstResponder()


        }
    }

    //MARK: - Toolbar done button function
    @objc func onClickDoneButton() {
        self.view.endEditing(true)
    }
    @IBAction func drugThreeCameraBtnAct(_ sender: Any) {
    }
    @IBAction func drugTwoCameraBtnAct(_ sender: Any) {
    }
    @IBAction func drugOneCameraBtnAct(_ sender: Any) {
    }
    @IBAction func nextBtnAct(_ sender: Any) {
       
        print(mobile ?? "")
        print(email ?? "")
        print(medicalName ?? "")
        print(drugLisenceOne ?? "")
        print(validOne ?? "")
        
        print(gstNumOne ?? "")
        print(drugLisenceTwo ?? "")
        print(validTwo ?? "")
        
        print(gstNumTwo ?? "")
        print(drugLisenceThree ?? "")
        print(validThree ?? "")
       
        print(gstNumThree ?? "")
        print(selectedGstId ?? "")
        print(selectedGstType ?? "")
        print(selectedGstIdTwo ?? "")
        print(selectedGstTypeTwo ?? "")
        print(selectedGstIdThree ?? "")
        print(selectedGstTypeThree ?? "")
        
        print(drugLicOneTextField.text)
        print(valiedTillOneTextField.text)
        print(gstOneTextField.text)
        print(gstNumOneTextField.text)
        print(drugLicTwoTextField.text)
        print(valiedTillTwoTextField.text)
        print(drugLicThreeTextField.text)
        print(valiedTillThreeTextField.text)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileFirmInfoVC") as? ProfileFirmInfoVC
        vc?.pincode = pin
        vc?.mobile = mobile
        vc?.email = emailTextField.text
        vc?.medicalName = medicalName
        vc?.drugLisenceOne = drugLicOneTextField.text
        vc?.validOne = valiedTillOneTextField.text
        vc?.selectedGstId = selectedGstId
        vc?.selectedGstType = selectedGstType
        vc?.gstNumOne = gstNumOneTextField.text
        vc?.drugLisenceTwo = drugLicTwoTextField.text
        vc?.validTwo = valiedTillTwoTextField.text
        vc?.selectedGstIdTwo = selectedGstIdTwo
        vc?.selectedGstTypeTwo = selectedGstTypeTwo
        vc?.gstNumTwo = gstNumTwo
        vc?.drugLisenceThree = drugLicThreeTextField.text
        print(drugLicThreeTextField.text)
        vc?.validThree = valiedTillThreeTextField.text
        vc?.selectedGstIdThree = selectedGstIdThree
        vc?.selectedGstTypeThree = selectedGstTypeThree
        vc?.gstNumThree = gstNumThree
        vc?.validOneStr = valiedTillOneTextField.text
        vc?.gstTypeStr = gstOneTextField.text
        
       
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func unselectBtnAct(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileFirmInfoVC") as? ProfileFirmInfoVC
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.fade
//        transition.subtype = CATransitionSubtype.fromRight
//        self.navigationController?.view.layer.add(transition, forKey: nil)
//        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func selectBtnAct(_ sender: Any) {
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func editBtnAct(_ sender: Any) {
       
        if drugLicOneTextField.text?.count != 0 && valiedTillOneTextField.text?.count != 0 && gstOneTextField.text?.count != 0 && gstNumOneTextField.text?.count != 0 {
             finishApi()
        }else{
            UIView().showToast(message: "Require fields Does Not empty ", view: self.view)
        }
       
        
    }
    
    
    @IBAction func profileAddAction(sender: UIButton) {

        sender.isSelected = !sender.isSelected
        if drugLicOneTextField.text?.count != 0 && valiedTillOneTextField.text?.count != 0 && gstOneTextField.text?.count != 0 && gstNumOneTextField.text?.count != 0 {
            if sender.isSelected
            {
                print(sender.isSelected)
                self.addressLineThreeHeightConstraint.constant = 188.0
                self.addressLineThreeView.layoutIfNeeded()
                self.addressLineThreeView.isHidden = false
                sender.isSelected = true
                
            }else{
                
                self.addressLineTwoHeightConstrait.constant = 188.0
                self.addressLineTwoView.layoutIfNeeded()
                self.addressLineTwoView.isHidden = false
                sender.isSelected = false

            }
        }else{
            UIView().showToast(message: "Add License No 1 Does Not empty ", view: self.view)
           sender.isSelected = true

        }
      
      
      
      
    }
    
    @IBAction func addressDeleteOneAction(_ sender: Any) {
        
        self.addressLineTwoHeightConstrait.constant = 0.0
        self.addressLineTwoView.layoutIfNeeded()
        self.addressLineTwoView.isHidden = true
        drugLisenceTwo = ""
        validTwo = ""
        selectedGstIdTwo = nil
        selectedGstTypeTwo = ""
        gstNumTwo = ""
    
    }
    
    @IBAction func addressDeleteTwoAction(_ sender: Any) {
        
        
        self.addressLineThreeHeightConstraint.constant = 0.0
        self.addressLineThreeView.layoutIfNeeded()
        self.addressLineThreeView.isHidden = true
        drugLisenceThree = ""
        validThree = ""
        selectedGstIdThree = nil
        selectedGstTypeThree = ""
        gstNumThree = ""

    }
    
    
    
}
extension ProfileInfoVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.valiedTillOneTextField{
//            let calenderVc = self.storyboard?.instantiateViewController(withIdentifier: "LCalenderViewController") as! LCalenderViewController
//            calenderVc.isProfileInfoInt = 1
//            calenderVc.dateDelegare = self
//
//            self.navigationController?.pushViewController(calenderVc, animated: false)
            isValidOneDateInt = 1
            isValidTwoDateInt = 0
            isValidThreeDateInt = 0
            showDatePicker()
        }else if textField == self.valiedTillTwoTextField{
            isValidOneDateInt = 0
            isValidTwoDateInt = 1
            isValidThreeDateInt = 0
            showDatePicker()

            
        }else if textField == self.valiedTillThreeTextField{
            isValidOneDateInt = 0
            isValidTwoDateInt = 0
            isValidThreeDateInt = 1
            showDatePicker()

        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.mobileNoTextField{
            mobile = self.mobileNoTextField.text
        }else if textField == self.storeNameTextField{
            medicalName = self.storeNameTextField.text
        }else if textField == self.emailTextField{
            if emailTextField.text?.isValidEmail(testStr: emailTextField.text ?? "") == true{
                email = self.emailTextField.text
                emailTextField.layer.borderColor = UIColor(hexString: "c3cde4").cgColor
            }else{
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.becomeFirstResponder()
                emailTextField.text = ""
                emailTextField.placeholder = "Enter the Valid email"
            }
            
        }else if textField == self.drugLicOneTextField{
            drugLisenceOne = self.drugLicOneTextField.text
        }else if textField == self.valiedTillOneTextField{
            
//            let finalDateStr = formattedDateFromString(dateString:valiedTillOneTextField.text ?? "" , withFormat: "yyyy-MM-dd")
//            validOne = finalDateStr
        }else if textField == self.gstNumOneTextField{
            gstNumOne = self.gstNumOneTextField.text
        }else if textField == self.drugLicTwoTextField{
            drugLisenceTwo = self.drugLicTwoTextField.text
        }else if textField == self.valiedTillTwoTextField{
            validTwo = self.valiedTillTwoTextField.text
            
        }else if textField == self.drugLicThreeTextField{
            drugLisenceThree = self.drugLicThreeTextField.text
        }else if textField == self.valiedTillThreeTextField{
            validThree = self.valiedTillThreeTextField.text
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == gstNumOneTextField {
            if (gstNumOneTextField.text)?.count == 14{
                if ((gstNumOneTextField.text)! + string).count == 15{
                    if gstNumOneTextField.text?.gstValid(gstNum: gstNumOneTextField.text! + string) == true{
                        gstNumOneTextField.text = (gstNumOneTextField.text! + string)
                        gstNumOne = gstNumOneTextField.text
                        gstNumOneTextField.resignFirstResponder()
                    }else{
                        gstNumOne = ""
                    }
                }else{
                    gstNumOne = ""
                }
            
            }
            
            let maxLength = 15          // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            
            return newString.length <= maxLength
        }
       
        
        return true
    }
    
}
extension ProfileInfoVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
}
extension ProfileInfoVC : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func getProfile(){
       
            showActivityIndicator(self.view)

        
        let getProfile:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getProfile")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let proHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        getProfile.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+FIRM_PROFILE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmProfileModel = FirmProfileModel(object:dict)
            if boolSuccess {
               
                if self.firmProfileModel?.appStatusCode == 0{
                    personName = self.firmProfileModel?.payloadJson?.data?.cFirmContactPerson
                    add1 = self.firmProfileModel?.payloadJson?.data?.cFirmAddress1
                    add2 = self.firmProfileModel?.payloadJson?.data?.cFirmAddress2
                    pincode = self.firmProfileModel?.payloadJson?.data?.cPincode
                    state = self.firmProfileModel?.payloadJson?.data?.cStateName
                    stateCode = self.firmProfileModel?.payloadJson?.data?.cStateCode
                    city = self.firmProfileModel?.payloadJson?.data?.cCityName
                    cityCode = self.firmProfileModel?.payloadJson?.data?.cCityCode
                    area = self.firmProfileModel?.payloadJson?.data?.cAreaName
                    areaCode = self.firmProfileModel?.payloadJson?.data?.cAreaCode
                    mobileNoTextField.text = self.firmProfileModel?.payloadJson?.data?.cMobileNo
                    mobile = self.firmProfileModel?.payloadJson?.data?.cMobileNo
                    medicalName = self.firmProfileModel?.payloadJson?.data?.cName
                    self.storeNameTextField.text = self.firmProfileModel?.payloadJson?.data?.cName
                    pin = firmProfileModel?.payloadJson?.data?.cPincode ?? ""
                    emailTextField.text = firmProfileModel?.payloadJson?.data?.cEmail
                    drugLicOneTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo1
                
                    if validOne == ""{
                       valiedTillOneTextField.text = firmProfileModel?.payloadJson?.data?.cDrugLicenseNo1ExpiryDate

                   }else{
                       valiedTillOneTextField.text = validOne

                   }

                    
                    if firmProfileModel?.payloadJson?.data?.cGstType == "-7"{
                        gstOneTextField.text = "SEZ with LUT(Exempted)"
                        selectedGstId = -7
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "-3"{
                        gstOneTextField.text = "Export with LUT(Exempted)"
                        selectedGstId = -3
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "-1"{
                        gstOneTextField.text = "Research Institution(5.00 GST %)"
                        selectedGstId = -1
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "1"{
                        gstOneTextField.text = "Registered"
                        selectedGstId = 1
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "2"{
                        gstOneTextField.text = "Un-Registered(With RCM) "
                        selectedGstId = 2
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "3"{
                        gstOneTextField.text = "Composite(With RCM"
                        selectedGstId = 3
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "4"{
                        gstOneTextField.text = "Exempted"
                        selectedGstId = 4
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "5"{
                        gstOneTextField.text = "Composite(No RCM) "
                        selectedGstId = 5
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "6"{
                        gstOneTextField.text = "n-Registered(No RCM) "
                        selectedGstId = 6
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "7"{
                        gstOneTextField.text = "SEZ(Special Economic Zone)"
                        selectedGstId = 7
                    }else if firmProfileModel?.payloadJson?.data?.cGstType == "9"{
                        gstOneTextField.text = "E-commerce  8/Exporter(0.1 GST%)"
                        selectedGstId = 9
                    }else{
                        
                        gstOneTextField.text = gstTypeStrP
                    }
                   
                    gstNumOneTextField.text = firmProfileModel?.payloadJson?.data?.cGstNo
                
                    drugLicTwoTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo2
                    
                    print(validTwo)
                    print(validThree)
                    if validTwo == "" || validTwo == nil{
                        valiedTillTwoTextField.text = firmProfileModel?.payloadJson?.data?.cDrugLicenseNo2ExpiryDate

                        self.addressLineTwoHeightConstrait.constant = 0.0
                        self.addressLineTwoView.layoutIfNeeded()
                        self.addressLineTwoView.isHidden = true
                    }else{
                        self.addressLineTwoHeightConstrait.constant = 188.0
                        self.addressLineTwoView.layoutIfNeeded()
                        self.addressLineTwoView.isHidden = false
                        valiedTillTwoTextField.text = validTwo
                    }
                    if validThree == "" || validThree == nil{
                        self.addressLineTwoHeightConstrait.constant = 0.0
                        self.addressLineThreeView.layoutIfNeeded()
                        self.addressLineThreeView.isHidden = true
                        valiedTillThreeTextField.text = firmProfileModel?.payloadJson?.data?.cDrugLicenseNo3ExpiryDate
                    }else{
                        self.addressLineTwoHeightConstrait.constant = 188.0
                        self.addressLineThreeView.layoutIfNeeded()
                        self.addressLineThreeView.isHidden = false
                        valiedTillThreeTextField.text =  validThree
                    }
                    print(drugLisenceThree)
                    if drugLisenceThree ==  "" || drugLisenceThree == nil{
                        drugLicThreeTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo3

                    }else{

                        drugLicThreeTextField.text = drugLisenceThree

                    }
                    if drugLisenceOne ==  "" || drugLisenceOne == nil{
                        drugLicOneTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo3

                    }else{

                        drugLicThreeTextField.text = drugLisenceOne

                    }
                    if drugLisenceTwo ==  "" || drugLisenceTwo == nil{
                        drugLicTwoTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo3

                    }else{

                        drugLicTwoTextField.text = drugLisenceTwo

                    }
                    
                    self.mainScrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 150.0, right: 0.0)
                }else{
                    
                }
                
                hideActivityIndicator(self.view)
                
                
            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)

        })
        
    }
    func getGstType(){
       
            showActivityIndicator(self.view)

        
        let getGstType:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getGstType")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let gstHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        getGstType.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GST_TYPE_URL, type: .get, userData: nil, apiHeader: gstHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.gstTypeModel = GstTypeModel(object:dict)
            if boolSuccess {
               
                if self.gstTypeModel?.appStatusCode == 0{
                    
                   
                    for (_,element) in (gstTypeModel?.payloadJson?.data)!.enumerated(){
                        gstType.append(element.cGstType ?? "")
                        gstId.append(element.nId ?? 0)
                        gstOneTextField.optionArray = gstType
                        gstOneTextField.optionIds = gstId
                        gstOneTextField.arrowColor = UIColor(hexString: "5b636a")
                        
                        gstOneTextField.didSelect{(selectedText , index ,id) in
                            selectedGstType = selectedText
                            selectedGstId = id
                            print(selectedText,id,index)
                        self.gstOneTextField.text = "\(selectedText)\(id)"
                        }
                       
                       
                      
                        
                    }
                       

                   
                    
                }else{
                    
                }
                
                hideActivityIndicator(self.view)
                
            }else{
                        

            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })
    }
    
    func finishApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //
        print(valiedTillOneTextField.text)
        let finalDateStr = formattedDateFromString(dateString:valiedTillOneTextField.text ?? "" , withFormat: "yyyy-MM-dd")
        print(finalDateStr)
        
        let registParams: [String: Any] =   ["c_firm_name":storeNameTextField.text ?? "",
                                             "c_mobile_no":mobileNoTextField.text ?? "",
                                             "c_pincode":pincode ?? "",
                                             "c_firm_img":"",
                                             "c_email":emailTextField.text ?? "",
                                             "c_drug_license_no1":drugLicOneTextField.text ?? "",
                                             "c_drug_license_no1_img":"",
                                             "c_drug_license_no1_expiry_date":finalDateStr ?? "",
                                             "c_drug_license_no2":drugLicTwoTextField.text ?? "",
                                             "c_drug_license_no2_img":"",
                                             "c_drug_license_no2_expiry_date":valiedTillTwoTextField.text ?? "",
                                             "c_drug_license_no3":drugLicThreeTextField.text ?? "",
                                             "c_drug_license_no3_img":"",
                                             "c_drug_license_no3_expiry_date":validThree ?? "",
                                             "c_gst_type":selectedGstId ?? "",
                                             "c_gst_number":gstNumOneTextField.text ?? "",
                                             "c_narcotic_no":"",
                                             "c_narcotic_no_img":"",
                                             "c_tan_no":"",
                                             "c_tan_no_img":"",
                                             "c_pan_no":"",
                                             "c_pan_no_img":"",
                                             "c_it_pan_no":"",
                                             "c_it_pan_no_img":"",
                                             "c_electricity_bill":"",
                                             "c_electricity_bill_img":"",
                                             "c_rent_agreement":"",
                                             "c_rent_agreement_img":"",
                                             "c_partnership_deed":"",
                                             "c_partnership_deed_img":"",
                                             "c_bank_statement":"",
                                             "c_bank_statement_img":"",
                                             "c_authority_letter":"",
                                             "c_authority_letter_img":"",
                                             "c_contact_person_name":personName ?? "",
                                             "c_address_no1":add1 ?? "",
                                             "c_address_no2":add2 ?? "",
                                             "c_state_code":stateCode ?? "",
                                             "c_state_name":state ?? "",
                                             "c_city_code":cityCode ?? "",
                                             "c_city_name":city ?? "",
                                             "c_area_code":areaCode ?? "",
                                             "c_area_name":area ?? "",
                                             "c_buyer": "",
                                             "c_seller": "",
                                             "c_status": "A"
  //                                           "c_state_code":stateCode ?? "",
  //                                           "c_state_name":stateName ?? "",
  //                                           "c_city_code":cityCode ?? "",
  //                                           "c_city_name":cityName.self ?? "",
  //                                           "c_area_code":selectedAreaCode ?? "",
  //                                           "c_area_name":selectedAreaName ?? ""
          ]
      
//        ["c_firm_name":storeNameTextField ?? "",
//                                           "c_mobile_no":mobileNoTextField.text ?? "",
//                                           "c_pincode":pincode ?? "",
//                                           "c_email":emailTextField.text ?? "",
//                                           "c_drug_license_no1":drugLicOneTextField.text ?? "",
//                                           "c_drug_license_no1_img":"",
//                                           "c_drug_license_no1_expiry_date":valiedTillOneTextField.text ?? "",
//                                           "c_drug_license_no2":drugLicTwoTextField.text ?? "",
//                                           "c_drug_license_no2_img":"",
//                                           "c_drug_license_no2_expiry_date":valiedTillTwoTextField.text ?? "",
//                                           "c_drug_license_no3":drugLicThreeTextField.text ?? "",
//                                           "c_drug_license_no3_img":"",
//                                           "c_drug_license_no3_expiry_date":valiedTillThreeTextField.text ?? "",
//                                           "c_gst_type":gstOneTextField.text ?? "",
//                                           "c_gst_number":gstNumOneTextField.text ?? "",
//                                           "c_type":"B"
//
//        ]
        print(registParams)
        
        
        
        let bHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        
        registerApi.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + FIRM_FOR_URL, type: .post, userData: registParams, apiHeader: bHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmUpdateModel = FirmUpdateModel(object: dict)
            if boolSuccess {
                if firmUpdateModel?.appStatusCode == 0{
                    if #available(iOS 13.0, *) {
                        let banner = NotificationBanner(title: "Message", subtitle: self.firmUpdateModel?.messages?[0], style: .info)
                        banner.showToast(message: self.firmUpdateModel?.messages?[0] ?? "", view: self.view)
                    
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    
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

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })
        
        
    }

}
