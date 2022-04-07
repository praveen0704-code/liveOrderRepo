//
//  WatchListVC.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift
import CCBottomRefreshControl

class WatchListVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var wishLIstBtn: UIButton!
    @IBOutlet weak var watchListLbl: UILabel!
    @IBOutlet weak var allProductLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var allproductsecLbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var watchListCollView: UICollectionView!
    var sbItemCodeModel:SBItemCodeModel?
    var shotBookIntArray = [Int]()
    var shotBookIndexInt = Int()
    var addtoSBModel : AddToSBModel?
    var removetoSBModel : RemoveFromSBModel?


    
    
    let searchoption = UINib(nibName: "searchView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? searchView
//    let searchoption = UINib(nibName: "MoreOptionView", bundle:
//                        nil).instantiate(withOwner: nil, options: nil)[0] as? MoreOptionView
    let watchoption = UINib(nibName: "WatchListOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? WatchListOptionView
    let onprodctview = UINib(nibName: "ViewOnProductView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? ViewOnProductView
    @objc let addtoCart = UINib(nibName: "AddToCartView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var wishlistModel : WLListModel?
    var wishListItems : [WLListData]?
    var addSBModel : AddToSBModel?
    var removeSBModel : RemoveFromSBModel?
    var removeWLModel : RemoveFromWLModel?
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var addItemModel : AddItemModel?
    var nextPageInt = 0
    var isNextPageAPICall = false
    var selectQty = [String]()
    var searchTxt = 0
    var searchTxtStr : String?
    var erroMge = false

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
      
        
        
        setup()
        
    }
    func setup(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellSize = CGSize(width:screenWidth/2 - 22 , height:269)

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            layout.itemSize = cellSize
//            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//            layout.minimumLineSpacing = 1.0
//            layout.minimumInteritemSpacing = 1.0
        watchListCollView.setCollectionViewLayout(layout, animated: true)
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.triggerVerticalOffset = 50
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        watchListCollView.bottomRefreshControl = bottomRefreshController
        
        
        watchListCollView.dataSource = self
        watchListCollView.delegate = self
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .topToBottom)
      //  topView.applyGradient(colours: [UIColor(hexString: "#6C19D8"),UIColor(hexString:"#674CF3")])
        watchListCollView.register(UINib(nibName: "WatchListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WatchListCollectionViewCell")
        self.sbItemCode(completion: sbItemCode_completion)

        watchlistList(completion: wishList_completion)

    }
    @objc func refreshBottom(){
        if searchTxt == 0{
            nextPageInt = wishlistModel?.payloadJson?.nNextPage ?? 0
            isNextPageAPICall = true
            watchlistList(completion: wishList_completion)
        }else{
            nextPageInt = wishlistModel?.payloadJson?.nNextPage ?? 0
            isNextPageAPICall = true
            watchlistListSearch(searchTxt: searchTxtStr ?? "")
            
        }
      
    }
    @IBAction func wishListBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShortBookVC") as? ShortBookVC
                
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)

        
    }
   
    @IBAction func searchBtnAct(_ sender: Any) {
        searchoption!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        searchoption?.searchTxtField.placeholder = "Search watchlist products"
        searchoption?.delegate = self
        self.view.addSubview(searchoption!)
    }
    
    @IBAction func backBtnAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func cartBtnAct(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
              
              self.navigationController?.navigationBar.isHidden = true
              self.navigationController?.pushViewController(vc!, animated: true)
//        onprodctview!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//
//        self.view.addSubview(onprodctview!)
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
extension WatchListVC:wlSearchTxt{
    func searchTxt(Txt: String) {
        if Txt == ""{
            watchlistList(completion: wishList_completion)
        }else{
            searchTxt = 1
            searchTxtStr = Txt
            nextPageInt = 0
            watchlistListSearch(searchTxt: searchTxtStr ?? "" )
            
        }
    }
    
    
}
extension WatchListVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if erroMge == true{
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.noHistoryLbl.text = "No Record Found"
            noRecordsErrorView.tag = 201
            watchListCollView.backgroundView = noRecordsErrorView
        }else{
            numOfSections = 1
        }
        return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return wishlistModel?.payloadJson?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCollectionViewCell", for: indexPath) as! WatchListCollectionViewCell
        productListCell.productNmeMLLbl.text = wishListItems?[indexPath.row].cItemName ?? ""
        productListCell.schemeLbl.text = wishListItems?[indexPath.row].cScheme ?? ""
        productListCell.schemeLbl.text = "Scheme \(wishListItems?[indexPath.row].cScheme ?? "")"
        productListCell.amountLbl.text = "₹ \(wishListItems?[indexPath.row].cRate ?? "0.0")"
        productListCell.mrpLbl1.text = "MRP  \(wishListItems?[indexPath.row].nMrp ?? 00)"
        productListCell.containsResulLbl.text = wishListItems?[indexPath.row].cContains ?? ""
        productListCell.medicalLbl.text = wishListItems?[indexPath.row].cMfgName ?? ""
        productListCell.packSizeLbl.text = "Pack Size: \(wishListItems?[indexPath.row].cPack ?? 0 )"
        if shotBookIntArray.count != 0{
            if shotBookIntArray[indexPath.row] == 1 {
                productListCell.shortBokBtnImg.image = UIImage(named: "shortbook-2")

            }else{
                productListCell.shortBokBtnImg.image = UIImage(named: "shortbook")

            }
        }
        productListCell.overView.layer.cornerRadius = 5
        productListCell.addToCartBtn.addTarget(self, action: #selector(addcart), for: .touchUpInside)
        productListCell.addToCartBtn.tag = indexPath.row
        productListCell.moreBtn.tag = indexPath.row
        productListCell.shortBookBtn.tag = indexPath.row
        productListCell.shortBookBtn.addTarget(self, action: #selector(shortBookBtnAct), for: .touchUpInside)
        productListCell.moreBtn.addTarget(self, action: #selector(morebtnAct), for: .touchUpInside)
        productListCell.redBtn.isHidden = true
        
       
        return productListCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let padding: CGFloat =  50
//            let collectionViewSize = collectionView.frame.size.width - padding
//
//            return CGSize(width: 100, height: 100)
//        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    
    
    
    @objc func morebtnAct (sender : UIButton){
        watchoption!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        watchoption?.delegate = self
        watchoption?.senderItemcode = wishListItems?[sender.tag].cItemCode ?? ""
        watchoption?.senderItemName = wishListItems?[sender.tag].cItemName ?? ""
        self.view.addSubview(watchoption!)
    }
    @objc func addcart (sender : UIButton){
        productWiseSellerDetails(wishItemCodeStr: wishListItems?[sender.tag].cItemCode ?? "", itemName: wishListItems?[sender.tag].cItemName ?? "")
        
        
    }
    @objc func shortBookBtnAct (sender : UIButton){
        shotBookIndexInt = sender.tag
        if shotBookIntArray[sender.tag] == 1 {
            removeShotbook(itemCodeStr:wishListItems?[sender.tag].cItemCode ?? "", itemNameStr: wishListItems?[sender.tag].cItemName ?? "")

        }else{
            addToShotook(itemCodeStr:wishListItems?[sender.tag].cItemCode ?? "", itemNameStr: wishListItems?[sender.tag].cItemName ?? "")

        }
    }
}
extension WatchListVC : addcartDelegate{
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
        
    
    }
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    
}
extension WatchListVC: moreBtnDelegate{
    func morebtnact(type: String, senderCode: String, senderName: String) {
        if type == "1"{
           
            removeWishList(itemCodeStr: senderCode, itemNameStr: senderName)
        }else{
            let productDesVc = self.storyboard?.instantiateViewController(withIdentifier: "AfterScanFmgcProductVC") as! AfterScanFmgcProductVC
            productDesVc.productIDStr = senderCode
            self.navigationController?.pushViewController(productDesVc, animated: true)

        }
    }

    
    
}
    
    
extension WatchListVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension WatchListVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func watchlistList(completion: @escaping LOHOMELOADAPI){
        showActivityIndicator(self.view)
        
        
        let watchlistList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "watchlistList")
        
//            let nHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
//                                        "X-csquare-api-token":"-448945721a86225",
//                                        "Content-Type":"application/json",
//                                            ]
        
        let wlParams = ["n_page":nextPageInt,
                        "n_limit":20]

        let wlHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        watchlistList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+WISHLIST_LIST_URL, type: .post, userData: wlParams, apiHeader: wlHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.wishlistModel = WLListModel(object:dict)
            if boolSuccess {
               
                if self.wishlistModel?.appStatusCode == 0{
                    itemLbl.text = "\(wishlistModel?.payloadJson?.nTotal ?? 0) Items"
                    
                    if self.isNextPageAPICall {
                        
                        if let wishListItemsVal = wishlistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                self.wishListItems = self.wishListItems!.count > 0 ? self.wishListItems! + wishListItemsVal : wishListItemsVal
                                let queue = DispatchQueue(label: "com.myApp.myQueu")

                                    queue.sync {

                                        shotBookAddRemove(completion: shotBook_completion )


                                    }
                                watchListCollView.reloadData()
                                watchListCollView.bottomRefreshControl?.endRefreshing()
                                completion()
                            }else{
                                
                                    isNextPageAPICall = false
                                    nextPageInt = 0
                                watchListCollView.reloadData()
                                completion()

                                
                            }
                        }
                    }
                    else{
                        if let wishListItemsVal = wishlistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                let queue = DispatchQueue(label: "com.myApp.myQueu")

                                    queue.sync {

                                        shotBookAddRemove(completion: shotBook_completion )


                                    }
                                    
    
                                self.wishListItems = wishListItemsVal
                                watchListCollView.reloadData()

                                watchListCollView.bottomRefreshControl?.endRefreshing()
                                completion()

                            }else{
                                erroMge = true
                                completion()

                            }
                        }
                    }
                    
               

                }else{
                    erroMge = true

                    watchListCollView.bottomRefreshControl?.endRefreshing()
                    completion()

                }
                
            }else{
                erroMge = true

                watchListCollView.bottomRefreshControl?.endRefreshing()
                completion()


            }
            hideActivityIndicator(self.view)
            watchListCollView.bottomRefreshControl?.endRefreshing()
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            watchListCollView.bottomRefreshControl?.endRefreshing()
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
            erroMge = true
            completion()


        })
        
        
        }
    func watchlistListSearch(searchTxt:String){
        showActivityIndicator(self.view)
        
        
        let watchlistList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "watchlistList")
        
//            let nHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
//                                        "X-csquare-api-token":"-448945721a86225",
//                                        "Content-Type":"application/json",
//                                            ]
        
        let wlParams = ["c_search_term":searchTxt,"n_page":nextPageInt,
                        "n_limit":20] as [String : Any]

        let wlHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        watchlistList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+WISHLIST_LIST_URL, type: .post, userData: wlParams, apiHeader: wlHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.wishlistModel = WLListModel(object:dict)
            if boolSuccess {
               
                if self.wishlistModel?.appStatusCode == 0{
                    itemLbl.text = "\(wishlistModel?.payloadJson?.nTotal ?? 0) Items"
                    
                    if self.isNextPageAPICall {
                        
                        if let wishListItemsVal = wishlistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                self.wishListItems = self.wishListItems!.count > 0 ? self.wishListItems! + wishListItemsVal : wishListItemsVal
                                watchListCollView.bottomRefreshControl?.endRefreshing()
                            }else{
                                
                                    isNextPageAPICall = false
                                    nextPageInt = 0
                                    self.watchlistListSearch(searchTxt: searchTxtStr ?? "")
                                    
                                
                            }
                        }
                    }
                    else{
                        if let wishListItemsVal = wishlistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
    
                                self.wishListItems = wishListItemsVal
                                watchListCollView.bottomRefreshControl?.endRefreshing()
                            }
                        }
                    }
                    
                    watchListCollView.reloadData()
                    
                    watchListCollView.bottomRefreshControl?.endRefreshing()
                    
                //   apiQueue.leave()
                    
                    


                }else{
                    watchListCollView.bottomRefreshControl?.endRefreshing()
                }
                
                watchListCollView.bottomRefreshControl?.endRefreshing()
            }else{
                        
                watchListCollView.bottomRefreshControl?.endRefreshing()
            }
            hideActivityIndicator(self.view)
            watchListCollView.bottomRefreshControl?.endRefreshing()
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            watchListCollView.bottomRefreshControl?.endRefreshing()
        })
        
        
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
                
                //hideActivityIndicator(self.view)
                if self.addSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    self.shotBookIntArray[shotBookIndexInt] = 1
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    UIView.performWithoutAnimation {
                    self.watchListCollView.reloadItems(at: [sbIndexPath])
                    }
                    sbItemCode(completion: sbItemCode_completion)
    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    self.shotBookIntArray[shotBookIndexInt] = 1
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    UIView.performWithoutAnimation {
                    self.watchListCollView.reloadItems(at: [sbIndexPath])
                    }
                    sbItemCode(completion: sbItemCode_completion)


                    
                    
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
            self.removeSBModel = RemoveFromSBModel(object:dict)
            
            if boolSuccess {
                //hideActivityIndicator(self.view)
                
                if self.removeSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    self.shotBookIntArray[shotBookIndexInt] = 0
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    self.watchListCollView.reloadItems(at: [sbIndexPath])
                    sbItemCode(completion: sbItemCode_completion)
                  // shortBookCount()
                    
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeSBModel?.messages?[0] ?? "", view: self.view)
                    self.shotBookIntArray[shotBookIndexInt] = 0
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    self.watchListCollView.reloadItems(at: [sbIndexPath])
                    sbItemCode(completion: sbItemCode_completion)
                   // shortBookCount()
                    
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            //hideActivityIndicator(self.view)
        })
    }
    
    func removeWishList(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let WishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let WishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
            let WishListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        WishList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REMOVE_FROM_WISHLIST_URL, type: .post, userData: WishListParams, apiHeader: WishListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.removeWLModel = RemoveFromWLModel(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.removeWLModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeWLModel?.messages?[0] ?? "", view: self.view)
                    watchlistList(completion: wishList_completion)
                       
                   
                  
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeWLModel?.messages?[0] ?? "", view: self.view)
                   
                    watchlistList(completion: wishList_completion)
                }
                
                

            }else{
                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in

            hideActivityIndicator(self.view)

        })
        
        
        }
    func productWiseSellerDetails(wishItemCodeStr:String,itemName:String){
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
                
                
                
                if self.productWiseSellerModel?.appStatusCode == 0{
                    for (_,ele) in (productWiseSellerModel?.payloadJson?.data?.jList)!.enumerated() {
                        self.selectQty.append("1")
                        
                        
                    }
                    
                    print(self.selectQty)
                    
                    addtoCart!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    addtoCart?.delegate = self
                    addtoCart?.productName = itemName
                   
                    
                    addtoCart?.productwiseSellerModel = productWiseSellerModel
                    addtoCart?.selectQtyS = selectQty
                   
                    
                    self.view.addSubview(addtoCart!)
                    
                    
                    
                }else{
                    
                    
                }
                
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            
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
           

        })
        
        
        }
    
    
    //MARK: - Completion Shotbook Wish List
        func shotBookAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (self.wishlistModel?.payloadJson?.data)!.enumerated(){
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
            completion()
        }
    //MARK: - shotBookCount
    func sbItemCode(completion: @escaping LOHOMELOADAPI){
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
                    


                    hideActivityIndicator(self.view)
                    completion()

                    
                   
                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                

            }else{
                        
                hideActivityIndicator(self.view)
                completion()


            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
            //hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
            completion()


        })
        
        }

}

