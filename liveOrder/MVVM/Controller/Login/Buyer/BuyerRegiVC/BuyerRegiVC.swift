//
//  BuyerRegiVC.swift
//  liveOrder
//
//  Created by Data Prime on 02/11/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift


class BuyerRegiVC: UIViewController {
    @IBOutlet weak var buyerTableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var fillBusinessLbl: UILabel!
    
    var done = 0
    var firmupdateModel : FirmUpdateModel?
    var pinWiseStateModel : PinWiseStateModel?
    
    var personName : String?
    var mobileNum: String?
    var email : String?
    var addOne : String?
    var addTwo : String?
    var pincode : String?
    var state : String?
    var city : String?
    var area : String?
    var stateCode : String?
    var cityCode : String?
    var areaCode : String?
    var stateName : String?
    var cityName : String?
    
    var aNameArray = [String]()
    var aCodeArray = [String]()
    var selectedAreaCode : String?
    var selectedAreaName : String?
    var pinChange = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        stateApi(pin: pincode ?? "")
        
    }
    
    func setup(){
        doneBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        buyerTableView.delegate = self
        buyerTableView.dataSource = self
        buyerTableView.register(UINib(nibName: "BuyerRegistrationCell", bundle: nil), forCellReuseIdentifier: "BuyerRegistrationCell")
    }
    @IBAction func doneBtnAct(_ sender: Any) {
        done = 1
        buyerTableView.reloadData()
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BuyerSignupTableViewController") as? BuyerSignupTableViewController
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

extension BuyerRegiVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buyerDetailCell = tableView.dequeueReusableCell(withIdentifier: "BuyerRegistrationCell", for: indexPath)as! BuyerRegistrationCell
        buyerDetailCell.delegate = self
        if done == 1{
            if buyerDetailCell.personNameTxtFiled.text!.count > 3 && buyerDetailCell.personNameTxtFiled.text!.count <= 256 && buyerDetailCell.emailTxtFIeld.text?.isValidEmail(testStr: buyerDetailCell.emailTxtFIeld.text!) == true && buyerDetailCell.addOneTxtFiled.text?.count != 0 && buyerDetailCell.addOneTxtFiled.text!.count <= 20 && buyerDetailCell.addTwoTxtFiled.text?.count != 0 && buyerDetailCell.addTwoTxtFiled.text!.count <= 20 &&  buyerDetailCell.pinCodeTxtField.text?.count != 0 && buyerDetailCell.pinCodeTxtField.text!.count == 6 && buyerDetailCell.stateDropDown.text?.count != 0 && buyerDetailCell.cityDropDown.text?.count != 0 && buyerDetailCell.areaDropDown.text?.count != 0{
                
                personName = buyerDetailCell.personNameTxtFiled.text
                email = buyerDetailCell.emailTxtFIeld.text
                addOne = buyerDetailCell.addOneTxtFiled.text
                addTwo = buyerDetailCell.addTwoTxtFiled.text
                state = buyerDetailCell.stateDropDown.text
                
                city = buyerDetailCell.cityDropDown.text
                
                area = buyerDetailCell.areaDropDown.text
                pincode = buyerDetailCell.pinCodeTxtField.text
                print(personName,email,addTwo,addOne,stateCode,state,city,cityCode,area,areaCode)
                registerApi()
                
                
                
                
            }else if buyerDetailCell.personNameTxtFiled.text!.count < 3 || buyerDetailCell.personNameTxtFiled.text!.count >= 256 {
                buyerDetailCell.contactErrorLbl.isHidden = false
                buyerDetailCell.contactErrorLbl.text = "Please enter the valid Name 4 - 256 character"
                buyerDetailCell.contactLblHeight.constant = 11
                buyerDetailCell.contactErrorLbl.layoutIfNeeded()
//                buyerDetailCell.personNameTxtFiled.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.personNameTxtFiled.placeholder = "    Please enter the valid Name"
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
                
            }else if buyerDetailCell.emailTxtFIeld.text!.count == 0 {
                buyerDetailCell.emailErrorLbl.isHidden = false
                buyerDetailCell.emailErrorLbl.text = "Please enter the valid Mail"
                buyerDetailCell.emailErrorHeight.constant = 11
                buyerDetailCell.emailErrorLbl.layoutIfNeeded()
//                buyerDetailCell.emailTxtFIeld.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.emailTxtFIeld.placeholder = "    Please enter the valid Mail"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if buyerDetailCell.addOneTxtFiled.text?.count == 0  {
                buyerDetailCell.addOneErrorLbl.isHidden = false
                buyerDetailCell.addOneErrorLbl.text = "Enter the address - 1"
                buyerDetailCell.addOneErrHeight.constant = 11
                buyerDetailCell.addOneErrorLbl.layoutIfNeeded()
//                buyerDetailCell.addOneTxtFiled.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.addOneTxtFiled.placeholder = "Enter the address - 1"
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }
            else if buyerDetailCell.addTwoTxtFiled.text?.count == 0  {
                buyerDetailCell.addTwoErrorLbl.isHidden = false
                buyerDetailCell.addTwoErrorLbl.text = "Enter the address - 2"
                buyerDetailCell.addtwoErrHeight.constant = 11
                buyerDetailCell.addTwoErrorLbl.layoutIfNeeded()
//                buyerDetailCell.addTwoTxtFiled.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.addTwoTxtFiled.placeholder = "Enter the address - 2"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if buyerDetailCell.pinCodeTxtField.text?.count == 0  {
                buyerDetailCell.pincodeErrorLbl.isHidden = false
                buyerDetailCell.pincodeErrorLbl.text = "Pincode"
                buyerDetailCell.pinErrHeight.constant = 11
                buyerDetailCell.pincodeErrorLbl.layoutIfNeeded()
//                buyerDetailCell.pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.pinCodeTxtField.placeholder = "PinCode"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if buyerDetailCell.stateDropDown.text?.count == 0  {
                buyerDetailCell.stateErrorLbl.isHidden = false
                buyerDetailCell.stateErrorLbl.text = "Enter the valid pincode"
                buyerDetailCell.stateErrHeight.constant = 11
                buyerDetailCell.stateErrorLbl.layoutIfNeeded()
//                buyerDetailCell.stateDropDown.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.stateDropDown.placeholder = "Select the state"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if buyerDetailCell.cityDropDown.text?.count == 0  {
                buyerDetailCell.cityErrorLbl.isHidden = false
                buyerDetailCell.cityErrorLbl.text = "Enter the valid pincode"
                buyerDetailCell.cityErrHeight.constant = 11
                buyerDetailCell.cityErrorLbl.layoutIfNeeded()
//                buyerDetailCell.cityDropDown.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.cityDropDown.placeholder = "Select the city"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if buyerDetailCell.areaDropDown.text?.count == 0  {
                buyerDetailCell.areaErrorLbl.isHidden = false
                buyerDetailCell.areaErrorLbl.text = "Select or search area"
                buyerDetailCell.areaerrHeight.constant = 11
                buyerDetailCell.areaErrorLbl.layoutIfNeeded()
//                buyerDetailCell.areaDropDown.layer.borderColor = UIColor.red.cgColor
//                buyerDetailCell.areaDropDown.placeholder = "Select the area"
                buyerDetailCell.personNameTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.pinCodeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                buyerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            } else {
                print("check")
                UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
            }
            return buyerDetailCell
        }else{
            if pinChange == 1{
                buyerDetailCell.stateDropDown.text?.removeAll()
                buyerDetailCell.cityDropDown.text?.removeAll()
                buyerDetailCell.areaDropDown.text?.removeAll()
                aNameArray.removeAll()
            }else{
                buyerDetailCell.stateDropDown.arrowSize = 0
                buyerDetailCell.cityDropDown.arrowSize = 0
                buyerDetailCell.personNameTxtFiled.text = personName
                buyerDetailCell.pinCodeTxtField.text = pincode
                buyerDetailCell.stateDropDown.text = stateName
                buyerDetailCell.cityDropDown.text = cityName
                buyerDetailCell.cCodeArray = aCodeArray
                buyerDetailCell.cNameArray = aNameArray
             
                print(aNameArray)
                buyerDetailCell.areaDropDown.optionArray = aNameArray
                buyerDetailCell.areaDropDown.selectedRowColor = .white
                buyerDetailCell.areaDropDown.arrowSize = 0
                buyerDetailCell.areaDropDown.checkMarkEnabled = false
               
                buyerDetailCell.areaDropDown.didSelect{(selectedText , index ,id) in
                    self.selectedAreaCode = self.aCodeArray[index]
                    print(self.selectedAreaCode)
                    self.selectedAreaName = selectedText
                    print(self.selectedAreaName)
                    buyerDetailCell.areaDropDown.text = "\(selectedText)"
                    
            }
           
            }
            return buyerDetailCell
        }
        
    }
    
}
extension BuyerRegiVC : pinChangeDelegate{
    func change(pinNum: String) {
        pincode?.removeAll()
        pincode = pinNum
        pinChange = 1
        buyerTableView.reloadData()
        stateApi(pin: pinNum)
        
        
        
    }
    
    
}
extension BuyerRegiVC : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func registerApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //
        
        let registParams: [String: Any] = ["c_firm_name":personName ?? "",
                                           "c_mobile_no":mobileNum ?? "",
                                           "c_pincode":pincode ?? "",
                                           "c_email":email ?? "",
                                           "c_contact_person_name":personName ?? "",
                                           "c_address_no1":addOne ?? "",
                                           "c_address_no2":addTwo ?? "",
                                           "c_state_code":stateCode ?? "",
                                           "c_state_name":state ?? "",
                                           "c_city_code":cityCode ?? "",
                                           "c_city_name":city ?? "",
                                           "c_area_code":selectedAreaCode ?? "",
                                           "c_area_name":selectedAreaName ?? "",
                                           "c_type":"B"
        ]
        print(registParams)
        
        
        
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
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.firmupdateModel?.messages?[0], style: .info)
                    banner.showToast(message: self.firmupdateModel?.messages?[0] ?? "", view: self.view)
                }
                
                
                
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
                    stateName = pinWiseStateModel?.payloadJson?.data?.cStateName ?? ""
                    stateCode = pinWiseStateModel?.payloadJson?.data?.cStateCode ?? ""
                    cityName = pinWiseStateModel?.payloadJson?.data?.cCityName ?? ""
                    cityCode = pinWiseStateModel?.payloadJson?.data?.cCityCode ?? ""
                    for (ins,element) in (pinWiseStateModel?.payloadJson?.data?.jAreaList)!.enumerated(){
                        aCodeArray.append( element.cAreaCode ?? "")
                        aNameArray.append(element.cAreaName ?? "")
                        
                    }
                    //
                    pinChange = 0
                    buyerTableView.reloadData()
                }
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
        
    }
}
