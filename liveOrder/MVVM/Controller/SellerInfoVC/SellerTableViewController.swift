//
//  SellerTableViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 14/03/22.
//

import UIKit
import Alamofire

class SellerTableViewController: UITableViewController{
    

    @IBOutlet weak var comNameTextFfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var nameTextField: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var mobileNoTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var flameTextffield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var dateTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var flCompositTextField: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var flNumTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var addressLineOneTextField: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var addressLineTwoTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var pincodeTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var stateTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var cityTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var streetTextfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var landMarkOneTextFfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var iacceptButton: UIButton!
    @IBOutlet weak var flCheckButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    var sAeaCodeStr = String()
    var sAreaNameStr = String()
    var sCityNamestr = String()
    var sSellerNameStr = String()
    var sStateNameStr = String()
    var comNameStr = String()
    
    
    //FIXME: - Pincode
    var cityName : String?
    var stateCode : String?
    var cityCode : String?
    var areaCode : String?
    var aNameArray = [String]()
    var aCodeArray = [String]()
    var selectedAreaCode : String?
    var selectedAreaName : String?
    var pinWiseStateModel : PinWiseStateModel?
    var firmProfileModel : FirmProfileModel?
    var osSellerModel:OrderSellerList?


    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSellerPopUp()
        
    }
    func loadSellerPopUp(){
        
        
        self.comNameTextFfield.text = comNameStr
//        self.nameTextField.text = sSellerNameStr
        self.mobileNoTextfield.text = UserDefaults.standard.value(forKey: usernameConstantStr) as! String
        self.addressLineOneTextField.text = sAreaNameStr
        self.cityTextfield.text = sCityNamestr
        self.stateTextfield.text = sStateNameStr
        self.streetTextfield.text = sAreaNameStr
        print(sAreaNameStr)
              print(sCityNamestr)
                    print()
                          print(sStateNameStr)
        iacceptButton.setTitle("", for: .normal)
        flCheckButton.setTitle("", for: .normal)
        cameraButton.setTitle("", for: .normal)
        self.pincodeTextfield.delegate = self
        getProfile()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 17
        
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    //MARK: - Button Action
    
    @IBAction func iacceptAction(_ sender: Any) {
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        
    }
    
    @IBAction func flCheckAction(_ sender: Any) {
        
        
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        
        
    }
    
    
    
}
extension SellerTableViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.pincodeTextfield{
            
        }
    }
    
}
extension SellerTableViewController : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
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

                }
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
        
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
//                    personName = self.firmProfileModel?.payloadJson?.data?.cFirmContactPerson
//                    add1 = self.firmProfileModel?.payloadJson?.data?.cFirmAddress1
//                    add2 = self.firmProfileModel?.payloadJson?.data?.cFirmAddress2
//                    pincode = self.firmProfileModel?.payloadJson?.data?.cPincode
//                    state = self.firmProfileModel?.payloadJson?.data?.cStateName
//                    stateCode = self.firmProfileModel?.payloadJson?.data?.cStateCode
//                    city = self.firmProfileModel?.payloadJson?.data?.cCityName
//                    cityCode = self.firmProfileModel?.payloadJson?.data?.cCityCode
//                    area = self.firmProfileModel?.payloadJson?.data?.cAreaName
//                    areaCode = self.firmProfileModel?.payloadJson?.data?.cAreaCode
//                    mobileNoTextField.text = self.firmProfileModel?.payloadJson?.data?.cMobileNo
//                    mobile = self.firmProfileModel?.payloadJson?.data?.cMobileNo
//                    medicalName = self.firmProfileModel?.payloadJson?.data?.cName
//                    self.storeNameTextField.text = self.firmProfileModel?.payloadJson?.data?.cName
//                    pin = firmProfileModel?.payloadJson?.data?.cPincode ?? ""
//                    emailTextField.text = firmProfileModel?.payloadJson?.data?.cEmail
//                    drugLicOneTextField.text = firmProfileModel?.payloadJson?.data?.cDruglicenseNo1
                
                  
                 

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
    
    

}
extension SellerTableViewController:mobilexist {
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
}

