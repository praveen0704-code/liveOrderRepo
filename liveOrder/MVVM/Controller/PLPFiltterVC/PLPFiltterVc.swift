//
//  PLPFiltterVc.swift
//  liveOrder
//
//  Created by Data Prime on 30/08/21.
//

import UIKit
import Alamofire
import CCBottomRefreshControl

class PLPFiltterVc: UIViewController {
    @IBOutlet weak var filtterLbl: UILabel!
    @IBOutlet weak var lookingLbl: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var dotLineView: DashedLineView!
    @IBOutlet weak var categoriesTableVIew: UITableView!
    @IBOutlet weak var optionListTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    var filterlist = ["Manufacturers","Brands","Sellers","Availability","Discounts"]
    var mfcFiltterModel : FiltterMfcModel?
    var mfcArrayItems : [FiltterMfcJList]?
    var brandFiltterModel:FiltterBrandModel?
    var brandArrayItems : [FiltterBrandJList]?
    var sellerFiltterModel : FiltterSellerModel?
    var sellerArrayItems:[FiltterSellerJList]?
    var discountInt = [Int]()
    var mfcCheckInt = [Int]()
    var mfcArr = [String]()
    var brandCheckInt = [Int]()
    var brandArr = [String]()
    var sellerCheckInt = [Int]()
    var sellerArr = [String]()
    var availableCheckInt = [Int]()
    var availString = String()
    
    var availabllity = ["In Stock","Out Of Stock"]
    var discount = ["40% & above","30% & above","20% & above","10% & above"]
    var selectindex : Int?
    var smartorder : Int?
    var checkBtn : Int?
    var filIndx = 0
    var viewAllInt : Int?
    var sellerName : String?
    var mfcCode : String?
    var pin:String?
    var nextPageInt = 0
    var isNextPageAPICall = false
    
  
     
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let bottomRefreshController = UIRefreshControl()
        
        bottomRefreshController.triggerVerticalOffset = 50
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.attributedTitle = NSMutableAttributedString(string: "Loading...")
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        
        optionListTableView.bottomRefreshControl = bottomRefreshController
        for (i,ele) in (availabllity).enumerated(){
            availableCheckInt.append(0)
        }
       
        setup()
        self.optionListTableView.allowsMultipleSelection = true
        self.optionListTableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    func setup(){
        if filIndx == 0{
            filIndx = 0
            selectindex = 0
            manufactureFiltter()
        }else if filIndx == 1{
            filIndx = 1
            selectindex = 1
            brandFilter()
        }else if filIndx == 2{
            filIndx = 2
            selectindex = 2
            sellerFilter()
        }
        
        searchTxtField.delegate = self
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search_icon")
        imageView.image = image
        
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        
        padView.addSubview(imageView)
        searchTxtField.leftView = padView
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5217301325)
        
        
        self.blueView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        categoriesTableVIew.delegate = self
        categoriesTableVIew.dataSource = self
        optionListTableView.delegate = self
        optionListTableView.dataSource = self
        categoriesTableVIew.register(UINib(nibName: "FiltterCatListTableViewCell", bundle: nil), forCellReuseIdentifier: "FiltterCatListTableViewCell")
        optionListTableView.register(UINib(nibName: "OptionLIstTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionLIstTableViewCell")
        
    }
    @objc func refreshBottom(){
        if filIndx == 0{
            nextPageInt = mfcFiltterModel?.payloadJson?.data?.nNextPage ?? 0
            isNextPageAPICall = true
            manufactureFiltter()
        }else if filIndx == 1{
            nextPageInt = brandFiltterModel?.payloadJson?.data?.nNextPage ?? 0
            isNextPageAPICall = true
            brandFilter()
            
        }else if filIndx == 2{
            nextPageInt = sellerFiltterModel?.payloadJson?.data?.nNextPage ?? 0
            isNextPageAPICall = true
            sellerFilter()
        }else{
            
        }
        
    }
    
    @IBAction func applyBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = viewAllInt
        vc?.mfcCode = mfcCode
        vc?.sellerName = sellerName
        vc?.pinCode = pin
        vc?.availability = availString
        vc?.brands = brandArr
        vc?.manufacturers = mfcArr
        vc?.sellers = sellerArr
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func closeBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = viewAllInt
        vc?.mfcCode = mfcCode
        vc?.sellerName = sellerName
        vc?.pinCode = pin
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func clearBtnAct(_ sender: Any) {
        availString.removeAll()
        brandArr.removeAll()
        mfcArr.removeAll()
        sellerArr.removeAll()
        mfcCheckInt.removeAll()
        brandCheckInt.removeAll()
        sellerCheckInt.removeAll()
        discountInt.removeAll()
        
        setup()
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
extension PLPFiltterVc:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoriesTableVIew{
            if smartorder == 1 {
                return 3
            }else{
                return filterlist.count
            }
            
        }
        if tableView == optionListTableView{
            if selectindex == 0 {
                return mfcArrayItems?.count ?? 5
            }
            if selectindex == 1 {
                return brandArrayItems?.count ?? 5
                
            }
            if selectindex == 2 {
                return sellerArrayItems?.count ?? 5
                
            }
            if selectindex == 3 {
                return availabllity.count
                
                
            }
            if selectindex == 4 {
                return discount.count
            }
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoriesTableVIew {
            let filttercell = tableView.dequeueReusableCell(withIdentifier: "FiltterCatListTableViewCell") as! FiltterCatListTableViewCell
            filttercell.catListLbl.text = filterlist[indexPath.row]
            
            if indexPath.row == filIndx{
                filttercell.overView.backgroundColor = .white
                filttercell.backgroundColor = .white
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40")
                
            }else{
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40",alpha:  0.50)
                filttercell.overView.backgroundColor = UIColor(hexString: "c3cde4",alpha:  0.30)
            }
            
            return filttercell
        } else {
            
            let listoptioncell = tableView.dequeueReusableCell(withIdentifier: "OptionLIstTableViewCell") as! OptionLIstTableViewCell
            listoptioncell.checkBoxBtn.tag = indexPath.row
            listoptioncell.tag = indexPath.row
            if filIndx == 0{
                let isIndexValid = mfcCheckInt.indices.contains(indexPath.row)
                
                if isIndexValid == true {
                    let checkListInt = mfcCheckInt[indexPath.row]
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
                
            }else if filIndx == 1{
                let isIndexValid = brandCheckInt.indices.contains(indexPath.row)
                
                if isIndexValid == true {
                    let checkListInt = brandCheckInt[indexPath.row]
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
            }else if filIndx == 2 {
                let isIndexValid = sellerCheckInt.indices.contains(indexPath.row)
                
                if isIndexValid == true {
                    let checkListInt = sellerCheckInt[indexPath.row]
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
            }else if filIndx == 3 {
                let isIndexValid = availableCheckInt.indices.contains(indexPath.row)
                
                if isIndexValid == true {
                    let checkListInt = availableCheckInt[indexPath.row]
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
            }else{
                let isIndexValid = discountInt.indices.contains(indexPath.row)
                
                if isIndexValid == true {
                    let checkListInt = discountInt[indexPath.row]
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
            }
            listoptioncell.checkBoxBtn.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
            
            
            if selectindex == 0 {
                listoptioncell.listLbl.text = mfcArrayItems?[indexPath.row].cMfcName
            }
            if selectindex == 1 {
                listoptioncell.listLbl.text = brandArrayItems?[indexPath.row].cBrandName
            }
            if selectindex == 2 {
                listoptioncell.listLbl.text = sellerArrayItems?[indexPath.row].cSellerName
            }
            if selectindex == 3 {
                listoptioncell.listLbl.text = availabllity[indexPath.row]
            }
            if selectindex == 4 {
                listoptioncell.listLbl.text = discount[indexPath.row]
            }
            
            if mfcCheckInt.contains(1) || brandCheckInt.contains(1)||sellerCheckInt.contains(1)||availableCheckInt.contains(1) || discountInt.contains(1) {
                print("yes")
                applyBtn.backgroundColor = UIColor(hexString: "674cf3")

            }else{
                applyBtn.backgroundColor = UIColor(hexString: "c3cde4",alpha: 0.50)

            }
            return listoptioncell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoriesTableVIew{
            let cell:FiltterCatListTableViewCell = (tableView.cellForRow(at: indexPath) as? FiltterCatListTableViewCell)!
            
            if indexPath.row == 0 {
                searchTxtField.text = ""
                filIndx = 0
                selectindex = 0
                manufactureFiltter()
                
            }
            else if indexPath.row == 1 {
                searchTxtField.text = ""
                filIndx = 1
                selectindex = 1
                brandFilter()
            }
            else if indexPath.row == 2 {
                searchTxtField.text = ""
                filIndx = 2
                selectindex = 2
                sellerFilter()
            }
            else if indexPath.row == 3 {
                searchTxtField.text = ""
                filIndx = 3
                selectindex = 3
                categoriesTableVIew.reloadData()
                optionListTableView.reloadData()
            }
            else if indexPath.row == 4 {
                discountInt.removeAll()
                filIndx = 4
                selectindex = 4
                for (i,ele) in (discount).enumerated(){
                    discountInt.append(0)

                }
                categoriesTableVIew.reloadData()
                optionListTableView.reloadData()
            }
        }
        if tableView == optionListTableView{
            
            let cell = tableView.cellForRow(at: indexPath)
            if filIndx == 0{
                if mfcCheckInt[cell!.tag] == 1{
                    print(mfcArrayItems?[cell!.tag])
                    mfcCheckInt[cell!.tag] = 0
                    print(mfcCheckInt)
                    
                    
                    
                }else{
                    print(mfcArrayItems?[cell!.tag])
                    mfcArr.append(mfcArrayItems?[cell!.tag].cMfcCode ?? "")
                    print(mfcArr)
                    mfcCheckInt[cell!.tag] = 1
                    print(mfcCheckInt)
                   
                    
                }
            }else if filIndx == 1{
                if brandCheckInt[cell!.tag] == 1{
                    print(brandArrayItems?[cell!.tag])
                    
                    brandCheckInt[cell!.tag] = 0
                    
                     
                    
                    print(brandCheckInt)
                    
                    
                }else{
                    print(brandArrayItems?[cell!.tag])
                    brandArr.append(brandArrayItems?[cell!.tag].cBrandCode ?? "")
                    print(mfcArr)
                    brandCheckInt[cell!.tag] = 1
                    print(brandCheckInt)
                    
                     
                }
                
            }else if filIndx == 2{
                if sellerCheckInt[cell!.tag] == 1{
                    print(sellerArrayItems?[cell!.tag])
                    
                    sellerCheckInt[cell!.tag] = 0
                    print(sellerCheckInt)
                    
                    
                    
                    
                }else{
                    print(sellerArrayItems?[cell!.tag])
                    sellerArr.append(sellerArrayItems?[cell!.tag].cSellerCode ?? "")
                    print(sellerArr)
                    sellerCheckInt[cell!.tag] = 1
                    print(sellerCheckInt)
                    
                   
                }
                
            }else if filIndx == 3{
                if availableCheckInt[cell!.tag] == 1{
                    availableCheckInt[cell!.tag] = 0
                    availString = "N"
                
                }else{
                    print(availabllity[cell!.tag])
                    
                    availableCheckInt[cell!.tag] = 1
                    
                   
                    if cell!.tag == 0{
                        availString = "Y"
                    }else{
                        availString = "N"
                    }
                }
                
            }else{
                
                
                
            }
            
            optionListTableView.reloadData()
            
            applyBtn.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.2980392157, blue: 0.9529411765, alpha: 1)
        }
        
    }
    
    
    @objc func buttonClicked(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        
        if filIndx == 0{
            if sender.isSelected{
                print(mfcArrayItems?[sender.tag])
                mfcArr.append(mfcArrayItems?[sender.tag].cMfcCode ?? "")
                print(mfcArr)
                mfcCheckInt[sender.tag] = 1
                print(mfcCheckInt)
               
                
            }else{
                print(mfcArrayItems?[sender.tag])
                
                mfcCheckInt[sender.tag] = 0
                print(mfcCheckInt)
               
                
            }
        }else if filIndx == 1{
            if sender.isSelected{
                print(brandArrayItems?[sender.tag])
                brandArr.append(brandArrayItems?[sender.tag].cBrandCode ?? "")
                print(mfcArr)
                brandCheckInt[sender.tag] = 1
                print(brandCheckInt)
                
                
                
            }else{
                print(brandArrayItems?[sender.tag])
                
                brandCheckInt[sender.tag] = 0
                print(brandCheckInt)
                
                
                
            }
            
        }else if filIndx == 2{
            if sender.isSelected{
                print(sellerArrayItems?[sender.tag])
                sellerArr.append(sellerArrayItems?[sender.tag].cSellerCode ?? "")
                print(sellerArr)
                sellerCheckInt[sender.tag] = 1
                print(sellerCheckInt)
                
                
                
            }else{
                print(sellerArrayItems?[sender.tag])
                
                sellerCheckInt[sender.tag] = 0
                print(sellerCheckInt)
                
            
                
            }
            
        }else if filIndx == 3{
            if sender.isSelected{
                print(availabllity[sender.tag])
              
                availableCheckInt[sender.tag] = 1
                if sender.tag == 0{
                    availString = "Y"
                }else{
                    availString = "N"
                }
                
                
            }else{
                
               
                availableCheckInt[sender.tag] = 0
                availString = "N"
            }
            
        }else{
            if sender.isSelected{
                
                discountInt[sender.tag] = 1

            }else{
                
                discountInt[sender.tag] = 0
         
            }
            print(discountInt)
            optionListTableView.reloadData()

        }
        
        
        optionListTableView.reloadData()
    }
}
extension PLPFiltterVc:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTxtField{
            if (searchTxtField.text! + string).count >= 3{
                searchList(txt: searchTxtField.text! + string)
            }
        }
        return true
    }
    
}
extension PLPFiltterVc:WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func manufactureFiltter(){
        self.showActivityIndicator(self.view)
        
        let manufacture:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "manufacture")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let mfcParams = ["c_state_code": UserDefaults.standard.value(forKey:DefaultstateCodeStr) ?? "",
                         "n_limit": 20,
                         "n_page": nextPageInt] as [String : Any]
        
        let mfcHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        
        manufacture.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+MANUFACTURE_FILTTER_URL, type: .post, userData: mfcParams, apiHeader: mfcHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.mfcFiltterModel = FiltterMfcModel(object:dict)
            
            if boolSuccess {
                
                if self.isNextPageAPICall {
                    
                    if let sellerInspiredVal = mfcFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.mfcArrayItems = self.mfcArrayItems!.count > 0 ? self.mfcArrayItems! + sellerInspiredVal : sellerInspiredVal
                            for (i,ele) in (mfcArrayItems)!.enumerated(){
                                mfcCheckInt.append(0)
                                
                            }
                            isNextPageAPICall = false
                            
                        }
                    }
                    self.hideActivityIndicator(self.view)
                }
                else{
                    if let sellerInspiredVal = mfcFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.mfcArrayItems = sellerInspiredVal
                            for (i,ele) in (mfcArrayItems)!.enumerated(){
                                mfcCheckInt.append(0)
                            }
                        }
                    }
                }
                self.hideActivityIndicator(self.view)

                
                categoriesTableVIew.reloadData()
                optionListTableView.reloadData()
                hideActivityIndicator(self.view)
                optionListTableView.bottomRefreshControl?.endRefreshing()
            }else{
                optionListTableView.bottomRefreshControl?.endRefreshing()
                hideActivityIndicator(self.view)
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.hideActivityIndicator(self.view)

            
        })
        
        
    }
    func brandFilter(){
        self.showActivityIndicator(self.view)

        let brand:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "brand")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let brandParams = ["c_state_code": UserDefaults.standard.value(forKey:DefaultstateCodeStr) ?? "",
                           "n_limit": 20,
                           "n_page": nextPageInt] as [String : Any]
        
        let brandHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
        ]
        
        brand.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+BRAND_FILTTER_URL, type: .post, userData: brandParams, apiHeader: brandHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.brandFiltterModel = FiltterBrandModel(object:dict)
            
            if boolSuccess {
                
                if self.isNextPageAPICall {
                    
                    if let sellerInspiredVal = brandFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.brandArrayItems = self.brandArrayItems!.count > 0 ? self.brandArrayItems! + sellerInspiredVal : sellerInspiredVal
                            for (i,ele) in (brandArrayItems)!.enumerated(){
                                brandCheckInt.append(0)
                                
                            }
                            isNextPageAPICall = false
                            
                        }
                        self.hideActivityIndicator(self.view)
                    }
                }
                else{
                    if let sellerInspiredVal = brandFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.brandArrayItems = sellerInspiredVal
                            for (i,ele) in (brandArrayItems)!.enumerated(){
                                brandCheckInt.append(0)
                            }
                        }
                        self.hideActivityIndicator(self.view)

                    }
                }
                
                
                
                categoriesTableVIew.reloadData()
                optionListTableView.reloadData()
                hideActivityIndicator(self.view)
                optionListTableView.bottomRefreshControl?.endRefreshing()
            }else{
                optionListTableView.bottomRefreshControl?.endRefreshing()
                hideActivityIndicator(self.view)
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.hideActivityIndicator(self.view)

        })
        
        
    }
    func sellerFilter(){
        self.showActivityIndicator(self.view)

        let seller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "seller")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let sellerParams = ["c_mobile_no": UserDefaults.standard.value(forKey:usernameConstantStr) ?? "","c_state_code": UserDefaults.standard.value(forKey:DefaultstateCodeStr) ?? "",
                            "n_limit": 20,
                            "n_page": nextPageInt] as [String : Any]
        
        let sellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                         "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                         "Content-Type":"application/json",
        ]
        
        seller.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SELLER_FILTTER_URL, type: .post, userData: sellerParams, apiHeader: sellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.sellerFiltterModel = FiltterSellerModel(object:dict)
            
            if boolSuccess {
                
                if self.isNextPageAPICall {
                    
                    if let sellerInspiredVal = sellerFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.sellerArrayItems = self.sellerArrayItems!.count > 0 ? self.sellerArrayItems! + sellerInspiredVal : sellerInspiredVal
                            for (i,ele) in (sellerArrayItems)!.enumerated(){
                                sellerCheckInt.append(0)
                            }
                            isNextPageAPICall = false
                            
                        }
                    }
                    self.hideActivityIndicator(self.view)

                }
                else{
                    if let sellerInspiredVal = sellerFiltterModel?.payloadJson?.data?.jList{
                        if sellerInspiredVal.count != 0{
                            self.sellerArrayItems = sellerInspiredVal
                            for (i,ele) in (sellerArrayItems)!.enumerated(){
                                sellerCheckInt.append(0)
                            }
                        }
                    }
                    self.hideActivityIndicator(self.view)

                }
                
                categoriesTableVIew.reloadData()
                optionListTableView.reloadData()
                hideActivityIndicator(self.view)
                optionListTableView.bottomRefreshControl?.endRefreshing()
            }else{
                optionListTableView.bottomRefreshControl?.endRefreshing()
                hideActivityIndicator(self.view)
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.hideActivityIndicator(self.view)

        })
        
        
    }
    
    func searchList(txt:String){
        self.showActivityIndicator(self.view)

        nextPageInt = 0
        let searchList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "searchList")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let searchListParams = ["c_search_term": txt,"c_state_code": UserDefaults.standard.value(forKey:DefaultstateCodeStr) ?? "",
                                "n_limit": 20,
                                "n_page": nextPageInt] as [String : Any]
        
        let searchListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                             "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                             "Content-Type":"application/json",
        ]
        if filIndx == 0{
            searchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+MANUFACTURE_FILTTER_URL, type: .post, userData: searchListParams, apiHeader: searchListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(dict)
                self.mfcFiltterModel = FiltterMfcModel(object:dict)
                
                if boolSuccess {
                    self.hideActivityIndicator(self.view)

                    if mfcFiltterModel?.appStatusCode == 0{
                        if let sellerInspiredVal = mfcFiltterModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                self.mfcArrayItems = sellerInspiredVal
                                for (i,ele) in (mfcArrayItems)!.enumerated(){
                                    mfcCheckInt.append(0)
                                }
                            }
                        }
                        categoriesTableVIew.reloadData()
                        optionListTableView.reloadData()
                        hideActivityIndicator(self.view)
                        optionListTableView.bottomRefreshControl?.endRefreshing()
                    }else{
                        self.hideActivityIndicator(self.view)

                    }
                    
                    
                }else{
                    self.hideActivityIndicator(self.view)

                    optionListTableView.bottomRefreshControl?.endRefreshing()
                    hideActivityIndicator(self.view)
                }
                
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                self.hideActivityIndicator(self.view)

            })
            
        }else if filIndx == 1{
            self.showActivityIndicator(self.view)

            searchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+BRAND_FILTTER_URL, type: .post, userData: searchListParams, apiHeader: searchListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(dict)
                self.brandFiltterModel = FiltterBrandModel(object:dict)
                
                if boolSuccess {
                    
                    if brandFiltterModel?.appStatusCode == 0{
                        if let sellerInspiredVal = brandFiltterModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                self.brandArrayItems = sellerInspiredVal
                                for (i,ele) in (brandArrayItems)!.enumerated(){
                                    brandCheckInt.append(0)
                                }
                            }
                        }
                        categoriesTableVIew.reloadData()
                        optionListTableView.reloadData()
                        hideActivityIndicator(self.view)
                        optionListTableView.bottomRefreshControl?.endRefreshing()
                    }else{
                        hideActivityIndicator(self.view)

                    }
                    
                    
                    
                    
                }else{
                    optionListTableView.bottomRefreshControl?.endRefreshing()
                    hideActivityIndicator(self.view)
                }
                
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                self.hideActivityIndicator(self.view)

            })
        }else{
            self.showActivityIndicator(self.view)
            let sellerParams = ["c_search_term": txt,"c_mobile_no": UserDefaults.standard.value(forKey:usernameConstantStr) ?? "","c_state_code": UserDefaults.standard.value(forKey:DefaultstateCodeStr) ?? "",
                                "n_limit": 20,
                                "n_page": nextPageInt] as [String : Any]
            searchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SELLER_FILTTER_URL, type: .post, userData: sellerParams, apiHeader: searchListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(dict)
                self.sellerFiltterModel = FiltterSellerModel(object:dict)

                if boolSuccess {
                    
                    if sellerFiltterModel?.appStatusCode == 0{
                        categoriesTableVIew.reloadData()
                        optionListTableView.reloadData()
                        hideActivityIndicator(self.view)
                        optionListTableView.bottomRefreshControl?.endRefreshing()
                        self.hideActivityIndicator(self.view)

                    }else{
                        categoriesTableVIew.reloadData()
                        optionListTableView.reloadData()
                        hideActivityIndicator(self.view)
                        optionListTableView.bottomRefreshControl?.endRefreshing()
                        self.hideActivityIndicator(self.view)

                    }
                    
                    
                    
                    
                    optionListTableView.bottomRefreshControl?.endRefreshing()
                    hideActivityIndicator(self.view)
                }
                
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                self.hideActivityIndicator(self.view)

            })
            
        }
     
    }
}



