//
//  ShortBookVC.swift
//  liveOrder
//
//  Created by Data Prime on 26/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import NotificationBannerSwift
import CCBottomRefreshControl
import LazyImage

class ShortBookVC: UIViewController {
    @IBOutlet weak var tpview: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var shortBookLbl: UILabel!
    @IBOutlet weak var allProductLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var shortBookCollView: UICollectionView!
    @IBOutlet weak var moreBtn: UIButton!
    var wishListIndexInt = Int()
    var wlItemCodeModel:WLItemCodeModel?

    
    @IBOutlet weak var shtLbl: UILabel!
    
    let moreoption = UINib(nibName: "MoreOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MoreOptionView
    let addToCartView = UINib(nibName: "AddToCartView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var sblistModel : SBListModel?
    var sbItems : [SBListData]?
    var sbItemsforTableView : [SBListData]?
    var addtoWLmodel : AWBaseClass?
    var removefromWLModel : RemoveFromWLModel?
    var removefromSbModel : RemoveFromSBModel?
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var erroMge = false
    var nxtpage = 0
    var isNextPageAPICall = false
    var selectQty = [String]()
    var addItemModel:AddItemModel?
    var searchTxt = 0
    var searchTxtStr : String?
    lazy var shotBookImgLazy:LazyImage = LazyImage()
    var wishListIntArray = [Int]()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setup()
        
    }
    func setup (){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellSize = CGSize(width:screenWidth/2 - 22 , height:276)

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            layout.itemSize = cellSize
//            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//            layout.minimumLineSpacing = 1.0
//            layout.minimumInteritemSpacing = 1.0
            shortBookCollView.setCollectionViewLayout(layout, animated: true)
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.triggerVerticalOffset = 50
       
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        shortBookCollView.bottomRefreshControl = bottomRefreshController
        
        shortBookCollView.dataSource = self
        shortBookCollView.delegate = self
        tpview.clipsToBounds = true
        tpview.layer.cornerRadius = 30
        tpview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tpview.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .topToBottom)
      //  tpview.applyGradient(colours: [UIColor(hexString: "#6C19D8"),UIColor(hexString:"674CF3")])
        shortBookCollView.register(UINib(nibName: "ShortBookCollViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ShortBookCollViewCell")
        let origImage = UIImage(named: "more")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        moreBtn.setImage(tintedImage, for: .normal)
        moreBtn.tintColor = UIColor.init(hexString: "6c757d")
        self.wlItemCode(completion: sbItemCode_completion)
        shortBookList(completion: sbItemCode_completion)


    }
    @objc func refreshBottom(){
        if isNextPageAPICall == true{
            shortBookList(completion: shotbookList_completion)

        }else{
//            erroMge = true
            shortBookCollView.reloadData()
            shortBookCollView.bottomRefreshControl?.endRefreshing()

        }
        
       
    }
    @IBAction func moreBtnAct(_ sender: Any) {
        moreoption!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
       
        moreoption?.moreList = sbItemsforTableView
        moreoption?.delegate = self
        self.view.addSubview(moreoption!)
    }
    @IBAction func wishListBtnAct(_ sender: Any) {
        print("button ")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WatchListVC") as? WatchListVC
              
              self.navigationController?.navigationBar.isHidden = true
              self.navigationController?.pushViewController(vc!, animated: true)


    }
    
    @IBAction func cartBtnAct(_ sender: Any) {
        print("button cart")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
              self.navigationController?.navigationBar.isHidden = true
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backBtnAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
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
extension ShortBookVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if erroMge == true{
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.noHistoryLbl.text = "No Record Found"
            noRecordsErrorView.tag = 201
            shortBookCollView.backgroundView = noRecordsErrorView
        }else{
            numOfSections = 1
        }
        return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sbItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortBookCollViewCell", for: indexPath) as! ShortBookCollViewCell
        productListCell.mlLbl.text = sbItems?[indexPath.row].cItemName ?? ""
        productListCell.schemeLbl.text = "Schemes:\(sbItems?[indexPath.row].cScheme ?? "")"
        productListCell.rupeeLbl.text = "₹ \(sbItems?[indexPath.row].nMrp ?? 0)"
        productListCell.preSellerAnswerLbl.text = sbItems?[indexPath.row].cMfgName ?? ""
        productListCell.containAnswerLbl.text = sbItems?[indexPath.row].cContains ?? ""
        productListCell.redBtn.isHidden = true
        productListCell.addtoCartBtn.tag = indexPath.row
        productListCell.wishListBtn.tag = indexPath.row
        productListCell.crossBtn.tag = indexPath.row
        shotBookImgLazy.showWithSpinner(imageView:productListCell.productImageView, url: sbItems?[indexPath.row].cImageUrL, defaultImage:"injectable")
        productListCell.crossBtn.addTarget(self, action: #selector(removeSbBtnAct), for: .touchUpInside)
        
        productListCell.addtoCartBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        productListCell.wishListBtn.addTarget(self, action: #selector(wishListBtnact), for: .touchUpInside)
        if wishListIntArray.count != 0{
            if self.wishListIntArray[indexPath.row] == 1 {
                
                productListCell.wishBtnImg.image = UIImage(named: "wishlist_1")

            }else{
                productListCell.wishBtnImg.image = UIImage(named: "wishlist")

            }

        }
        return productListCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
//    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    @objc func addToCartAction(sender:UIButton){
        productWiseSellerDetails(wishItemCodeStr: sbItems?[sender.tag].cItemCode ?? "", itemName: sbItems?[sender.tag].cItemName ?? "")
    }
    @objc func wishListBtnact(sender:UIButton){
        print(sender.tag)
        wishListIndexInt = sender.tag
        print(wishListIndexInt)
        if self.wishListIntArray[sender.tag] == 1{

            removeWishList(itemCodeStr: sblistModel?.payloadJson?.data?[sender.tag].cItemCode ?? "", itemNameStr: sblistModel?.payloadJson?.data?[sender.tag].cItemName ?? "")

        }else{
            addToWishList(itemCodeStr:sblistModel?.payloadJson?.data?[sender.tag].cItemCode ?? "", itemNameStr: sblistModel?.payloadJson?.data?[sender.tag].cItemName ?? "")

        }
    }
    @objc func removeSbBtnAct(sender:UIButton){
        removeShotook(itemCodeStr: sblistModel?.payloadJson?.data?[sender.tag].cItemCode ?? "", itemNameStr: sblistModel?.payloadJson?.data?[sender.tag].cItemName ?? "")
    }

}
extension ShortBookVC: addcartDelegate{
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        
    }
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }

}
extension ShortBookVC:sbSearchTxt{
    func searchTxt(Txt: String) {
        print(Txt)
        if Txt == ""{
            nxtpage = 0
            shortBookList(completion: shotbookList_completion)
            
        }else{
            searchTxt = 1
            searchTxtStr = Txt
            nxtpage = 0
            isNextPageAPICall = false
            shortBookListSearch(searchTxt: Txt)
            
        }
    }
    
    
}
extension ShortBookVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension ShortBookVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func shortBookList(completion: @escaping LOHOMELOADAPI){
        showActivityIndicator(self.view)
        self.wishListIntArray.removeAll()
        let shortBookList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shortBookList")
        

        let sbParams = ["n_page":nxtpage,
                        "n_limit":40]
        print(sbParams)
        let sbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(sbParams)

        shortBookList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHORTBOOK_LIST_URL, type: .post, userData: sbParams, apiHeader: sbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.sblistModel = SBListModel(object:dict)
            if boolSuccess {
               
                if self.sblistModel?.appStatusCode == 0{
                    productCountLbl.text = "\(sblistModel?.payloadJson?.data?.count ?? 0) Items"
                    nxtpage = sblistModel?.payloadJson?.nNextPage ?? 0
                    
                    if self.isNextPageAPICall {
                        
                        if let wishListItemsVal = sblistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                
                                self.sbItems = self.sbItems!.count > 0 ? self.sbItems! + wishListItemsVal : wishListItemsVal
                                let queue = DispatchQueue(label: "com.myApp.myQueu")
                                
                                queue.sync {


                                    wishListAddRemove(completion: wishList_completion)


                                }
                                shortBookCollView.reloadData()
                                print(wishListIntArray)

                                completion()
                            }else{
                                
                                    isNextPageAPICall = false
                                    nxtpage = 0
                                shortBookCollView.bottomRefreshControl?.endRefreshing()

                                    completion()
                                
                            }
                        }
                    }
                    else{
                        if let wishListItemsVal = sblistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                let queue = DispatchQueue(label: "com.myApp.myQueu")

                                queue.sync {
                                    wishListAddRemove(completion: wishList_completion)

                                }
    
                                self.sbItems = wishListItemsVal
                                self.sbItemsforTableView = wishListItemsVal
                                shortBookCollView.reloadData()
                                print(wishListIntArray)

                                completion()
                            }else{
                                erroMge = true
                                shortBookCollView.bottomRefreshControl?.endRefreshing()

                                completion()

                            }
                        }
                    }
                  
               

                }else{
                    hideActivityIndicator(self.view)
                    shortBookCollView.bottomRefreshControl?.endRefreshing()
                    completion()

                }
                

            }else{
                hideActivityIndicator(self.view)
                shortBookCollView.bottomRefreshControl?.endRefreshing()
                completion()


            }
            hideActivityIndicator(self.view)
            shortBookCollView.bottomRefreshControl?.endRefreshing()
            completion()

            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            shortBookCollView.bottomRefreshControl?.endRefreshing()
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
            completion()

        })
        
        
        }
    func shortBookListSearch(searchTxt:String){
        showActivityIndicator(self.view)

        let shortBookList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shortBookList")
        

        let sbParams = ["c_search_term":searchTxt,"n_page":nxtpage,
                        "n_limit":40] as [String : Any]

        let sbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(sbParams)

        shortBookList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHORTBOOK_LIST_URL, type: .post, userData: sbParams, apiHeader: sbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.sblistModel = SBListModel(object:dict)
            if boolSuccess {
               
                if self.sblistModel?.appStatusCode == 0{
                    productCountLbl.text = "\(sblistModel?.payloadJson?.data?.count ?? 0) Items"
                    nxtpage = sblistModel?.payloadJson?.nNextPage ?? 0
                    if self.isNextPageAPICall {
                        
                        if let wishListItemsVal = sblistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
                                self.sbItems = self.sbItems!.count > 0 ? self.sbItems! + wishListItemsVal : wishListItemsVal
                                let queue = DispatchQueue(label: "com.myApp.myQueu")

                                queue.sync {


                                    wishListAddRemove(completion: wishList_completion)

                                }
                                shortBookCollView.bottomRefreshControl?.endRefreshing()
                            }else{
                                
                                    isNextPageAPICall = false
                                    nxtpage = 0
                               self.shortBookList(completion: shotbookList_completion)
                                    
                                
                            }
                        }
                    }
                    else{
                        if let wishListItemsVal = sblistModel?.payloadJson?.data{
                            if wishListItemsVal.count != 0{
    
                                self.sbItems = wishListItemsVal
                                let queue = DispatchQueue(label: "com.myApp.myQueu")
                                erroMge = false


                                queue.sync {


                                    wishListAddRemove(completion: wishList_completion)

                                }
                                shortBookCollView.bottomRefreshControl?.endRefreshing()
                            }else{
                                erroMge = true
                            }
                        }
                    }
                  
                    
                //   apiQueue.leave()
                    
                    shortBookCollView.reloadData()
                    shortBookCollView.bottomRefreshControl?.endRefreshing()

                }else{
                    hideActivityIndicator(self.view)
                    shortBookCollView.bottomRefreshControl?.endRefreshing()
                    erroMge = true

                }
                

            }else{
                hideActivityIndicator(self.view)
                shortBookCollView.bottomRefreshControl?.endRefreshing()
                erroMge = true


            }
            hideActivityIndicator(self.view)
            shortBookCollView.bottomRefreshControl?.endRefreshing()
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            hideActivityIndicator(self.view)
            shortBookCollView.bottomRefreshControl?.endRefreshing()
            erroMge = true

        })
        
        
        }
    
    func addToWishList(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let addToWishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToWishList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let addToWishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]

            let WlHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        addToWishList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_WISHLIST_URL, type: .post, userData: addToWishListParams, apiHeader: WlHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addtoWLmodel = AWBaseClass(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.addtoWLmodel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    print(self.wishListIndexInt)

                    self.wishListIntArray[wishListIndexInt] = 1
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.shortBookCollView.reloadItems(at: [wbIndexPath])
                    wlItemCode(completion: wlItemCode_completion)

                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    print(self.wishListIndexInt)

                    self.wishListIntArray[wishListIndexInt] = 1
                    print(wishListIndexInt)
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.shortBookCollView.reloadItems(at: [wbIndexPath])
                    wlItemCode(completion: wlItemCode_completion)
                }
                
                

            }else{
                        
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in

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
            self.removefromWLModel = RemoveFromWLModel(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.removefromWLModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removefromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removefromWLModel?.messages?[0] ?? "", view: self.view)
                    print(self.wishListIndexInt)

                    self.wishListIntArray[wishListIndexInt] = 0
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.shortBookCollView.reloadItems(at: [wbIndexPath])
                    wlItemCode(completion: wlItemCode_completion)
                
                }else{
                    
                    let banner = NotificationBanner(title: "Message", subtitle: self.removefromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removefromWLModel?.messages?[0] ?? "", view: self.view)
                    print(self.wishListIndexInt)
                    self.wishListIntArray[wishListIndexInt] = 0
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.shortBookCollView.reloadItems(at: [wbIndexPath])
                    wlItemCode(completion: wlItemCode_completion)

                   
                }
                
                

            }else{
                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in

            hideActivityIndicator(self.view)

        })
        
        
        }
    func removeShotook(itemCodeStr:String,itemNameStr:String){
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
            self.removefromSbModel = RemoveFromSBModel(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                
                if self.removefromSbModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removefromSbModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removefromSbModel?.messages?[0] ?? "", view: self.view)
                    nxtpage = nxtpage - 1
                    shortBookList(completion: shotbookList_completion)
                  
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removefromSbModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removefromSbModel?.messages?[0] ?? "", view: self.view)
                    nxtpage = nxtpage - 1
                    shortBookList(completion: shotbookList_completion)
                    
                }
                
                

            }else{
                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)


        })
        
        
        }
    //MARK: - Wish ListItem Code
    func wlItemCode(completion: @escaping LOHOMELOADAPI){
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
        sbItemCode.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+WISHLIST_ITEM_CODE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.wlItemCodeModel = WLItemCodeModel(object:dict)
            
            if boolSuccess {
               
                if self.wlItemCodeModel?.appStatusCode == 0{


                    hideActivityIndicator(self.view)

                    completion()
                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                
               hideActivityIndicator(self.view)
                
            }else{
                        
                hideActivityIndicator(self.view)
                completion()

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
            completion()


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
                    
                    addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    addToCartView?.delegate = self
                    addToCartView?.productName = itemName
                   
                    
                    addToCartView?.productwiseSellerModel = productWiseSellerModel
                    addToCartView?.selectQtyS = selectQty
                   
                    
                    self.view.addSubview(addToCartView!)
                    
                    
                    
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
    func wishListAddRemove(completion: @escaping SWCOMPLETION){
        for (inx,ele) in (self.sblistModel?.payloadJson?.data)!.enumerated(){
            self.wishListIntArray.append(0)
            if self.wlItemCodeModel?.payloadJson?.data != nil{
                for (_,wEle) in (self.wlItemCodeModel?.payloadJson?.data)!.enumerated(){
                    if ele.cItemCode == wEle.cItemCode{
                        wishListIntArray[inx] = 1
                    }else{
                      //  shotBookIntArray[inx] = 0
                    }
                }

            }
        }

    }
}
