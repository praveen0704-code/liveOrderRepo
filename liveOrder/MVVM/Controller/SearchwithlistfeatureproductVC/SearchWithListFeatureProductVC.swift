//
//  SearchWithListFeatureProductVC.swift
//  liveOrder
//
//  Created by Data Prime on 16/07/21.
//

import UIKit
import Alamofire
import LazyImage
import CCBottomRefreshControl
import NotificationBannerSwift
protocol passHeigtDeleate{
    func passViewHeigt()
}
class SearchWithListFeatureProductVC: UIViewController{
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var topNaviView: UIView!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var microPhoneBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var showingLbl: UILabel!
    @IBOutlet weak var showingResultLbl: UILabel!
    @IBOutlet weak var alsoSearchedLbl: UILabel!
    @IBOutlet weak var alsoSearchedResultLbl: UILabel!
    @IBOutlet weak var resultCollView: UICollectionView!
    @IBOutlet weak var addSuccessIngView: UIImageView!
    @IBOutlet weak var addSuccessTxtLbl: UILabel!
    var selectedIndex : UIButton!
    var isNextPageAPICall : Bool = false
    var sbItemCodeModel:SBItemCodeModel?
    var wlItemCodeModel:WLItemCodeModel?
    var apiQueue = DispatchGroup()
    var addtoSBModel : AddToSBModel?
    var removetoSBModel : RemoveFromSBModel?
    //FIXME: - ShotBook WishList Check Array
    var shotBookIntArray = [Int]()
    var wishListIntArray = [Int]()
    //FIXME: - ShotBook WishList Cell Index
    var shotBookIndexInt = Int()
    var wishListIndexInt = Int()
    var selectQty = [String]()
    
    
    var removeFromWLModel : RemoveFromWLModel?
    var addtoWLmodel : AWBaseClass?
    var addItemModel : AddItemModel?

    


    var arraySearchProductJlist:[SearchProductModelJList]?
    var passHeigtViewDelegate:passHeigtDeleate?
    

    @IBOutlet weak var searchAlsoCollectionView: UICollectionView!
    
    
    let addtoCartVc = UINib(nibName: "AddToCartView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    
    var searchTextStr = String()
    var searchProductDDModel:SearchProductModel?
    lazy var searchProductImg:LazyImage = LazyImage()
    var nextPageInt = 0
    var lastContentOffset: CGFloat = 0
    var resArray = [String]()
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var productWiseSellerModel : ProductVsSellerDetailsModel?

    
    var errorMesg = false
    
    typealias MULTISEARCHCOMPLETION = () -> ()

    let multiSearchSB_completion = {
        print("functionOne COMPLETED")
    }

    let multiSearchWL_completion = {
        print("functionTwo COMPLETED")
    }
    
    let multiSearch_completion = {
        print("functionTwo COMPLETED")
    }
    
    let searchShotBook_completion = {
        print("functionOne COMPLETED")
    }

    let serachWishList_completion = {
        print("functionTwo COMPLETED")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.triggerVerticalOffset = 50
       
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        resultCollView.bottomRefreshControl = bottomRefreshController
        print(searchTextStr)
        addtoCartVc?.delegate = self
        setup()
    }
   
    
    
    func setup (){
       
        resultCollView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier: productlistVariantscelidentifreStr)
        searchAlsoCollectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        self.searchAlsoCollectionView.delegate = self
        self.searchAlsoCollectionView.dataSource = self
        
        self.resultCollView.delegate = self
        self.resultCollView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
  
        self.showingResultLbl.text = multiSearchArray[0]
        let queue = DispatchQueue(label: "com.myApp.myQueue")

            queue.sync {

                multiSearchSB_completion(completion: multiSearchSB_completion)
                multiSearchWL_completion(completion: multiSearchWL_completion)
                multiSearch_completion(searchText:self.showingResultLbl.text ?? "", completion: multiSearch_completion)

            }
        
        
      
        

    }
    @objc func refreshBottom(){
        
    }
    
    @IBAction func wishListBtnAct(_ sender: Any) {
        
    }
    
    @IBAction func shortBookBtnAct(_ sender: Any) {
        
    }
    
    @IBAction func cartBtnAct(_ sender: Any) {
        
    }
    
    @IBAction func profileBtnAct(_ sender: Any) {
        
    }
    @IBAction func scanBtnAct(_ sender: Any) {
        
    }
    
    @IBAction func microPhoneBtnAct(_ sender: Any) {
        
    }
    @IBAction func notificationBtnAct(_ sender: Any) {
    
    }
    
   
}
extension SearchWithListFeatureProductVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numberOfSec : Int = 0
        if errorMesg == true{
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.tag = 201
            noRecordsErrorView.noHistoryLbl.isHidden = true
            noRecordsErrorView.nothingHereLbl.textColor = UIColor.red
            noRecordsErrorView.nothingHereLbl.text = "Oops.!products not found."
            resultCollView.backgroundView = noRecordsErrorView
            resultCollView.isScrollEnabled = false
            numberOfSec = 0
        }else{
            collectionView.backgroundView = nil
            numberOfSec = 1
        }
        return numberOfSec    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.searchAlsoCollectionView {

            return multiSearchArray.count
            
        }else{
            return arraySearchProductJlist?.count ?? 0

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.searchAlsoCollectionView{
            
            let searchResCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            
            searchResCollCell.searchResultsLabel.text = multiSearchArray[indexPath.row]
            
            return searchResCollCell
            
        }else{
            let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
            
            productListCell.overAllView.layer.cornerRadius = 5
            productListCell.offerBtn.isHidden = true
            productListCell.productMgLbl.text = arraySearchProductJlist?[indexPath.row].cItemName
            productListCell.packSizeMlLbl.text = arraySearchProductJlist?[indexPath.row].cPackName
            productListCell.mrpansLbl.text = "₹\(arraySearchProductJlist?[indexPath.row].nMaxMrp ?? 0)"
            productListCell.gstLbl.isHidden = true
            productListCell.madicineNameLbl.text = arraySearchProductJlist?[indexPath.row].cContainName
            
            productListCell.wishListBtn.tag = indexPath.row
            productListCell.shortBookBtn.tag = indexPath.row
            productListCell.addtoCardBtn.tag = indexPath.row
            productListCell.wishListBtn.addTarget(self, action: #selector(searchWishListAction), for: .touchUpInside)
            productListCell.shortBookBtn.addTarget(self, action: #selector(searchShortBookAction), for: .touchUpInside)
            
            //searchProductImg.showWithSpinner(imageView: productListCell.productImgView, url: searchProductDDModel?.payloadJson?.data?.jList?[indexPath.row].acThumbnailImages)
            searchProductImg.showWithSpinner(imageView: productListCell.productImgView, url: arraySearchProductJlist?[indexPath.row].acThumbnailImages, defaultImage: "injectable")
            
            productListCell.addtoCardBtn.addTarget(self, action: #selector(addtocartFunction(sender:)), for: .touchUpInside)
            
            //FIXME: - Add images
            if wishListIntArray.count != 0{
                if wishListIntArray[indexPath.row] == 1 {
                    productListCell.wishListImg.image = UIImage(named: "wishlist_1")

                }else{
                    productListCell.wishListImg.image = UIImage(named: "wishlist")

                }
            }
            if shotBookIntArray.count != 0{
                if shotBookIntArray[indexPath.row] == 1 {
                    productListCell.shortBokImg.image = UIImage(named: "shortbook-2")

                }else{
                    productListCell.shortBokImg.image = UIImage(named: "shortbook")

                }
            }
            
                
          
            return productListCell
        }
        
        
       
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.searchAlsoCollectionView{
            self.shotBookIntArray.removeAll()
            self.wishListIntArray.removeAll()
            isNextPageAPICall = false
            nextPageInt = 0
            
            self.showingResultLbl.text = multiSearchArray[indexPath.row]
            multiSearch_completion(searchText:multiSearchArray[indexPath.row] ?? "", completion: multiSearch_completion)


        }else{
            
        }
       
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.searchAlsoCollectionView{
            
            let searchResCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            searchResCollCell.searchResultsLabel.sizeToFit()
            return CGSize(width: searchResCollCell.searchResultsLabel.frame.width, height: 40.0)

        }else{
            
            return CGSize(width: 140.0, height:221.0)

        }
                
}
 
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            if searchProductDDModel?.messages?[0] == "RECORD_NOT_FOUND"{
                nextPageInt = nextPageInt - 1
                multiSearch_completion(searchText:self.showingResultLbl.text ?? "", completion: multiSearch_completion)

                isNextPageAPICall = true
                print("end down")
                print(nextPageInt)
            }else{
                nextPageInt = searchProductDDModel?.payloadJson?.data?.nNextPage ?? 0
                multiSearch_completion(searchText:self.showingResultLbl.text ?? "", completion: multiSearch_completion)

                isNextPageAPICall = true
                print("down")
                print(nextPageInt)
            }
            
            
            
        }
    }
    
    
    
    @objc func addtocartFunction(sender:UIButton){
        
        productWiseSellerDetails(wishItemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "",itemName: arraySearchProductJlist?[sender.tag].cItemName ?? "")
    }
    //MARK: - topmost WLISR BTN ACT AND SHORTBOOK BTN ACR
    @objc func searchWishListAction(sender:UIButton){
       
        self.wishListIndexInt = sender.tag
        if self.wishListIntArray[sender.tag] == 1{
            
            removeWishList(itemCodeStr: arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")
        

        }else{
            addToWishList(itemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")

        }
        
        
        
    }
    @objc func searchShortBookAction(sender:UIButton){
       
        self.shotBookIndexInt = sender.tag
        if self.shotBookIntArray[sender.tag] == 1{
            self.removeShotbook(itemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "", itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")

        }else{
            
            self.addToShotook(itemCodeStr:arraySearchProductJlist?[sender.tag].cItemCode ?? "" ,itemNameStr: arraySearchProductJlist?[sender.tag].cItemName ?? "")
            
            
        }
        
        
        
    }
}

extension SearchWithListFeatureProductVC : addcartDelegate{
    
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        //print(itemcode,selectQtyS,sCode,sName,rate)
        
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
       
    }
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    
   

}
extension SearchWithListFeatureProductVC:WebServiceDelegate {
    
    func webServiceGotExpiryMessage(errorMessage: String) {

    }
    
  

    
    //MARK: - Top Order Completion Shotbook Wish List
        func shotBookAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (self.searchProductDDModel?.payloadJson?.data?.jList)!.enumerated(){
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
        func wishListAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (self.searchProductDDModel?.payloadJson?.data?.jList)!.enumerated(){
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
            
            
            
            //MARK: - Search api call
                func multiSearchSB_completion(completion: @escaping SWCOMPLETION){
                    apiQueue.enter()
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
                                
                               // multiSearch_completion(searchText:self.showingResultLbl.text ?? "", completion: multiSearch_completion)

            //                    if loadfirstInt == 1{
            //                        self.topmostApi(pin:pincode ?? "")
            //                        self.NewLanchItemApi(pin:pincode ?? "")
            //
            //                    }else{
            //                        if tShotookBookInt == 1{
            //                            self.topmostApi(pin:pincode ?? "")
            //
            //                        }else{
            //                            self.NewLanchItemApi(pin:pincode ?? "")
            //
            //                        }
            //                    }
                                hideActivityIndicator(self.view)

                                completion()

                                
                               
                            }else{
                                self.resultCollView.reloadData()

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
                    apiQueue.leave()
                    
                  
                }
                func multiSearchWL_completion(completion: @escaping SWCOMPLETION){
                    apiQueue.enter()
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
                                
                              //  multiSearch_completion(searchText:self.showingResultLbl.text ?? "", completion: multiSearch_completion)

            //                    if loadfirstInt == 1{
            ////                        self.topmostApi(pin:pincode ?? "")
            ////                        self.NewLanchItemApi(pin: self.pincode ?? "")
            //
            //                    }else{
            //                        if tWishListInt == 1{
            //                            self.topmostApi(pin:pincode ?? "")
            //
            //                        }else{
            //                            self.NewLanchItemApi(pin: self.pincode ?? "")
            //
            //                        }
                               // }

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
                    apiQueue.leave()
                }
            func multiSearch_completion(searchText:String,completion: @escaping SWCOMPLETION){
              
                print(searchText)
                showActivityIndicator(self.view)
                print(nextPageInt)
                let searchProductDropDown:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "SearchProductDropDown")
                let searchProductDDParms = ["n_page":nextPageInt,
                                            "n_limit":20,
                                            "c_search_term":"\(searchText)"] as [String : Any]
                
                print(searchProductDDParms)
                
                            let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                        "Content-Type":"application/json",
                                                            ]
                
                searchProductDropDown.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_PRODUCT_DROPDOWN_URL, type: .post, userData: searchProductDDParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                      print(dict)
                    self.searchProductDDModel = SearchProductModel(object:dict)
                    if boolSuccess {
                        
                        if self.searchProductDDModel?.appStatusCode == 0{
                            
                            if self.isNextPageAPICall {
                                hideActivityIndicator(self.view)

                                if let productSearchVal = searchProductDDModel?.payloadJson?.data?.jList{
                                    if productSearchVal.count != 0{
                                        hideActivityIndicator(self.view)

                                        self.arraySearchProductJlist = self.arraySearchProductJlist!.count > 0 ? self.arraySearchProductJlist! + productSearchVal : productSearchVal
                                        let searchQueue = DispatchQueue(label: "com.myApp.searchmyQueue")

                                        searchQueue.sync {

                                                shotBookAddRemove(completion: shotBook_completion )
                                                wishListAddRemove(completion: wishList_completion)

                                            }
                                        errorMesg = false
                                        self.resultCollView.reloadData()

                                        completion()

                                    }else{
                                        errorMesg = true
                                        arraySearchProductJlist?.removeAll()
                                        self.resultCollView.reloadData()
                                        completion()
                                    }
                                }
                            }
                            else{
                                if let productSearchval = searchProductDDModel?.payloadJson?.data?.jList{
                                    if productSearchval.count != 0{
                                        self.arraySearchProductJlist = productSearchval
                                        let searchQueue = DispatchQueue(label: "com.myApp.searchmyQueue")

                                        searchQueue.sync {

                                                shotBookAddRemove(completion: searchShotBook_completion )
                                                wishListAddRemove(completion: serachWishList_completion)

                                            }
                                        print(shotBookIntArray)
                                        print(wishListIntArray)
                                        self.resultCollView.reloadData()
                                        errorMesg = false

                                        completion()

                                    }else{
                                        errorMesg = true

                                        arraySearchProductJlist?.removeAll()
                                        self.resultCollView.reloadData()
                                        completion()
                                    }
                                }
                            }
                            
                        }else{
                            errorMesg = true
                            arraySearchProductJlist?.removeAll()
                            self.resultCollView.reloadData()
                            completion()

                        }
                        
                        
                    }else{
                        errorMesg = true
                        arraySearchProductJlist?.removeAll()
                        self.resultCollView.reloadData()
                        completion()

                        
                    }
                    hideActivityIndicator(self.view)
                    
                }, failureBlock: {[unowned self] (errorMesssage) in
                    errorMesg = true
                    arraySearchProductJlist?.removeAll()
                    hideActivityIndicator(self.view)
                    self.resultCollView.reloadData()

                    completion()

                })
                
            }
    //MARK: - Add Remove shotbook
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
                if self.addtoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    print(self.shotBookIntArray)
                    print(shotBookIndexInt)
                    self.shotBookIntArray[shotBookIndexInt] = 1
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    print(self.shotBookIntArray)
                    self.resultCollView.reloadItems(at: [sbIndexPath])

                    multiSearchSB_completion(completion: multiSearchSB_completion)


                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    print(self.shotBookIntArray)
                    print(shotBookIndexInt)
                    self.shotBookIntArray[shotBookIndexInt] = 1
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    print(sbIndexPath)
                    print(self.shotBookIntArray)
                    self.resultCollView.reloadItems(at: [sbIndexPath])

                    multiSearchSB_completion(completion: multiSearchSB_completion)



                    
                    
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
                //hideActivityIndicator(self.view)
                
                if self.removetoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    self.shotBookIntArray[shotBookIndexInt] = 0
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    self.resultCollView.reloadItems(at: [sbIndexPath])
                  //  sbItemCode()
                    multiSearchSB_completion(completion: multiSearchSB_completion)
                  // shortBookCount()
                    
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    
                    self.shotBookIntArray[shotBookIndexInt] = 0
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    self.resultCollView.reloadItems(at: [sbIndexPath])
                    multiSearchSB_completion(completion: multiSearchSB_completion)
                   // shortBookCount()
                    
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            //hideActivityIndicator(self.view)
        })
    }
    
    //MARK: -  Add Remove Wish List
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
                //hideActivityIndicator(self.view)
                if self.addtoWLmodel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    self.wishListIntArray[wishListIndexInt] = 1
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.resultCollView.reloadItems(at: [wbIndexPath])
                    multiSearchWL_completion(completion: multiSearchWL_completion)

                    
                    
                }else {
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    self.wishListIntArray[wishListIndexInt] = 1
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.resultCollView.reloadItems(at: [wbIndexPath])
                    multiSearchWL_completion(completion: multiSearchWL_completion)

                    
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
            self.removeFromWLModel = RemoveFromWLModel(object:dict)
            
            if boolSuccess {
                //hideActivityIndicator(self.view)
                if self.removeFromWLModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromWLModel?.messages?[0] ?? "", view: self.view)
                    self.wishListIntArray[wishListIndexInt] = 0
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    print(wbIndexPath)
                    self.resultCollView.reloadItems(at: [wbIndexPath])

                    multiSearchWL_completion(completion: multiSearchWL_completion)
                  //  watchlistCount()
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromWLModel?.messages?[0] ?? "", view: self.view)
                    self.wishListIntArray[wishListIndexInt] = 0
                    let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                    self.resultCollView.reloadItems(at: [wbIndexPath])

                    multiSearchWL_completion(completion: multiSearchWL_completion)
                   // watchlistCount()
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            //hideActivityIndicator(self.view)
            
        })
        
        
    }
    func productWiseSellerDetails(wishItemCodeStr:String,itemName:String){
    
        print(wishItemCodeStr)
        let productWiseSeller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "proSeller")
        let productWiseSellerParams = ["c_search_term": wishItemCodeStr,
                                       "n_limit": 10,
                                       "n_page": 0] as [String : Any]
        print(productWiseSellerParams)
    
        
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
                    addtoCartVc?.delegate = self
                    addtoCartVc!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    
                    addtoCartVc?.productwiseSellerModel = productWiseSellerModel
                 addtoCartVc?.selectQtyS = selectQty
                 addtoCartVc?.productName = itemName
                    print(addtoCartVc?.bestSchemesTableView.contentSize.height)
                    self.view.addSubview(addtoCartVc!)
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
extension SearchWithListFeatureProductVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}

