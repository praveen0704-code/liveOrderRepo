//
//  ProfileFirmInfoVC.swift
//  liveOrder
//
//  Created by Data Prime on 01/09/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift

class ProfileFirmInfoVC: UIViewController {
    @IBOutlet weak var firmInfoTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var twoLbl: UILabel!
    @IBOutlet weak var unselectBrefBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    /////////////////////////////////////////////////
    // MARK : var for Value Passed previous view
    var mobile : String?
    var email : String?
    var medicalName : String?
    var drugLisenceOne : String?
    var validOne : String?
    
    var gstNumOne : String?
    var drugLisenceTwo : String?
    var validTwo : String?
    
    var gstNumTwo : String?
    var drugLisenceThree : String?
    var validThree : String?
   
    var gstNumThree : String?
    var selectedGstId : Int?
    var selectedGstType : String?
    var selectedGstIdTwo : Int?
    var selectedGstTypeTwo : String?
    var selectedGstIdThree : Int?
    var selectedGstTypeThree : String?
    var validOneStr :String?
    var gstTypeStr:String?
    
    //////////////////////////////////////
    
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
    var pinChange = 0
    var pincode : String?
     
    
    var contactName : String?
    var addOne : String?
    var addTwo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        getProfile()
        stateApi(pin: pincode ?? "")
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
        
    }
    func setup (){
        print(gstTypeStr)
        bottomView.layer.borderColor = #colorLiteral(red: 0.8374213576, green: 0.8374213576, blue: 0.8374213576, alpha: 1)
        bottomView.layer.borderWidth = 0.5
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        twoLbl.layer.masksToBounds = true
        twoLbl.layer.cornerRadius = twoLbl.frame.height / 2
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        firmInfoTableView.dataSource = self
        firmInfoTableView.delegate = self
        firmInfoTableView.register(UINib(nibName: "FirmInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "FirmInfoTableViewCell")
    }
    @IBAction func nextBtnAct(_ sender: Any) {
        
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC
                let transition = CATransition()
                transition.duration = 0.5
                vc?.validOne = validOneStr
                print(gstTypeStr)
                vc?.gstTypeStrP = gstTypeStr
                vc?.validTwo = validTwo
                vc?.validThree = validThree
                vc?.drugLisenceOne = drugLisenceOne
                vc?.drugLisenceTwo = drugLisenceTwo
        vc?.drugLisenceThree = drugLisenceTwo
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                transition.subtype = CATransitionSubtype.fromRight
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func selectBtnAct(_ sender: Any) {
    }
    @IBAction func unselectBrefBtnAct(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.fade
//        transition.subtype = CATransitionSubtype.fromRight
//        self.navigationController?.view.layer.add(transition, forKey: nil)
//        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func BackBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func editBtnAct(_ sender: Any) {
      
        pinChange = 3
        firmInfoTableView.reloadData()
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
extension ProfileFirmInfoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
           

                let storeInfocell = tableView.dequeueReusableCell(withIdentifier: "FirmInfoTableViewCell", for: indexPath)as! FirmInfoTableViewCell
            storeInfocell.delegate = self
            storeInfocell.stateDropDown.isUserInteractionEnabled = false
            storeInfocell.cityDropDown.isUserInteractionEnabled = false
            storeInfocell.stateDropDown.arrowSize = 0
            storeInfocell.cityDropDown.arrowSize = 0
            if pinChange == 1{
                storeInfocell.stateDropDown.text?.removeAll()
                storeInfocell.cityDropDown.text?.removeAll()
                storeInfocell.areaDropDown.text?.removeAll()
                aNameArray.removeAll()
                aCodeArray.removeAll()
            }else if pinChange == 2 {
                storeInfocell.contactTxtField.text = firmProfileModel?.payloadJson?.data?.cFirmContactPerson ?? ""
                contactName = storeInfocell.contactTxtField.text
            
                storeInfocell.addOneTxtField.text = firmProfileModel?.payloadJson?.data?.cFirmAddress1 ?? ""
                addOne = storeInfocell.addOneTxtField.text
                storeInfocell.addTwoTxtField.text = firmProfileModel?.payloadJson?.data?.cFirmAddress2 ?? ""
                addTwo = storeInfocell.addTwoTxtField.text
                storeInfocell.stateDropDown.text = stateName ?? ""
                storeInfocell.cityDropDown.text = cityName ?? ""
                storeInfocell.areaDropDown.text = selectedAreaName ?? ""
                storeInfocell.pinTxtField.text = pincode ?? ""
                storeInfocell.areaDropDown.optionArray = aNameArray
                print(storeInfocell.areaDropDown.optionArray)
                storeInfocell.areaDropDown.arrowColor = UIColor(hexString: "5b636a")
                storeInfocell.areaDropDown.didSelect{(selectedText , index ,id) in
                    self.selectedAreaCode = self.aCodeArray[index]
                    print(self.selectedAreaCode)
                    self.selectedAreaName = selectedText
                    print(self.selectedAreaName)
                    storeInfocell.areaDropDown.text = "\(selectedText)"
                    
                    
            }
            }else{
                if pinChange == 3{
                    if storeInfocell.contactTxtField.text?.count != 0 && storeInfocell.addOneTxtField.text?.count != 0 && storeInfocell.addTwoTxtField.text?.count != 0 && storeInfocell.pinTxtField.text?.count == 6 && storeInfocell.stateDropDown.text?.count != 0 && storeInfocell.cityDropDown.text?.count != 0 && storeInfocell.areaDropDown.text?.count != 0{
                        finishApi()
                    }else{
                        UIView().showToast(message: "Require fields Does Not empty ", view: self.view)
                    }
                }else{
                   
                }
            }
          
            
                return storeInfocell
                
            }
        
        return UITableViewCell()
    }
}
extension ProfileFirmInfoVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension ProfileFirmInfoVC : changePinDelegate{
    func addressOne(addone: String) {
        addOne = addone
    }
    
    func addreddtwo(addtwo: String) {
        addTwo = addtwo
    }
    
    func name(person: String) {
        print(person)
        contactName = person
    }
    
    func pinchange(pinNum: String) {
        aNameArray.removeAll()
        aCodeArray.removeAll()
        selectedAreaCode?.removeAll()
        selectedAreaName?.removeAll()
        cityCode?.removeAll()
        stateCode?.removeAll()
        
        print(pinNum)
        pincode = pinNum
        pinChange = 1
        firmInfoTableView.reloadData()
        stateApi(pin: pinNum)
        
      
    }
    
    
}
extension ProfileFirmInfoVC: WebServiceDelegate{
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
                    selectedAreaName = firmProfileModel?.payloadJson?.data?.cAreaName
                    firmInfoTableView.reloadData()
                    
                   
                   
                    
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
                    stateName = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                    cityName = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""
                    for (ins,element) in (pinWiseStateModel?.payloadJson?.data?.jAreaList)!.enumerated(){
                        aCodeArray.append( element.cAreaCode ?? "")
                        aNameArray.append(element.cAreaName ?? "")
                        
                        
                    }
                   
                    //
                    pinChange = 2
                    firmInfoTableView.reloadData()
                }else{
                    stateName = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                    cityName = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""

                   
                    pinChange = 2
                    firmInfoTableView.reloadData()

                }
                
                
            }else{
                stateName = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                cityName = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""

               
                pinChange = 2
                firmInfoTableView.reloadData()

                
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
            firmInfoTableView.reloadData()

        })
        
    }
    
    func finishApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //
        let finalDateStr = formattedDateFromString(dateString:validOne ?? "" , withFormat: "yyyy-MM-dd")
        let registParams: [String: Any] = ["c_firm_name":medicalName ?? "",
                                           "c_br_code":"",
                                           "c_mobile_no":mobile ?? "",
                                           "c_pincode":pincode ?? "",
                                           "c_firm_img":"",
                                           "c_email":email ?? "",
                                           "c_drug_license_no1":drugLisenceOne ?? "",
                                           "c_drug_license_no1_img":"",
                                           "c_drug_license_no1_expiry_date":finalDateStr ?? "",
                                           "c_drug_license_no2":drugLisenceTwo ?? "",
                                           "c_drug_license_no2_img":"",
                                           "c_drug_license_no2_expiry_date":validTwo ?? "",
                                           "c_drug_license_no3":drugLisenceThree ?? "",
                                           "c_drug_license_no3_img":"",
                                           "c_drug_license_no3_expiry_date":validThree ?? "",
                                           "c_gst_type":selectedGstId ?? "",
                                           "c_gst_number":gstNumOne ?? "",
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
                                           "c_contact_person_name":contactName ?? "",
                                           "c_address_no1":addOne ?? "",
                                           "c_address_no2":addTwo ?? "",
                                           "c_state_code":stateCode ?? "",
                                           "c_state_name":stateName ?? "",
                                           "c_city_code":cityCode ?? "",
                                           "c_city_name":cityName ?? "",
                                           "c_area_code":selectedAreaCode ?? "",
                                           "c_area_name":selectedAreaName ?? "",
                                           "c_landmark":"",
                                           "c_type":"B"
//                                           "c_state_code":stateCode ?? "",
//                                           "c_state_name":stateName ?? "",
//                                           "c_city_code":cityCode ?? "",
//                                           "c_city_name":cityName.self ?? "",
//                                           "c_area_code":selectedAreaCode ?? "",
//                                           "c_area_name":selectedAreaName ?? ""
        ]
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
