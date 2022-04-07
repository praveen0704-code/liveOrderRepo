//
//  LcMainSearchVC.swift
//  liveOrder
//
//  Created by Data Prime on 12/07/21.
//

import UIKit
import Alamofire
import LazyImage
import CoreData
import NotificationBannerSwift
import CCBottomRefreshControl

class LcMainSearchVC: UIViewController,passIndexDelegate, searchDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var mikeBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var topNaviSearchView: NaviSearchView!
    @IBOutlet weak var searchReseltOverAllView: UIView!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var recentSearchLbl: UILabel!
    @IBOutlet weak var clearAllBtn: UIButton!
    
    @IBOutlet weak var fillterBtn: UIButton!
    
    @IBOutlet weak var multiSearchContainerView: UIView!
    @IBOutlet weak var lcTopConstraint: NSLayoutConstraint!
    
    var nextPageInt = Int()
    var selectedIndexInt = Int()
    var shotBookIntArray = [Int]()
    var sbItemCodeModel:SBItemCodeModel?
    var shotBookSelectedInndexInt = Int()
    var searchVc :SearchWithListFeatureProductVC?
    var osSellerModel:OrderSellerList?


    
    @IBOutlet weak var topTaleViewConstraint: NSLayoutConstraint!
    
    let searchViewpopup = UINib(nibName: "SearchPopView", bundle:
                                    nil).instantiate(withOwner: nil, options: nil)[0] as? SearchPopView

    let myVC = UINib(nibName: "LcMainSearchFilterView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? LcMainSearchFilterView
    let addToCartView = UINib(nibName: "AddToCartView", bundle:
                                nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    var searchProductDDModel:SearchProductModel?
    var searchSellerDDModel:SearchDDSellerModel?
    var searchMFGModel : SearchByMFGModel?
    var searchMolModel : SearchMoleculeModel?
    var topmostModel : TopMostOrderModel?

    lazy var searchProductImg:LazyImage = LazyImage()
    var searchURLStr = String()
    var searchTextStr = String()
    var filtterIndex = 0
    var erroMge = false
    var addtoSBModel: AddToSBModel?
    var removetoSBModel : RemoveFromSBModel?
    var isNextPageAPICall : Bool = false
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var addItemModel : AddItemModel?
    
    var arraySearchProductJlist:[SearchProductModelJList]?
    var arraySearchMGFJlist:[SearchByMFGJList]?
    var arraySellerJlist:[SellerDDDataJList]?
    var arrayMoleLIst:[searchMoleculeJList]?
    var selectQty = [String]()

    var backPrevious = false
    var text : String?
    var indexfil : Int?
    
    var afterFiltter = 0
    
    
    
    //filtterIndex = 4 for search cell to display
    override func viewDidLoad() {
        super.viewDidLoad()
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.triggerVerticalOffset = 50
       
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        resultTableView.bottomRefreshControl = bottomRefreshController
        // Do any additional setup after loading the view.
        fillterBtn.isHidden = true
        setup()
        
        if backPrevious == true{
            fillterBtn.isHidden = false
            searchTxtField.text = text
            searchTextStr = searchTxtField.text ?? ""
            filtterIndex = indexfil ?? 0
            nextPageInt = 0
            searchProductDropDownApi(searchText: text ?? "", productInt: filtterIndex )
        }
    }
    func setup(){
        
        self.sbItemCode()
        self.recentSearch()
        // self.searchProductDropDownApi(searchText: self.sear)
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        searchTxtField.delegate = self
        fillterBtn.layer.cornerRadius = fillterBtn.frame.height/2
        
        resultTableView.register(UINib(nibName: lcOuterSearchTableViewCell, bundle: nil), forCellReuseIdentifier: lcOuterSearchTableViewCell)
        resultTableView.register(UINib(nibName: "SellerSearchTableCell", bundle: nil), forCellReuseIdentifier: "SellerSearchTableCell")
        resultTableView.register(UINib(nibName: "MfgSearchTableCell", bundle: nil), forCellReuseIdentifier: "MfgSearchTableCell")
        resultTableView.register(UINib(nibName: "MainSearchFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "MainSearchFilterTableViewCell")
        
        self.resultTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        topTaleViewConstraint.constant = 50.0
        self.resultTableView.layoutIfNeeded()
        scanBtn.isHidden = true
        mikeBtn.isHidden = true
        
       // coreDataFetch()
        
        print(recentSearchMod.count)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(hideTableView(sender:))) //do that animation to hide the UITableView
        swipeGesture.direction = .down //Swiping down may come into conflict w/ the UITableView itself if it is scrollable, check it out.
        self.view.addGestureRecognizer(swipeGesture)
        
        
        
    }
    @objc func refreshBottom(){
        
    }
    //MARK: - Button Action
    
    @IBAction func cancelBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func mikeBtnAct(_ sender: Any) {
        
    }
    @IBAction func scanBtnAct(_ sender: Any) {
        searchTxtField.text = ""
        searchTextStr = ""
        nextPageInt = 0
        self.searchProductDropDownApi(searchText: searchTextStr , productInt: filtterIndex)
        
    }
    @IBAction func menuBtnAct(_ sender: Any) {
        searchViewpopup?.delegate = self
        searchViewpopup!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        searchViewpopup?.searchBtn.addTarget(self, action:#selector(mSearcAction(sender:)), for: .touchUpInside)
        searchViewpopup?.resetBtn.addTarget(self, action:#selector(resetAct(sender:)), for: .touchUpInside)
        
        //Add the view
        self.view.addSubview(searchViewpopup!)
    }
    
    func onPizzaReady(type: String) {
        print(type)
        let searchVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC") as? SearchWithListFeatureProductVC
        searchVc!.searchTextStr = type
        searchVc!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(searchVc!, animated: true, completion: nil)
    }
    


    @IBAction func fillterBtnAct(_ sender: Any) {
        searchTxtField.resignFirstResponder()
        self.view.addSubview(myVC!)
        myVC?.passValDelegate = self
        
        
    }
    @IBAction func clearAllBtnAct(_ sender: Any) {
        
//        deleteAllRecords()
//        if deleteAllItems(entity:searchListEntityNameConStr) == true{
//            filtterIndex = 0
//            self.resultTableView.reloadData()
//            topTaleViewConstraint.constant = 0.0
//            self.resultTableView.layoutIfNeeded()
//            coreDataFetch()
////            recentSearchMod.removeAll()
//
//        }else{
//            filtterIndex = 4
//            self.resultTableView.reloadData()
//            topTaleViewConstraint.constant = 37.0
//            self.resultTableView.layoutIfNeeded()
//
//
//
//        }

        
    }
    
//    func deleteAllRecords() {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: searchListEntityNameConStr)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//            coreDataFetch()
//        } catch {
//            print ("There was an error")
//        }
//    }
    @IBOutlet weak var recentSearchAction: UILabel!
    //MARK: - Pass Delegate
    func selectedIndex(indexInt: Int) {
        nextPageInt = 0
        print(indexInt)
        filtterIndex = indexInt
        isNextPageAPICall = false
        self.searchProductDropDownApi(searchText: searchTextStr , productInt: filtterIndex)
        
        resultTableView.reloadData()
        print(nextPageInt)
        
    }
    
    
}
extension LcMainSearchVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        
        scanBtn.isHidden = false

    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        
        if textField.text?.count == 0 {
            recentSearchLbl.isHidden = false
            clearAllBtn.isHidden = false
            
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let userEnteredString = textField.text
                let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        
                if  newString != "" {

                        if (searchTxtField.text! + string).count >= 4 {
//                            if range.length == 4 {
//                                       //Delete single letter
//
//
//                                self.searchTextStr = searchTxtField.text!
//                                self.searchTextStr.removeLast()
//                                print(searchTextStr)
//                                self.searchProductDropDownApi(searchText: searchTextStr , productInt: filtterIndex)
//                            }else{
                                print(searchTxtField.text! + string)
                                recentSearchLbl.isHidden = true
                                clearAllBtn.isHidden = true
                                nextPageInt = 0
                                self.searchTextStr = searchTxtField.text! + string
                                self.searchProductDropDownApi(searchText: searchTextStr , productInt: filtterIndex)
                            
                           }else{
                            erroMge = false
                            arraySearchProductJlist?.removeAll()
                            arraySearchMGFJlist?.removeAll()
                            arraySellerJlist?.removeAll()
                            self.searchTextStr = textField.text ?? ""
                            self.resultTableView.reloadData()
                           // self.searchProductDropDownApi(searchText: textField.text ?? "", productInt: filtterIndex)
                
                        }
                        }else {
                    
                    erroMge = false
                    arraySearchProductJlist?.removeAll()
                    arraySearchMGFJlist?.removeAll()
                    arraySellerJlist?.removeAll()
                    self.searchTextStr = textField.text ?? ""
                    self.resultTableView.reloadData()
                    //self.searchProductDropDownApi(searchText: textField.text ?? "", productInt: filtterIndex)

                }
                return true
        

}

    
}
extension LcMainSearchVC : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if erroMge == true
        {
            tableView.separatorStyle = .none
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true

        }
        else
        {
            if filtterIndex == 4{
                tableView.separatorStyle = .none
                numOfSections = 1
               tableView.backgroundView = nil
                tableView.isScrollEnabled = true

            }else{
                if afterFiltter == 1 {
                    let noRecordsErrorView = NoRecordsErrorView.fromNib()
                    noRecordsErrorView.tag = 201
                    noRecordsErrorView.noHistoryLbl.text = "You have no items"
                    tableView.backgroundView = noRecordsErrorView
                    tableView.isScrollEnabled = false
                    tableView.separatorStyle  = .none
                }else{
                    let noRecordsErrorView = NoRecordsErrorView.fromNib()
                    noRecordsErrorView.tag = 201
                    tableView.backgroundView = noRecordsErrorView
                    tableView.isScrollEnabled = false
                    tableView.separatorStyle  = .none
                }
               
            }
            
            
        }
        
        return numOfSections
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filtterIndex == 1 {
            return self.arraySellerJlist?.count ?? 0
        }else if filtterIndex == 2 {
            return self.arraySearchMGFJlist?.count ?? 0
        }else if filtterIndex == 3{
            return arrayMoleLIst?.count ?? 0
        }else if filtterIndex == 4{
            return recentSearchMod.count
        }else{
            
            return arraySearchProductJlist?.count ?? 0
        }
        
        
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if filtterIndex == 1{
            
            let locCell = tableView.dequeueReusableCell(withIdentifier: "SellerSearchTableCell", for: indexPath) as! SellerSearchTableCell
            
            locCell.sellerNmaeLbl.text = arraySellerJlist?[indexPath.row].cSellerName
            locCell.citylbl.text = arraySellerJlist?[indexPath.row].cSellerCity
            locCell.schemeLbl.isHidden = true
            
            
            return locCell
            
            
        }else if filtterIndex == 2{
            
            
            let locCell = tableView.dequeueReusableCell(withIdentifier: "MfgSearchTableCell", for: indexPath) as! MfgSearchTableCell
            locCell.mfgLbl.text = arraySearchMGFJlist?[indexPath.row].cManufactureName
            locCell.schemesLbl.isHidden = true
            
            
            
            return locCell
            
        }else if filtterIndex == 3{
            
            let locCell = tableView.dequeueReusableCell(withIdentifier: "MfgSearchTableCell", for: indexPath) as! MfgSearchTableCell
            locCell.schemesLbl.isHidden = true
            locCell.mfgLbl.text = arrayMoleLIst?[indexPath.row].cMoleculeName
            return locCell
            
        } else if filtterIndex == 4{
            let recentSearchCell = tableView.dequeueReusableCell(withIdentifier: "MainSearchFilterTableViewCell", for: indexPath) as! MainSearchFilterTableViewCell
            recentSearchCell.selectButton.isHidden = true
            recentSearchCell.titleLabel.text = recentSearchMod[indexPath.row].recentSearchStr
            
            return recentSearchCell
            
            
        } else {
            
            if arraySearchProductJlist?[indexPath.row].cVariantCount == "Y"{
                let varientCell = tableView.dequeueReusableCell(withIdentifier: "SearchVariantsTableCell", for: indexPath) as! SearchVariantsTableCell
                
                //Load Data Here
                varientCell.productLbl.text = arraySearchProductJlist?[indexPath.row].cItemName
                varientCell.microLbl.text = arraySearchProductJlist?[indexPath.row].cItemMfgName
                varientCell.variantsLbl.text = "\(arraySearchProductJlist?[indexPath.row].cVariantCount ?? "") Variants"
                return varientCell
                
                
            }else{
                
                let locCell = tableView.dequeueReusableCell(withIdentifier: lcOuterSearchTableViewCell, for: indexPath) as! LcOuterSearchTableCell
                locCell.overAllView.layer.cornerRadius = 5
                locCell.tabletName.text = arraySearchProductJlist?[indexPath.row].cItemName
                locCell.tabletName.numberOfLines = 0
                locCell.microLabsLbl.text = arraySearchProductJlist?[indexPath.row].cItemMfgName
                locCell.packsizeLbl.text = "Pack Size: \(arraySearchProductJlist?[indexPath.row].cPackName ?? "")"
                if arraySearchProductJlist?[indexPath.row].nMaxMrp == 0{
                    locCell.mrpLbl.text = "₹ \(arraySearchProductJlist?[indexPath.row].nMaxMrp ?? 0).00"
                    print(arraySearchProductJlist?[indexPath.row].nMaxMrp ?? "")
                    
                }else{
                    
                    locCell.mrpLbl.text = "₹ \(arraySearchProductJlist?[indexPath.row].nMaxMrp ?? 0).00"
                    print(arraySearchProductJlist?[indexPath.row].nMaxMrp ?? 0)
                }
                locCell.addButtonn.titleLabel?.font = UIFont(name:"Quicksand-Medium", size: 12)
                if self.shotBookIntArray[indexPath.row] == 1{
                    locCell.shotBookImgeView.image = UIImage(named: "shortbook-2")
                    print("yes")
                    
                }else{
                    locCell.shotBookImgeView.image = UIImage(named: "shortbook")
                    print("no")
                    
                }
                locCell.shortBookBtn.tag = indexPath.row
                locCell.shortBookBtn.addTarget(self, action: #selector(shortBkBtnAct), for: .touchUpInside)
                locCell.addButtonn.tag = indexPath.row
                locCell.addButtonn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
                locCell.addButtonn.titleLabel?.textColor = .white
                if arraySearchProductJlist?[indexPath.row].cSponsored == "Y"{
                    
                    locCell.sponserLabelHeightConstraint.constant = 16.0
                    locCell.sponserLabel.layoutIfNeeded()
                    
                }else{
                    
                    locCell.sponserLabelHeightConstraint.constant = 0.0
                    locCell.sponserLabel.layoutIfNeeded()
                    
                }
                
                
                locCell.shortBookBtn.setTitle("", for: .normal)
                
                return locCell
                
            }
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if filtterIndex == 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AfterScanFmgcProductVC") as? AfterScanFmgcProductVC
            vc?.productIDStr = arraySearchProductJlist?[indexPath.row].cItemCode ?? ""
            vc?.back = 2
            vc?.filterNum = filtterIndex
            vc?.text = searchTxtField.text
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if filtterIndex == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
            vc?.sellerName = arraySellerJlist?[indexPath.row].cSellerName
            vc?.mfcCode = arraySellerJlist?[indexPath.row].cSellerCode
            vc?.filterNum = filtterIndex
            vc?.text = searchTxtField.text
            vc?.viewAllInt = 1
            vc?.back = 1
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if filtterIndex == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
            vc?.sellerName = arraySearchMGFJlist?[indexPath.row].cManufactureName
            vc?.mfcCode = arraySearchMGFJlist?[indexPath.row].cManufactureCode
            vc?.filterNum = filtterIndex
            vc?.text = searchTxtField.text
            vc?.viewAllInt = 4
            vc?.back = 1
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if filtterIndex == 3{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
            vc?.sellerName = arrayMoleLIst?[indexPath.row].cMoleculeName
            vc?.mfcCode = arrayMoleLIst?[indexPath.row].cMoleculeCode
            vc?.filterNum = filtterIndex
            vc?.text = searchTxtField.text
            vc?.viewAllInt = 6
            vc?.back = 1
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.searchTxtField.text = recentSearchMod[indexPath.row].recentSearchStr
            self.searchTextStr = self.searchTxtField.text ?? ""
            filtterIndex = 0
            self.recentSearchLbl.isHidden = true
            self.clearAllBtn.isHidden = true
            topTaleViewConstraint.constant = 0.0
            self.resultTableView.layoutIfNeeded()
            
            self.searchProductDropDownApi(searchText: self.searchTxtField.text ?? "", productInt: filtterIndex)
            
            //  self.resultTableView.reloadData()
        }
        
       
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // UITableView only moves in one direction, y axis
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            if searchProductDDModel?.messages?[0] == "RECORD_NOT_FOUND"{
                if filtterIndex == 4{
                    print("Do not Scroll")
                }else{
                    nextPageInt = nextPageInt - 1
                    searchProductDropDownApi(searchText:searchTextStr, productInt:filtterIndex)
                    isNextPageAPICall = true
                    print("end down")
                    print(nextPageInt)
                }
                
            }else{
                if filtterIndex == 4{
                    print("Do not Scroll")
                }else{
                    
                    searchProductDropDownApi(searchText:searchTextStr, productInt:filtterIndex)
                    isNextPageAPICall = true

                    print("down")
                    print(nextPageInt)
                }
            }
            
            
            
        }
        
    }
    //MARK: - Cell Button Actions
    @objc func addToCartAction(sender:UIButton){
        if  filtterIndex == 1 {
            productWiseSellerDetails(wishItemCodeStr:self.arraySellerJlist?[sender.tag].cSellerCode ?? "", itemName: self.arraySellerJlist?[sender.tag].cSellerName ?? "")
        }else if filtterIndex == 2{
            productWiseSellerDetails(wishItemCodeStr:self.arraySearchMGFJlist?[sender.tag].cManufactureCode ?? "", itemName: self.arraySearchMGFJlist?[sender.tag].cManufactureName ?? "")
        }else{
            productWiseSellerDetails(wishItemCodeStr:self.arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemName: self.arraySearchProductJlist?[sender.tag].cItemName ?? "")
        }
    }
    //FIXME: - Shot Button Action
    @objc func shortBkBtnAct(sender:UIButton){
        shotBookSelectedInndexInt = sender.tag
        if shotBookIntArray[sender.tag] == 1{
            

            removeShotbook(itemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")
            
        }else{

            addToShotook(itemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")
            
            
        }
        
    }
    
}
extension LcMainSearchVC:addcartDelegate{
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
    }
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    
}
extension LcMainSearchVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension LcMainSearchVC:WebServiceDelegate {
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    
    func searchProductDropDownApi(searchText:String,productInt:Int){
        print(nextPageInt)
        showActivityIndicator(self.view)
        let searchProductDropDown:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "SearchProductDropDown")
        let searchProductDDParms = ["n_page":nextPageInt,
                                    "n_limit":15,
                                    "c_search_term":"\(searchText)"] as [String : Any]
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"nzFXijLYZzDo7ycoym2ZHw==",
        //                                    "X-csquare-api-token":"12435837258495ab",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        print(sHeader)
        if productInt == 1 {
            searchURLStr = LIVE_ORDER_HOSTURL+SEARCH_PRODUCT_DROPDOWN_SELLER
            searchProductDropDown.callServiceAndGetData(url: searchURLStr, type: .post, userData: searchProductDDParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(dict)
                self.searchSellerDDModel = SearchDDSellerModel(object:dict)
                
                if boolSuccess {

                   // contaisText(searchTextStr: self.searchTextStr)
                    
                    if self.searchSellerDDModel?.appStatusCode == 0{
                        hideActivityIndicator(self.view)

                        print(nextPageInt)
                            if self.isNextPageAPICall {
                                nextPageInt = searchSellerDDModel?.payloadJson?.data?.nNextPage ?? 0
                                hideActivityIndicator(self.view)

                                if let searchSellerVal = searchSellerDDModel?.payloadJson?.data?.jList{
                                    
                                    if searchSellerVal.count != 0{
                                        self.arraySellerJlist = self.arraySellerJlist!.count > 0 ? self.arraySellerJlist! + searchSellerVal : searchSellerVal
                                        
                                        resultTableView.bottomRefreshControl?.endRefreshing()
                                    }
                                    
//                                    for (inx,ele) in (searchSellerDDModel?.payloadJson?.data?.jList)!.enumerated(){
//                                        self.shotBookIntArray.append(0)
//
//                                        for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
//                                            if ele.cItemCode == sele.cItemCode{
//                                                shotBookIntArray[inx] = 1
//                                            }else{
//                                              //  shotBookIntArray[inx] = 0
//                                            }
//                                        }
//                                    }
                                }
                                
                                hideActivityIndicator(self.view)

                                topTaleViewConstraint.constant = 0.0

                                resultTableView.bottomRefreshControl?.endRefreshing()
                            }
                     

                      else{
                                
                                if let searchSellerVal = searchSellerDDModel?.payloadJson?.data?.jList{
                                    if searchSellerVal.count != 0{
                                        self.arraySellerJlist = searchSellerVal
                                        self.resultTableView.reloadData()
                                      resultTableView.bottomRefreshControl?.endRefreshing()
                                    }else{
                                        erroMge = false
                                        afterFiltter = 1
                                        self.selectedIndexInt = productInt
                                        topTaleViewConstraint.constant = 0.0
                                        self.resultTableView.layoutIfNeeded()
                                        self.resultTableView.reloadData()
                                    }
                                }
                            }
                        hideActivityIndicator(self.view)

//                        erroMge = true
//                        self.selectedIndexInt = productInt
//                        topTaleViewConstraint.constant = 0.0
                        self.resultTableView.layoutIfNeeded()
                        self.resultTableView.reloadData()
                    }else{
                        hideActivityIndicator(self.view)

                        resultTableView.bottomRefreshControl?.endRefreshing()
                        erroMge = false
                        arraySellerJlist?.removeAll()
                        topTaleViewConstraint.constant = 50.0
                        self.resultTableView.layoutIfNeeded()
                        self.resultTableView.reloadData()
                }
                    resultTableView.bottomRefreshControl?.endRefreshing()
                    
                }else{
                    hideActivityIndicator(self.view)

                    arraySellerJlist?.removeAll()
                    self.resultTableView.reloadData()
                    resultTableView.bottomRefreshControl?.endRefreshing()
                    
            
                }
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                hideActivityIndicator(self.view)

                arraySellerJlist?.removeAll()

               self.resultTableView.reloadData()
                resultTableView.bottomRefreshControl?.endRefreshing()
                

            })
            
        }else if productInt == 2 {
            showActivityIndicator(self.view)
            searchURLStr = LIVE_ORDER_HOSTURL+SEARCH_PRODUCT_DROPDOWN_MFG
            searchProductDropDown.callServiceAndGetData(url: searchURLStr, type: .post, userData: searchProductDDParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                  print(dict)
                self.searchMFGModel = SearchByMFGModel(object:dict)
                if boolSuccess {
                   // contaisText(searchTextStr: self.searchTextStr)
                    if self.searchMFGModel?.appStatusCode == 0{
                        hideActivityIndicator(self.view)

                        nextPageInt = searchMFGModel?.payloadJson?.data?.nNextPage ?? 0
                        if self.isNextPageAPICall {
                            if let searchMFGVal = searchMFGModel?.payloadJson?.data?.jList{
                                if searchMFGVal.count != 0{
                                    self.arraySearchMGFJlist = self.arraySearchMGFJlist!.count > 0 ? self.arraySearchMGFJlist! + searchMFGVal : searchMFGVal
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                            topTaleViewConstraint.constant = 0.0

                            resultTableView.bottomRefreshControl?.endRefreshing()
                        }
                        else{
                            if let searchMGFval = searchMFGModel?.payloadJson?.data?.jList{
                                if searchMGFval.count != 0{
                                    self.arraySearchMGFJlist = searchMGFval
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }else{
                                    erroMge = false
                                    afterFiltter = 1
                                    self.selectedIndexInt = productInt
                                    topTaleViewConstraint.constant = 0.0
                                    self.resultTableView.layoutIfNeeded()
                                    
                                    self.resultTableView.reloadData()
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                        }
//                        erroMge = true
//                        self.selectedIndexInt = productInt
//                        topTaleViewConstraint.constant = 0.0
                        self.resultTableView.layoutIfNeeded()

                        self.resultTableView.reloadData()
                        resultTableView.bottomRefreshControl?.endRefreshing()
                    }else{
                        hideActivityIndicator(self.view)

//                        erroMge = false
//                        arraySearchMGFJlist?.removeAll()
//                        topTaleViewConstraint.constant = 40.0
                        self.resultTableView.layoutIfNeeded()
                        self.resultTableView.reloadData()
                        resultTableView.bottomRefreshControl?.endRefreshing()
                    }
                    
                    
                }else{
                    hideActivityIndicator(self.view)

                    arraySearchMGFJlist?.removeAll()
                    self.resultTableView.reloadData()
                    resultTableView.bottomRefreshControl?.endRefreshing()

                }
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                hideActivityIndicator(self.view)

                arraySearchMGFJlist?.removeAll()
                self.resultTableView.reloadData()
                resultTableView.bottomRefreshControl?.endRefreshing()

                
            })
            
        }else if productInt == 3{
            showActivityIndicator(self.view)
            searchURLStr = LIVE_ORDER_HOSTURL+SEARCH_PRODUCT_DROPDOWN_MOLECULE
            searchProductDropDown.callServiceAndGetData(url: searchURLStr, type: .post, userData: searchProductDDParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                  print(dict)
                self.searchMolModel = SearchMoleculeModel(object:dict)
                if boolSuccess {
                    //contaisText(searchTextStr: self.searchTextStr)
                    if self.searchMolModel?.appStatusCode == 0{
                        hideActivityIndicator(self.view)

                        nextPageInt = searchMolModel?.payloadJson?.data?.nNextPage ?? 0
                        if self.isNextPageAPICall {
                            if let searchMolVal = searchMolModel?.payloadJson?.data?.jList{
                                if searchMolVal.count != 0{
                                    self.arrayMoleLIst = self.arrayMoleLIst!.count > 0 ? self.arrayMoleLIst! + searchMolVal : searchMolVal
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                            resultTableView.bottomRefreshControl?.endRefreshing()
                        }
                        else{
                            if let searchMolVal = searchMolModel?.payloadJson?.data?.jList{
                                if searchMolVal.count != 0{
                                    self.arrayMoleLIst = searchMolVal
                                    self.resultTableView.reloadData()
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                    self.resultTableView.reloadData()

                                }else{
                                    erroMge = false
                                    afterFiltter = 1
                                    self.selectedIndexInt = productInt
                                    topTaleViewConstraint.constant = 0.0
                                    self.resultTableView.layoutIfNeeded()
                                    
                                    self.resultTableView.reloadData()
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                        }
//
                    }else{
                        hideActivityIndicator(self.view)

//                        erroMge = false
//                        arraySearchMGFJlist?.removeAll()
//                        topTaleViewConstraint.constant = 40.0
                       self.resultTableView.layoutIfNeeded()
                        self.resultTableView.reloadData()
                        resultTableView.bottomRefreshControl?.endRefreshing()
                    }
                    
                    
                }else{
                    hideActivityIndicator(self.view)

                    arraySearchMGFJlist?.removeAll()
                    self.resultTableView.reloadData()
                    resultTableView.bottomRefreshControl?.endRefreshing()

                }
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                hideActivityIndicator(self.view)

                arraySearchMGFJlist?.removeAll()
                self.resultTableView.reloadData()
                resultTableView.bottomRefreshControl?.endRefreshing()

                
            })
            
        } else {
            showActivityIndicator(self.view)
            searchURLStr = LIVE_ORDER_HOSTURL+SEARCH_PRODUCT_DROPDOWN_URL
            searchProductDropDown.callServiceAndGetData(url: searchURLStr, type: .post, userData: searchProductDDParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(dict)
                self.searchProductDDModel = SearchProductModel(object:dict)
                if boolSuccess {
                    //contaisText(searchTextStr: self.searchTextStr)
                    
                    if self.searchProductDDModel?.appStatusCode == 0{
                        hideActivityIndicator(self.view)

                        print(nextPageInt)
                        if self.isNextPageAPICall {
                            nextPageInt = searchProductDDModel?.payloadJson?.data?.nNextPage ?? 0
                            if let productSearchVal = searchProductDDModel?.payloadJson?.data?.jList{
                                if productSearchVal.count != 0{
                                    self.arraySearchProductJlist = self.arraySearchProductJlist!.count > 0 ? self.arraySearchProductJlist! + productSearchVal : productSearchVal
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                         
                            resultTableView.bottomRefreshControl?.endRefreshing()
                            
                       
                        }
                        else{
                            if let productSearchval = searchProductDDModel?.payloadJson?.data?.jList{
                                if productSearchval.count != 0{
                                    self.arraySearchProductJlist = productSearchval
                                    resultTableView.bottomRefreshControl?.endRefreshing()
                                }
                            }
                        }
                        for (inx,ele) in (searchProductDDModel?.payloadJson?.data?.jList)!.enumerated(){
                                self.shotBookIntArray.append(0)
                            if self.sbItemCodeModel?.payloadJson?.data != nil{
                                for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
                                    if ele.cItemCode == sele.cItemCode{
                                       shotBookIntArray[inx] = 1
                                    }else{
                                      //  shotBookIntArray[inx] = 0
                                    }
                              }
                            }
                         
                    }
                        print(shotBookIntArray)

                        erroMge = true
                        topTaleViewConstraint.constant = 0.0
                        self.resultTableView.layoutIfNeeded()
                        self.selectedIndexInt = productInt
                        fillterBtn.isHidden = false
                        self.resultTableView.reloadData()
                        resultTableView.bottomRefreshControl?.endRefreshing()
                    }else{
                        hideActivityIndicator(self.view)
                        erroMge = true
                        topTaleViewConstraint.constant = 40.0
                        arraySearchProductJlist?.removeAll()
                        self.resultTableView.layoutIfNeeded()
                        self.resultTableView.reloadData()
                        resultTableView.bottomRefreshControl?.endRefreshing()
                    }
                    
                    
                }else{
                    hideActivityIndicator(self.view)
                    erroMge = true

                    arraySearchProductJlist?.removeAll()
                    self.resultTableView.reloadData()
                    resultTableView.bottomRefreshControl?.endRefreshing()

                    
                }
                
            }, failureBlock: {[unowned self] (errorMesssage) in
                hideActivityIndicator(self.view)
                erroMge = true

                arraySearchProductJlist?.removeAll()

                self.resultTableView.reloadData()
                resultTableView.bottomRefreshControl?.endRefreshing()

                
            })
        }
        
    }
    func addToShotook(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        
        let topmost:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToShortook")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let itemCodeParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        
        let shHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                     "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                     "Content-Type":"application/json",
        ]
        
        topmost.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_SHOTBOOK_URL, type: .post, userData: itemCodeParams, apiHeader: shHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addtoSBModel = AddToSBModel(object:dict)
            
            
            if boolSuccess {
                
                hideActivityIndicator(self.view)
                if self.addtoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 1
                    self.resultTableView.reloadRows(at: [sbIndexPath], with: .none)

                    self.sbItemCode()
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 1
                    self.resultTableView.reloadRows(at: [sbIndexPath], with: .none)
                    
                    self.sbItemCode()

                    
                    
                }
                
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
        
        
    }
    func removeShotbook(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let remove:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let removeParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        
        let removeHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                         "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                         "Content-Type":"application/json",
        ]
        
        remove.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REMOVE_FROM_SHORTBOOK_URL, type: .post, userData: removeParams, apiHeader: removeHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.removetoSBModel = RemoveFromSBModel(object:dict)
            
            if boolSuccess {
                hideActivityIndicator(self.view)
                
                if self.removetoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 0
                    self.resultTableView.reloadRows(at: [sbIndexPath], with: .none)
                    
                    self.sbItemCode()

                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 0
                    self.resultTableView.reloadRows(at: [sbIndexPath], with: .none)
                    self.sbItemCode()

                    
                    
                }
                
                
                
            }else{
                hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            
            
        })
   
    }
    func productWiseSellerDetails(wishItemCodeStr:String,itemName:String){
        showActivityIndicator(self.view)

        print(wishItemCodeStr)
        let productWiseSeller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "proSeller")
        let productWiseSellerParams = ["c_search_term": wishItemCodeStr,
                                       "n_limit": 10,
                                       "n_page": 0] as [String : Any]
        print(productWiseSellerParams)
        //let productWiseSellerParams = ["c_uitem_code":"498283"]
        //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        print(productWiseSellerHeader)
        
        productWiseSeller.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PRODUCT_WISE_SELLER_DETAILS_URL, type: .post, userData: productWiseSellerParams, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.productWiseSellerModel = ProductVsSellerDetailsModel(object:dict)
            
            if boolSuccess {
                hideActivityIndicator(self.view)
                
                
                if self.productWiseSellerModel?.appStatusCode == 0{
                    if productWiseSellerModel?.payloadJson?.data?.jList?.count == 0{
                        productWiseSellerModel?.payloadJson?.data?.jList?.removeAll()
                        unSellerList(searcTermStr: wishItemCodeStr,sitemName:itemName)

                    }else{
                        
                        for (_,ele) in (productWiseSellerModel?.payloadJson?.data?.jList)!.enumerated() {
                            self.selectQty.append("1")
                            
                            
                        }
                        hideActivityIndicator(self.view)
                        print(self.selectQty)
                        addToCartView?.delegate = self
                        addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                        addToCartView?.productName = itemName
                        addToCartView?.productwiseSellerModel = productWiseSellerModel
                        addToCartView?.selectQtyS = selectQty
                        print(addToCartView?.bestSchemesTableView.contentSize.height)
                        
                        self.view.addSubview(addToCartView!)
                    }
           
                }else{
                    hideActivityIndicator(self.view)
                }
                
                
                
            }else{
                hideActivityIndicator(self.view)
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
    func addToCart(item_codeStr:String,mobile_noStr:String,seller_codeStr:String,seller_item_codeStr:String,seller_nameStr:String,n_mrpStr:Float,n_qtyStr:String,n_seller_rateStr:Float){
        let addToCart:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToCart")
        let addToCartParms = ["c_item_code":item_codeStr,
                              "c_mobile_no":mobile_noStr ?? "",
                                       "c_seller_code":seller_codeStr,
                                        "c_seller_item_code":seller_item_codeStr,
                                       "c_seller_name":seller_nameStr,
                              "n_mrp":n_mrpStr,
                              "n_qty":n_qtyStr,
                              "n_seller_rate":n_seller_rateStr
        ] as [String : Any]
        
        print(addToCartParms)
        
//        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"TihpuDEJ0nq2LuqL1e0CuA==",
//                                    "X-csquare-api-token":"-20736993905466b",
//                                    "Content-Type":"application/json",
//                                        ]

                let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        addToCart.callServiceAndGetData(url:LIVE_ORDER_HOSTURL+ADD_TO_CART_URL, type: .post, userData: addToCartParms, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addItemModel = AddItemModel(object: dict)
            
            print(dict)
            if boolSuccess {
                if addItemModel?.appStatusCode == 0{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addItemModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addItemModel?.messages?[0] ?? "", view: self.view)
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addItemModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addItemModel?.messages?[0] ?? "", view: self.view)
                }
                
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
    //MARK: - shotBookCount
    func sbItemCode(){
       // apiQueue.enter()
           showActivityIndicator(self.view)

        
        let sbItemCode:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sbItemCode")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let proHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(proHeader)
        sbItemCode.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHORTBOOK_ITEM_CODE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.sbItemCodeModel = SBItemCodeModel(object:dict)
            
            if boolSuccess {
               
                if self.sbItemCodeModel?.appStatusCode == 0{

print("sucess")
//                    isSbItem = true
//
//                    tPCollectionView.reloadData()
//                    newLaunchCollectionView.reloadData()
                    
                    hideActivityIndicator(self.view)

                   
                }else{
                    hideActivityIndicator(self.view)

                }
                

            }else{
                hideActivityIndicator(self.view)


            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
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
            hideActivityIndicator(self.view)


        })
//        apiQueue.leave()
        
        }
    
    //MARK: - recentSearch
    func recentSearch(){
        showActivityIndicator(self.view)
print(LIVE_ORDER_HOSTURL+RESET_SEARCH_URL)
        
        let resetSearchHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(resetSearchHeader)
        
        let recentSearchHistory:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "recentSearchHistory")
        recentSearchHistory.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+RESET_SEARCH_URL, type: .get, userData: [:] , apiHeader: resetSearchHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            
            if boolSuccess {
          
            }
            else
            {
                hideActivityIndicator(self.view)
            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)

        })
    }
    func unSellerList(searcTermStr:String,sitemName:String){
        showActivityIndicator(self.view)
        
        let orderSellerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "OrderSellerList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let orderSellerParams = ["c_search_term":searcTermStr,
                                "n_page":0,
                                 "n_limit":20] as [String : Any]
        print(orderSellerParams)

            let orderSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(orderSellerHeader)

        orderSellerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ORDER_TO_SELLER_LIST_URL, type: .post, userData: orderSellerParams, apiHeader: orderSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.osSellerModel = OrderSellerList(object:dict)
            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.osSellerModel?.payloadJson?.data?.count == 0{
                    hideActivityIndicator(self.view)
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                        banner.showToast(message: "No Seller found", view: self.view)

                }else{
                    hideActivityIndicator(self.view)
                    addToCartView?.delegate = self
                    addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    addToCartView?.osSellerModel = osSellerModel

                    addToCartView?.selectQtyS = selectQty
                    addToCartView?.productName = sitemName
                    print(addToCartView?.bestSchemesTableView.contentSize.height)
                    self.view.addSubview(addToCartView!)
                    
                }

               
            }else{
                hideActivityIndicator(self.view)

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
//extension LcMainSearchVC{
//    //MARK:- Fetch
//    func coreDataFetch(){
//        recentSearchMod.removeAll()
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: searchListEntityNameConStr)
//        request.returnsObjectsAsFaults = false
//        let quoteContext = appDelegate.persistentContainer.viewContext
//        do {
//            let result = try quoteContext.fetch(request)
//            _ = JSONDecoder()
//
//            print(result)
//            for data in result as! [NSManagedObject] {
//
//                recentSearchMod.append(RecentSearchModel(recentSearch: data.value(forKey: "searchTextLO") as! String))
//
//            }
//
//            if recentSearchMod.count == 0{
//                        filtterIndex = 0
//                        topTaleViewConstraint.constant = 15.0
//                        self.resultTableView.layoutIfNeeded()
//                self.clearAllBtn.isHidden = true
//
//                    }else{
//
//                        filtterIndex = 4
//                        topTaleViewConstraint.constant = 57.0
//                        self.resultTableView.layoutIfNeeded()
//                        self.clearAllBtn.isHidden = false
//                        filtterIndex = 0
//
//
//                    }
//            self.resultTableView.reloadData()
//
//
//        } catch {
//
//            print("Failed")
//
//        }
//
//    }
//
//    func contaisText(searchTextStr:String){
//        print(recentSearchMod.count)
//        if recentSearchMod.contains(where: { $0.recentSearchStr == "\(searchTextStr)"}) {
//            print("found")
//
//
//
//        } else {
//            print("not")
//            saveDateToCore(searchTextStr:searchTextStr, entityName: searchListEntityNameConStr)
//        }
//    }
//
//
//}
extension LcMainSearchVC{
    @objc func mSearcAction(sender:UIButton){
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = searchViewpopup!.searchTbleView.cellForRow(at: indexPath) as! SearchTableViewCell
        cell.searchTxtField.resignFirstResponder()
       
       add_ViewController()
        self.searchViewpopup?.removeFromSuperview()
        searchViewpopup?.btn = 1

    }
    //MARK: - Button Action
    @objc func resetAct(sender:UIButton){
        let indexPath = IndexPath(row: 0, section: 0)
        let indexPathOne = IndexPath(row: 1, section: 0)
        let indexPathTwo = IndexPath(row: 2, section: 0)
        let indexPathThree = IndexPath(row: 3, section: 0)
        let indexPathFour = IndexPath(row: 4, section: 0)
        let cell = searchViewpopup!.searchTbleView.cellForRow(at: indexPath) as! SearchTableViewCell
        cell.searchTxtField.text = ""
        let cell1 = searchViewpopup!.searchTbleView.cellForRow(at: indexPathOne) as! SearchTableViewCell
        cell1.searchTxtField.text = ""
        let cell2 = searchViewpopup!.searchTbleView.cellForRow(at: indexPathTwo) as! SearchTableViewCell
        cell2.searchTxtField.text = ""
        let cell3 = searchViewpopup!.searchTbleView.cellForRow(at: indexPathThree) as! SearchTableViewCell
        cell3.searchTxtField.text = ""
        let cell4 = searchViewpopup!.searchTbleView.cellForRow(at: indexPathFour) as! SearchTableViewCell
        cell4.searchTxtField.text = ""
        cell.searchTxtField.becomeFirstResponder()
       
    }
    
    @objc func hideTableView(sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0) {
            self.remove_ViewController(secondViewController: self.searchVc)

            
        }
        
        
    }
}
extension LcMainSearchVC{
   
    
    //MARK: - addRemove containerView
    func add_ViewController() {
        let controller  = self.storyboard?.instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC")as! SearchWithListFeatureProductVC
        controller.view.frame = CGRect(x: 0, y: self.view.frame.origin.y + 180, width: self.view.frame.size.width, height:self.view.frame.size.height - 180 )
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        self.searchVc = controller
    }

    // Removing
    func remove_ViewController(secondViewController:SearchWithListFeatureProductVC?) {
        if secondViewController != nil {
            if self.view.subviews.contains(secondViewController!.view) {
                 secondViewController!.view.removeFromSuperview()
            }
            
        }
    }
    

}

