//
//  OrderToSellFiltterVC.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit
import Alamofire
import SwiftUI

class OrderToSellFiltterVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var filtterLbl: UILabel!
    @IBOutlet weak var retriveLbl: UILabel!
    @IBOutlet weak var clearAllBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var dotLine: UIView!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var catogeriesTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    var filterlist = ["State","City","Area"]
    
    
    var stateModel : StateListModel?
    var cityModel : StateListModel?
    var areaModel : StateListModel?
    
    var cityCode : String?
    var areaCode : String?
    
    var stateNameStr = String()
    var cityNameStr = String()
    var areaNameStr = String()
    
    
    var stateCheckInt = [Int]()
    var selectedRows = [IndexPath]()
    var isDoneSelectedInt = 0
    
    
    var selectindex = 0
    var smartorder : Int?
    
    var filIndx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        stateApiCall()
    }
    func setup(){
        searchTxtField.placeholder = "Search State"
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search_icon")
        imageView.image = image
        
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        
        padView.addSubview(imageView)
        searchTxtField.leftView = padView
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        
        searchTxtField.delegate = self
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5217301325)
        
        dotLine.drawDottedLine(start: CGPoint(x: dotLine.bounds.minX, y: dotLine.bounds.minY), end: CGPoint(x: dotLine.bounds.maxX, y: dotLine.bounds.minY), view: dotLine)
        self.topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        catogeriesTableView.delegate = self
        catogeriesTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.dataSource = self
        catogeriesTableView.register(UINib(nibName: "FiltterCatListTableViewCell", bundle: nil), forCellReuseIdentifier: "FiltterCatListTableViewCell")
        resultTableView.register(UINib(nibName: "OptionLIstTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionLIstTableViewCell")
        self.searchTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        
       
    }
    
    //MARK: - Keyoard Done Button
    @objc func doneButtonClicked(_ sender: Any) {
        isDoneSelectedInt = 1

      //  self.searchTxtField.resignFirstResponder()
    }
    

    
    
}
extension OrderToSellFiltterVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == catogeriesTableView {
            return filterlist.count
        }
        if tableView == resultTableView{
            if selectindex == 0 {
                return stateModel?.payloadJson?.data?.count ?? 0
            }
            if selectindex == 1 {
                return cityModel?.payloadJson?.data?.count ?? 0
                
            }
            if selectindex == 2 {
                return areaModel?.payloadJson?.data?.count ?? 0
                
            }
            
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == catogeriesTableView {
            let filttercell = tableView.dequeueReusableCell(withIdentifier: "FiltterCatListTableViewCell") as! FiltterCatListTableViewCell
            filttercell.catListLbl.text = filterlist[indexPath.row]
            filttercell.selectedBackgroundView?.backgroundColor = .white
            if indexPath.row == filIndx{
                filttercell.overView.backgroundColor = .white
                filttercell.backgroundColor = .white
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40")
               
            }else{
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40",alpha:  0.50)
                filttercell.overView.backgroundColor = UIColor(hexString: "c3cde4",alpha:  0.30)
            }
           
            return filttercell
        }
        else{
            let listoptioncell = tableView.dequeueReusableCell(withIdentifier: "OptionLIstTableViewCell") as! OptionLIstTableViewCell
            listoptioncell.checkBoxBtn.tag = indexPath.row
            listoptioncell.tag = indexPath.row
            
            listoptioncell.checkBoxBtn.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
            
            
            let isIndexValid = stateCheckInt.indices.contains(indexPath.row)
            
            if isIndexValid == true {
                
                let checkListInt = stateCheckInt[indexPath.row]
                
                if checkListInt == 1{
                    

                    listoptioncell.checkBoxBtn.backgroundColor = UIColor(hexString: "674CF3")
                    listoptioncell.checkBoxBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
                    listoptioncell.checkBoxBtn.isSelected = true
                    
                }else{
                    listoptioncell.checkBoxBtn.borderColor = UIColor(hexString: "C3CDE4")
                    listoptioncell.checkBoxBtn.borderWidth = 1.0
                    listoptioncell.checkBoxBtn.clipsToBounds = true
                    listoptioncell.checkBoxBtn.backgroundColor = .white
                    listoptioncell.checkBoxBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
                    listoptioncell.checkBoxBtn.isSelected = false
                    
                }
            }
            
            if selectindex == 0 {
                
                listoptioncell.listLbl.text = stateModel?.payloadJson?.data?[indexPath.row].cName ?? ""
                listoptioncell.optionOverView.backgroundColor = .white
            }
            if selectindex == 1 {
                listoptioncell.listLbl.text = cityModel?.payloadJson?.data?[indexPath.row].cName ?? ""
                listoptioncell.optionOverView.backgroundColor = .white
                
            }
            if selectindex == 2 {
                
                listoptioncell.listLbl.text = areaModel?.payloadJson?.data?[indexPath.row].cName ?? ""
                listoptioncell.optionOverView.backgroundColor = .white
            }
            
          
           
            
            
            return listoptioncell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == catogeriesTableView{

            if indexPath.row == 0 {
                filIndx = 0
                selectindex = 0
                stateApiCall()
                searchTxtField.text = ""
                searchTxtField.placeholder = "Search State"
                stateApiCall()
                catogeriesTableView.reloadData()
                // resultTableView.reloadData()
            }
            else if indexPath.row == 1 {
                filIndx = 1
                selectindex = 1
                searchTxtField.text = ""
                searchTxtField.placeholder = "Search City"
                cityApiCall(cityCodeStr: cityCode ?? "")
                catogeriesTableView.reloadData()
                //resultTableView.reloadData()
            }
            else if indexPath.row == 2 {
                filIndx = 2
                selectindex = 2
                searchTxtField.text = ""
                searchTxtField.placeholder = "Search Area"
                catogeriesTableView.reloadData()
                areaApiCall(areaCodeStr: areaCode ?? "")

            }


        }
//        if tableView == resultTableView{
//
//            applyBtn.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.2980392157, blue: 0.9529411765, alpha: 1)
//            let cell:OptionLIstTableViewCell = tableView.cellForRow(at: indexPath) as! OptionLIstTableViewCell
//            print(cell.tag)
////            if selectindex == 0{
////                cityCode = stateModel?.payloadJson?.data?[cell.tag].cCode
////                print(stateModel?.payloadJson?.data?[cell.tag].cCode ?? "")
////            }else if selectindex == 1 {
////                areaCode = cityModel?.payloadJson?.data?[cell.tag].cCode
////                print(cityModel?.payloadJson?.data?[cell.tag].cCode ?? "")
////            }
//
//
//        }
    }
  
 
}
//MARK: - Button Action
extension OrderToSellFiltterVC {
    //FIXME: - Check Button Action
    @objc func buttonClicked(sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if selectindex == 0{
            for (inx,element) in (self.stateModel?.payloadJson?.data)!.enumerated() {
                if inx == sender.tag{
                    self.stateCheckInt[inx] = 1
                   
                }else{
                    self.stateCheckInt[inx] = 0
                    
                }
            }
            self.stateNameStr = stateModel?.payloadJson?.data?[sender.tag].cName ?? ""
            print( self.stateNameStr)
            cityCode = stateModel?.payloadJson?.data?[sender.tag].cCode
        }else if selectindex == 1{
            for (inx,element) in (self.cityModel?.payloadJson?.data)!.enumerated() {
                if inx == sender.tag{
                    self.stateCheckInt[inx] = 1
                }else{
                    self.stateCheckInt[inx] = 0
                    
                }
            }
            self.cityNameStr = cityModel?.payloadJson?.data?[sender.tag].cName ?? ""
            print( self.cityNameStr)
            areaCode = cityModel?.payloadJson?.data?[sender.tag].cCode

            
        }else if selectindex == 2{
            for (inx,element) in (self.areaModel?.payloadJson?.data)!.enumerated() {
                if inx == sender.tag{
                    self.stateCheckInt[inx] = 1
                   
                }else{
                    self.stateCheckInt[inx] = 0
                    
                }
                
            }
//            areaCode = cityModel?.payloadJson?.data![sender.tag].cCode ?? ""
//            self.areaNameStr = areaModel?.payloadJson?.data?[sender.tag].cName ?? ""
        }
        self.searchTxtField.resignFirstResponder()
        self.resultTableView.reloadData()
        
        applyBtn.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.2980392157, blue: 0.9529411765, alpha: 1)
        
    }
    
    @IBAction func closeBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderToSellerVC") as? OrderToSellerVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func applyBtnAct(_ sender: Any) {
        
        let orderSelleVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderToSellerVC") as! OrderToSellerVC
        orderSelleVC.aStateStr = self.stateNameStr
        orderSelleVC.aStateStr = self.cityNameStr
        orderSelleVC.aAreaStr = self.areaNameStr
        
        orderSelleVC.isApplyButtonSelectedInt = 1
        self.navigationController?.pushViewController(orderSelleVC, animated: true)
    }
    
    @IBAction func clearAllBtnAct(_ sender: Any) {
    }
}
extension OrderToSellFiltterVC : UITextFieldDelegate{
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTxtField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if selectindex == 0 {
            if searchTxtField.text?.count ?? 0 >= 3{
              
                    searchStateCall(textStr: searchTxtField.text ?? "")
            }
            else{
                stateApiCall()
            }
        }else if selectindex == 1{
            if searchTxtField.text?.count ?? 0 >= 3{
                
                searchCityCall(textStr:  searchTxtField.text ?? "")
                
            }else{
                cityApiCall(cityCodeStr: cityCode ?? "")
            }
        }else{
            if searchTxtField.text?.count ?? 0 >= 3{
                searchAreaCall(textStr:  searchTxtField.text ?? "")
            }else{
                
                areaApiCall(areaCodeStr: areaCode ?? "")
            }
        }
        
        return true
    }
}
extension OrderToSellFiltterVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension OrderToSellFiltterVC : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func stateApiCall(){
        self.stateCheckInt.removeAll()
        showActivityIndicator(self.view)
        let stateList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "StateList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        stateList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+STATE_LIST_URL, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.stateModel = StateListModel(object:dict)
            if boolSuccess {
                if self.stateModel?.payloadJson?.data != nil{
                    for (_,element) in (self.stateModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                        
                    }
                }else{
                    
                }
                
                
                
                resultTableView.reloadData()
                
                
                
                
            }else{
                
                
            }
            hideActivityIndicator(self.view)
        }, failureBlock: {[unowned self] (errorMesssage) in
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
    
    
    
    func cityApiCall(cityCodeStr:String){
        self.stateCheckInt.removeAll()
        
        showActivityIndicator(self.view)
        let cityList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "CityList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        cityList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+CITY_LIST_URL + cityCodeStr, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.cityModel = StateListModel(object:dict)
            print(dict)
            if boolSuccess {
                if self.cityModel?.payloadJson?.data != nil{
                    for (_,element) in (self.cityModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                    }
                }else{
                    print("no data")
                }
                
                
                resultTableView.reloadData()
                
                
            }else{
                
                
            }
            hideActivityIndicator(self.view)
        }, failureBlock: {[unowned self] (errorMesssage) in
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
    func areaApiCall(areaCodeStr:String){
        
        print(areaCode)
        self.stateCheckInt.removeAll()
        let areaList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AreaList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        areaList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+AREA_LIST_URL + areaCodeStr, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.areaModel = StateListModel(object:dict)
            print(dict)
            if boolSuccess {
                if self.areaModel?.payloadJson?.data != nil{
                    
                    for (_,element) in (self.areaModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                    }
                }else{
                    print("no data")
                }
                
                resultTableView.reloadData()
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
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
    func searchStateCall(textStr : String){
        self.stateCheckInt.removeAll()
        showActivityIndicator(self.view)
        let searchState:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "StateList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let searchStateParams = ["c_search_term": textStr]
        let searchStateHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                              "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                              "Content-Type":"application/json",
        ]
        
        searchState.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_STATE_LIST_URL, type: .post, userData: searchStateParams, apiHeader: searchStateHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.stateModel = StateListModel(object:dict)
            if boolSuccess {
                
                if self.stateModel?.payloadJson?.data != nil{
                    for (_,element) in (self.stateModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                    }
                }else{
                    print("no data")
                }
               
                
                
                resultTableView.reloadData()
                
                
                
                
            }else{
                
                
            }
            hideActivityIndicator(self.view)
        }, failureBlock: {[unowned self] (errorMesssage) in
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
    func searchCityCall(textStr : String){
        self.stateCheckInt.removeAll()
        showActivityIndicator(self.view)
        let searchCity:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "StateList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let searchCityParams = ["c_code":cityCode,
                                "c_search_term":textStr]
        let searchCityHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                             "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                             "Content-Type":"application/json",
        ]
        
        searchCity.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_CITY_LIST_URL, type: .post, userData: searchCityParams as [String : Any], apiHeader: searchCityHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.cityModel = StateListModel(object:dict)
            print( dict)
            if boolSuccess {
                if self.cityModel?.payloadJson?.data !=  nil{
                    for (_,element) in (self.cityModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                    }
                }else{
                    print("no data")
                }
                
               
                
                resultTableView.reloadData()
                
                
                
                
            }else{
                
                
            }
            hideActivityIndicator(self.view)
        }, failureBlock: {[unowned self] (errorMesssage) in
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
    func searchAreaCall(textStr : String){
        self.stateCheckInt.removeAll()
        showActivityIndicator(self.view)
        let searchArea:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "StateList")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let searchAreaParams = ["c_code":areaCode,
                                "c_search_term":textStr]
        let searchAreaHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                             "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                             "Content-Type":"application/json",
        ]
        
        searchArea.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_AREA_LIST_URL, type: .post, userData: searchAreaParams as [String : Any], apiHeader: searchAreaHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.areaModel = StateListModel(object:dict)
            print( dict)
            if boolSuccess {
                if self.areaModel?.payloadJson?.data != nil{
                    for (_,element) in (self.areaModel?.payloadJson?.data)!.enumerated() {
                        
                        self.stateCheckInt.append(0)
                    }
                }else{
                   print("no data")
                }
                
                
                resultTableView.reloadData()
                
                
                
                
            }else{
                
                
            }
            hideActivityIndicator(self.view)
        }, failureBlock: {[unowned self] (errorMesssage) in
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
