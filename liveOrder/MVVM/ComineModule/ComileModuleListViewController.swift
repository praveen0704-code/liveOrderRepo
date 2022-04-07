//
//  ComileModuleListViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 06/12/21.
//

import UIKit
import Alamofire

class ComileModuleListViewController: UIViewController {
    
    
    @IBOutlet weak var cmLabel: UILabel!
    
    @IBOutlet weak var cominedSelectedButton: UIButton!
    
    
    @IBOutlet weak var comainnStoreInfoLabel: UILabel!
    @IBOutlet weak var cominedStoreTableView: UITableView!
    
    @IBOutlet weak var iagreeButton: UIButton!
    
    @IBOutlet weak var takeMeToLiveOrderButton: UIButton!
    @IBOutlet weak var comaiStoreButton: UIButton!
    //  var comainnStoreModel:ComainListBaseClass?
    var combainStoreJDrugDict:JDrugLicenseNo?
    var combainStoreJDrugArray = [JDrugLicenseNo]()
    //MARK: - unAurth
    var unAurthStoreJDrugDict:JDrugLicenseNo?
    var unAurthStoreJDrugArray = [JDrugLicenseNo]()
    var finalFilterdict:JDrugLicenseNo?
    
    var checkListArray = [Int]()
    //Use to change the list containerView
    var mainViewcolorInt = [Int]()
    var cDrugLisenceListArray = [String]()
    var cConbainStoreListArray = [String]()
    var combainStoreNAModel:CombainStoreNABaseClass?
    var combainStoreSaveModel:CombainStoreSaveBaseClass?
    
   var mobileNumStr = String()
 //   var mobileNumStr = "9886069335"
    var checkDuplicatesArray = [Int]()
    var jDrugLisenceNoArray = NSArray()
   // var mobNumStr = "9886069335"
    var filterBarCord = String()
    var fBarCodeIndex = Int()
    var vcViewed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
    }
    func setup(){
        iagreeButton.isUserInteractionEnabled = false
        takeMeToLiveOrderButton.isUserInteractionEnabled = false
        comaiStoreButton.isUserInteractionEnabled = false
        cmLabel.text = "\(mobileNumStr) is tagged to multiple stores in ourdatabase. Verify your store details and mergeduplicate entries."
        cominedStoreTableView.register(UINib(nibName: "CombinedStoreListTableViewCell", bundle: nil), forCellReuseIdentifier: "CombinedStoreListTableViewCell")
        cominedStoreTableView.delegate = self
        cominedStoreTableView.dataSource = self
        comainStoreList(number: mobileNumStr)
        
        
        
    }
    
    //MARK: - Button Action
    
    @IBAction func takeMeToLiveOrderAction(_ sender: Any) {
        cConbainStoreListArray.removeAll()
        cDrugLisenceListArray.removeAll()
        for (_,elmts) in jDrugLisenceNoArray.enumerated(){
            let resArray = elmts as! NSArray
            for (_,resElement) in resArray.enumerated() {
               // print(resElement)
                unAurthStoreJDrugDict = JDrugLicenseNo(object: resElement)
              //  print(unAurthStoreJDrugDict)
                
                
                cDrugLisenceListArray.append("\(unAurthStoreJDrugDict?.cBrCode ?? "")")
                cConbainStoreListArray.append("\(unAurthStoreJDrugDict?.cDrugLicenseNo ?? "")")
                
            }
        }
        
        let filterCdrugLisenceListArray = cDrugLisenceListArray.filter { $0 != "0" }
       // print(filterCdrugLisenceListArray)
        let filtercConbainStoreListArray = cConbainStoreListArray.filter{ $0 != "0" }
        //print(filtercConbainStoreListArray)
        if vcViewed == true {
            ComainStoreAuth(mobileNo: mobileNumStr, combainStoreArray: filtercConbainStoreListArray, cDrugLisencesArray: filterCdrugLisenceListArray)
        }else{
            saveComainStoreAurth(mobileNo: mobileNumStr, combainStoreArray: filtercConbainStoreListArray, cDrugLisencesArray: filterCdrugLisenceListArray)
        }
        
        
    }
    @IBAction func iAgreeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.iagreeButton.backgroundColor = UIColor(hexString: "674CF3")
            self.iagreeButton.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
            self.iagreeButton.isSelected = true
            self.takeMeToLiveOrderButton.backgroundColor = UIColor(hexString: "674CF3")
            self.takeMeToLiveOrderButton.isUserInteractionEnabled = true
            
            
        }else{
            self.iagreeButton.borderColor = UIColor(hexString: "C3CDE4")
            self.iagreeButton.borderWidth = 1.0
            self.iagreeButton.clipsToBounds = true
            self.iagreeButton.backgroundColor = .white
            self.iagreeButton.setImage(UIImage(named: ""), for: UIControl.State.normal)
            self.iagreeButton.isSelected = false
            self.takeMeToLiveOrderButton.backgroundColor = UIColor(hexString: "afa2f9")
            self.takeMeToLiveOrderButton.isUserInteractionEnabled = false
            
        }
        
    }
    
    @IBAction func combainSelectedAction(_ sender: Any) {
        
        let filterCdrugLisenceListArray = cDrugLisenceListArray.filter { $0 != "0" }
        print(filterCdrugLisenceListArray)
        let filtercConbainStoreListArray = cConbainStoreListArray.filter{ $0 != "0" }
        if vcViewed == true{
            comainStoreA(mobileNo: mobileNumStr, combainStoreArray: filtercConbainStoreListArray, cDrugLisencesArray: filterCdrugLisenceListArray)
        }else{
            comainStoreNA(mobileNo: mobileNumStr, combainStoreArray: filtercConbainStoreListArray, cDrugLisencesArray: filterCdrugLisenceListArray)
        }
        
    }
    
}
extension ComileModuleListViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combainStoreJDrugArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comListCell = tableView.dequeueReusableCell(withIdentifier: "CombinedStoreListTableViewCell", for: indexPath) as! CombinedStoreListTableViewCell
        comListCell.storeNameLabel.text = "STORE\(indexPath.row)"
        comListCell.firmNamelabel.text = combainStoreJDrugArray[indexPath.row].cFirmName
        comListCell.addressLabel.text = "Address \(combainStoreJDrugArray[indexPath.row].cAreaCode ?? ""), \(combainStoreJDrugArray[indexPath.row].cAddressNo1 ?? "") \(combainStoreJDrugArray[indexPath.row].cAddressNo2 ?? ""),\(combainStoreJDrugArray[indexPath.row].cAreaName ?? ""),\(combainStoreJDrugArray[indexPath.row].cCityName ?? ""),\(combainStoreJDrugArray[indexPath.row].cStateName ?? ""),\(combainStoreJDrugArray[indexPath.row].cPincode ?? "")"
        comListCell.drugLisenceNoLabel.text = combainStoreJDrugArray[indexPath.row].cDrugLicenseNo
        
        comListCell.gstLabel.text =  combainStoreJDrugArray[indexPath.row].cGstNumber
        comListCell.checkButton.tag = indexPath.row
        comListCell.checkButton.addTarget(self, action: #selector(comainCheckAction(sender:)), for: .touchUpInside)
        comListCell.checkButton.isSelected = true
        
        if checkListArray[indexPath.row] == 1{
            comListCell.checkButton.backgroundColor = UIColor(hexString: "674CF3")
            comListCell.checkButton.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
            comListCell.checkButton.isSelected = true
            
            
        }else{
            comListCell.checkButton.borderColor = UIColor(hexString: "C3CDE4")
            comListCell.checkButton.borderWidth = 1.0
            comListCell.checkButton.clipsToBounds = true
            comListCell.checkButton.backgroundColor = .white
            comListCell.checkButton.setImage(UIImage(named: ""), for: UIControl.State.normal)
            comListCell.checkButton.isSelected = false
        }
        
        if mainViewcolorInt[indexPath.row] == 1{
            comListCell.comainMainView.backgroundColor = .white
            comListCell.checkButton.isUserInteractionEnabled = true
        }else if mainViewcolorInt[indexPath.row] == 2{
            comListCell.comainMainView.backgroundColor = UIColor(hexString: "90EE90")
            comListCell.checkButton.isUserInteractionEnabled = false
            
        }else if mainViewcolorInt[indexPath.row] == 3 {
            comListCell.comainMainView.backgroundColor = UIColor(hexString:"FFC6C4")
            comListCell.checkButton.isUserInteractionEnabled = false
            
        }else{
           
            comListCell.comainMainView.backgroundColor = .white
            comListCell.checkButton.isUserInteractionEnabled = true
        }
        return comListCell
    }
    
    //MARK: - button Action
    @objc func comainCheckAction(sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            comaiStoreButton.isUserInteractionEnabled = true
            comaiStoreButton.backgroundColor = UIColor(hexString: "674cf3")
            let getLisenceNo = combainStoreJDrugArray[sender.tag].cDrugLicenseNo!
            let lastFourDigLienceNoStr = getLisenceNo.suffix(4)
            //   print(lastFourDigLienceNoStr)
            
            checkListArray[sender.tag] = 1
            self.cominedSelectedButton.backgroundColor = UIColor(hexString: "674CF3")
            
            self.cominedStoreTableView.reloadData { [self] in
                
                print(checkDuplicatesArray.count)
                
                for (inx,resElement) in combainStoreJDrugArray.enumerated(){
                    
                    let resultLisenceNumber = resElement.cDrugLicenseNo!
                    
                    let reslastFourDigLienceNoStr = resultLisenceNumber.suffix(4)
                    //                    print(reslastFourDigLienceNoStr)
                    //                    print(lastFourDigLienceNoStr)
                    if lastFourDigLienceNoStr == reslastFourDigLienceNoStr {
                        mainViewcolorInt[inx] = 1
                        checkListArray[inx] = 1
                        cConbainStoreListArray[inx] = combainStoreJDrugArray[inx].cBrCode ?? ""
                        cDrugLisenceListArray[inx] = combainStoreJDrugArray[inx].cDrugLicenseNo ?? ""
                        
                    }else if mainViewcolorInt[inx] == 3{
                        
                        mainViewcolorInt[inx] = 3
                        checkListArray[inx] = 0
                        cConbainStoreListArray[inx] = "0"
                        cDrugLisenceListArray[inx] = "0"
                        
                    }else{
                        mainViewcolorInt[inx] = 2
                        checkListArray[inx] = 0
                        cConbainStoreListArray[inx] = "0"
                        cDrugLisenceListArray[inx] = "0"
                    }
                }
                
                
                print(checkDuplicatesArray)
                
                self.cominedStoreTableView.reloadData()
                
            }
            
        }else{
            
            comaiStoreButton.backgroundColor = UIColor(hexString: "674cf3",alpha: 0.50)
            comaiStoreButton.isUserInteractionEnabled = false
            checkListArray[sender.tag] = 0
            let getLisenceNo = combainStoreJDrugArray[sender.tag].cDrugLicenseNo!
            let lastFourDigLienceNoStr = getLisenceNo.suffix(4)
            
            for (inx,resElement) in combainStoreJDrugArray.enumerated(){
                
                let resultLisenceNumber = resElement.cDrugLicenseNo!
                
                let reslastFourDigLienceNoStr = resultLisenceNumber.suffix(4)
                //                    print(reslastFourDigLienceNoStr)
                //                    print(lastFourDigLienceNoStr)
//                if lastFourDigLienceNoStr == reslastFourDigLienceNoStr {
//                    mainViewcolorInt[inx] = 1
//                    checkListArray[inx] = 1
//                    cConbainStoreListArray[inx] = combainStoreJDrugArray[inx].cBrCode ?? ""
//                    cDrugLisenceListArray[inx] = combainStoreJDrugArray[inx].cDrugLicenseNo ?? ""
//                    
//                }else
                if mainViewcolorInt[inx] == 3{
                    
                    mainViewcolorInt[inx] = 3
                    checkListArray[inx] = 0
                    cConbainStoreListArray[inx] = "0"
                    cDrugLisenceListArray[inx] = "0"
                    
                }else{
                    mainViewcolorInt[inx] = 1
                    checkListArray[inx] = 0
                    cConbainStoreListArray[inx] = "0"
                    cDrugLisenceListArray[inx] = "0"
                }
            }
            self.cominedStoreTableView.reloadData()
            
        }
    }
    
    
}
extension ComileModuleListViewController:swipeActDelecate{
    func confirm(tapped: Bool) {
        if tapped == true{
            vcViewed = true
        }
    }
    
    func swipeUp(yes: String) {
        vcViewed = true
        comainStoreList(number: mobileNumStr)
    }
    
    
}
//MARK: - Login Api
extension ComileModuleListViewController:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
        
    }
    func comainStoreList(number: String){
        removeAllArray()
        iagreeButton.isUserInteractionEnabled = false

        self.showActivityIndicator(self.view)
        
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        // let mobilecheckParam = [ "c_mobile_no" : number]
        let mobilecheckParam = [ "c_mobile_no" : "\(mobileNumStr)"]
        
        
        
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+COMAIN_STORE_LIST_URL, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            // self.comainnStoreModel = ComainListBaseClass(object: dict)
            print(dict)
            if boolSuccess {
                let resDict = dict as! NSDictionary
                let payloadJsonArray = resDict.value(forKey: "payloadJson") as! NSDictionary
                let dataDict = payloadJsonArray.value(forKey: "data") as! NSDictionary
                self.jDrugLisenceNoArray = dataDict.value(forKey: "j_drug_license_no") as! NSArray
                var resArray = NSArray()
                print(jDrugLisenceNoArray)
                for (_,elmts) in jDrugLisenceNoArray.enumerated(){
                    resArray = elmts as! NSArray
                    self.finalFilterdict = JDrugLicenseNo(object: resArray[0])
                    let fgetLisenceNo = self.finalFilterdict?.cDrugLicenseNo
                    let flastFourDigLienceNoStr = fgetLisenceNo?.suffix(4)
                    
                    for (inx,resElement) in resArray.enumerated() {

                        
                        combainStoreJDrugDict = JDrugLicenseNo(object: resElement)
                        combainStoreJDrugArray.append(combainStoreJDrugDict!)
                        
                        let resultLisenceNumber = combainStoreJDrugDict?.cDrugLicenseNo
                        let resultBartCode = combainStoreJDrugDict?.cBrCode
                        //                        if filterBarCord == resultBartCode{
                        //                            mainViewcolorInt[inx] = 4
                        //
                        //                        }
                        
                        let reslastFourDigLienceNoStr = resultLisenceNumber?.suffix(4)
                        
                        checkListArray.append(0)
                        mainViewcolorInt.append(0)
                        cDrugLisenceListArray.append("0")
                        cConbainStoreListArray.append("0")
                        self.checkDuplicatesArray.append(0)
                        
                        
                        print(flastFourDigLienceNoStr)
                        print(reslastFourDigLienceNoStr)
                        if flastFourDigLienceNoStr == reslastFourDigLienceNoStr {
                           
                            if inx == fBarCodeIndex{
                                //                               mainViewcolorInt[fBarCodeIndex] = 3
                                
                                //print("tr\(fBarCodeIndex)")

                            }else{
                                //                                mainViewcolorInt[inx] = 1
                              
                                //
                            }

                        }else {
                            print("an")
                            mainViewcolorInt[inx] = 2
                            
                            
                        }
                        
                        
                    }

                    if resArray.count == 1{
                       
                        comaiStoreButton.isUserInteractionEnabled = false
                        comaiStoreButton.backgroundColor = UIColor(hexString: "674cf3",alpha: 0.50)
                        filterBarCord = self.finalFilterdict?.cBrCode ?? ""
                        print(filterBarCord)
                        self.fBarCodeIndex = combainStoreJDrugArray.firstIndex(where: {$0.cBrCode == filterBarCord })!
                        mainViewcolorInt[fBarCodeIndex ?? 0] = 3
                        print(mainViewcolorInt)

                        
                    }
                    
                    
                }
                print(combainStoreJDrugArray.count)
                if combainStoreJDrugArray.count == 0 {
                    let loHomeTabVC = self.storyboard?.instantiateViewController(withIdentifier: "LoHomeViewController")
                    as! LoHomeViewController
                    self.navigationController?.pushViewController(loHomeTabVC, animated: true)
                }
                

                print(mainViewcolorInt)
                //FIXME: - Enable disable i agree bbutton
                let hasAllItemsEqual = mainViewcolorInt.dropFirst().reduce(true) { (partialResult, element) in
                    return partialResult && element == mainViewcolorInt.first
                }
                if hasAllItemsEqual  == true{
                    if mainViewcolorInt.contains(2) || mainViewcolorInt.contains(0) {
                        iagreeButton.isUserInteractionEnabled = false

                    }else{
                        iagreeButton.isUserInteractionEnabled = true

                    }
                }else{
                    iagreeButton.isUserInteractionEnabled = false
                }
                
                
                self.cominedStoreTableView.reloadData()
                self.hideActivityIndicator(self.view)
                
            }
            else
            {
                self.hideActivityIndicator(self.view)
                
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.hideActivityIndicator(self.view)
            
        })
    }
    
    func saveComainStoreAurth(mobileNo: String,combainStoreArray:[String],cDrugLisencesArray:[String]){
        self.showActivityIndicator(self.view)
        
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        // let mobilecheckParam = [ "c_mobile_no" : number]
        let mobilecheckParam = [ "c_mobile_no":"\(mobileNumStr)",
                                 "c_combine_store_list":cDrugLisencesArray,
                                 "c_drug_license_list":combainStoreArray] as [String : Any]
        print(mobilecheckParam)
        
        
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SAVE_COMBAIED_STORE_UNAURTH, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.combainStoreSaveModel = CombainStoreSaveBaseClass(object: dict)
            print(dict)
            if boolSuccess {
                if self.combainStoreSaveModel?.appStatusCode == 0{
                    
                    comainStoreList(number: mobileNumStr)
                    if #available(iOS 13.0, *) {
                        UserDefaults.standard.setValue(2, forKey: "data") //setObject
                        UserDefaults.standard.setValue(self.combainStoreSaveModel?.payloadJson?.data?.jRegister?.key, forKey: ketConstantStr)
                        UserDefaults.standard.setValue(self.combainStoreSaveModel?.payloadJson?.data?.jRegister?.token, forKey: tokenConstantStr)
                        UserDefaults.standard.setValue(self.combainStoreSaveModel?.payloadJson?.data?.jRegister?.cType, forKey: typeConstantStr)

                        let landingVc = self.storyboard?.instantiateViewController(identifier: "LoHomeViewController") as! LoHomeViewController
                        self.navigationController?.pushViewController(landingVc, animated: true)

                    } else {
                        // Fallback on earlier versions
                    }
                    
                }else{
                    self.hideActivityIndicator(self.view)
                    
                }
                
            }
            else {
                self.hideActivityIndicator(self.view)
                
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            self.hideActivityIndicator(self.view)
            
        })
    }
    
    func comainStoreNA(mobileNo: String,combainStoreArray:[String],cDrugLisencesArray:[String]){
        self.showActivityIndicator(self.view)
        
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        // let mobilecheckParam = [ "c_mobile_no" : number]
        let mobilecheckParam = [ "c_mobile_no" : "\(mobileNumStr)",
                                 "c_combine_store_list":combainStoreArray,
                                 "c_drug_license_list":cDrugLisencesArray] as [String : Any]
        print(mobilecheckParam)
        
        
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+COMAIN_STORE_NS_URL, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.combainStoreNAModel = CombainStoreNABaseClass(object: dict)
            print(dict)
            if boolSuccess {
                if self.combainStoreNAModel?.appStatusCode == 0{
                    
                    UserDefaults.standard.setValue(self.combainStoreNAModel?.payloadJson?.jRegister?.key, forKey: ketConstantStr)
                    print(ketConstantStr)
                    UserDefaults.standard.setValue(self.combainStoreNAModel?.payloadJson?.jRegister?.token, forKey: tokenConstantStr)
                    UserDefaults.standard.setValue(self.combainStoreNAModel?.payloadJson?.jRegister?.cType, forKey: typeConstantStr)
                    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "CombinePopUpVC") as! CombinePopUpVC
                    vc.storeName = combainStoreNAModel?.payloadJson?.jStore?.cFirmName ?? ""
                    vc.drugLic = combainStoreNAModel?.payloadJson?.jStore?.cDrugLicenseNo ?? ""
                    vc.gstinNum = combainStoreNAModel?.payloadJson?.jStore?.cGstNumber ?? ""
                    vc.pinCode = combainStoreNAModel?.payloadJson?.jStore?.cPincode ?? ""
                    vc.state = combainStoreNAModel?.payloadJson?.jStore?.cStateName ?? ""
                    vc.stateCode = combainStoreNAModel?.payloadJson?.jStore?.cStateCode ?? ""
                    vc.city = combainStoreNAModel?.payloadJson?.jStore?.cCityName ?? ""
                    vc.cityCode = combainStoreNAModel?.payloadJson?.jStore?.cCityCode ?? ""
                    vc.area = combainStoreNAModel?.payloadJson?.jStore?.cAreaName ?? ""
                    vc.areaCode = combainStoreNAModel?.payloadJson?.jStore?.cAreaCode ?? ""
                    vc.brCode = combainStoreNAModel?.payloadJson?.jStore?.cBrCode ?? ""
                    vc.addTwo = combainStoreNAModel?.payloadJson?.jStore?.cAddressNo2
                    vc.email = combainStoreNAModel?.payloadJson?.jStore?.cEmailId ?? ""
                    vc.delegate = self
                    self.present(vc, animated: false, completion: nil)
                    
                    
                    
                }else{
                    self.hideActivityIndicator(self.view)
                    
                }
                
            }
            else {
                self.hideActivityIndicator(self.view)
                
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            self.hideActivityIndicator(self.view)
            
        })
    }
    
    func comainStoreA(mobileNo: String,combainStoreArray:[String],cDrugLisencesArray:[String]){
        self.showActivityIndicator(self.view)
        
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        // let mobilecheckParam = [ "c_mobile_no" : number]
        let mobilecheckParam = [ "c_mobile_no" : "\(mobileNumStr)",
                                 "c_combine_store_list":combainStoreArray,
                                 "c_drug_license_list":cDrugLisencesArray] as [String : Any]
        print(mobilecheckParam)
        
        let ListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                       "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                       "Content-Type":"application/json",
        ]
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+COMBINE_STORE_AUTH, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: ListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.combainStoreNAModel = CombainStoreNABaseClass(object: dict)
            print(dict)
            if boolSuccess {
                if self.combainStoreNAModel?.appStatusCode == 0{
                    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "CombinePopUpVC") as! CombinePopUpVC
                    vc.storeName = combainStoreNAModel?.payloadJson?.jStore?.cFirmName ?? ""
                    vc.drugLic = combainStoreNAModel?.payloadJson?.jStore?.cDrugLicenseNo ?? ""
                    vc.gstinNum = combainStoreNAModel?.payloadJson?.jStore?.cGstNumber ?? ""
                    vc.pinCode = combainStoreNAModel?.payloadJson?.jStore?.cPincode ?? ""
                    vc.state = combainStoreNAModel?.payloadJson?.jStore?.cStateName ?? ""
                    vc.stateCode = combainStoreNAModel?.payloadJson?.jStore?.cStateCode ?? ""
                    vc.city = combainStoreNAModel?.payloadJson?.jStore?.cCityName ?? ""
                    vc.cityCode = combainStoreNAModel?.payloadJson?.jStore?.cCityCode ?? ""
                    vc.area = combainStoreNAModel?.payloadJson?.jStore?.cAreaName ?? ""
                    vc.areaCode = combainStoreNAModel?.payloadJson?.jStore?.cAreaCode ?? ""
                    vc.brCode = combainStoreNAModel?.payloadJson?.jStore?.cBrCode ?? ""
                    vc.addTwo = combainStoreNAModel?.payloadJson?.jStore?.cAddressNo2
                    vc.email = combainStoreNAModel?.payloadJson?.jStore?.cEmailId ?? ""
                    vc.delegate = self
                    self.present(vc, animated: false, completion: nil)
                    
                    
                    
                }else{
                    self.hideActivityIndicator(self.view)
                    
                }
                
            }
            else {
                self.hideActivityIndicator(self.view)
                
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            self.hideActivityIndicator(self.view)
            
        })
    }
    func ComainStoreAuth(mobileNo: String,combainStoreArray:[String],cDrugLisencesArray:[String]){
        self.showActivityIndicator(self.view)
        
        let mobilecheck:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Login")
        
        // let mobilecheckParam = [ "c_mobile_no" : number]
        let mobilecheckParam = [ "c_mobile_no" : "\(mobileNumStr)",
                                 "c_combine_store_list":cDrugLisencesArray,
                                 "c_drug_license_list":combainStoreArray] as [String : Any]
        
        print(mobilecheckParam)
        let comHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        
        mobilecheck.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SAVE_COMBAIED_STORE_AURTH, type: .post, userData: mobilecheckParam as [String : Any], apiHeader: comHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.combainStoreNAModel = CombainStoreNABaseClass(object: dict)
            print(dict)
            if boolSuccess {
                if self.combainStoreNAModel?.appStatusCode == 0{
                    
                    if #available(iOS 13.0, *) {
                        UserDefaults.standard.setValue(2, forKey: "data") //setObject
                        let landingVc = self.storyboard?.instantiateViewController(identifier: "LoHomeViewController") as! LoHomeViewController
                        self.navigationController?.pushViewController(landingVc, animated: true)
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }else{
                    self.hideActivityIndicator(self.view)
                    
                }
                
            }
            else {
                self.hideActivityIndicator(self.view)
                
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            self.hideActivityIndicator(self.view)
            
        })
    }
    //MARK: - Remove elements from array
    func removeAllArray(){
        
        combainStoreJDrugArray.removeAll()
        checkListArray.removeAll()
        mainViewcolorInt.removeAll()
        cDrugLisenceListArray.removeAll()
        cConbainStoreListArray.removeAll()
        
    }
    
}


