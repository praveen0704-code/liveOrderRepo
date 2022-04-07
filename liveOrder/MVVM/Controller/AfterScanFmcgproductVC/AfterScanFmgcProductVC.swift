//
//  AfterScanFmgcProductVC.swift
//  liveOrder
//
//  Created by Data Prime on 07/07/21.
//

import UIKit
import Alamofire
import ImageSlideshow
import LazyImage
import NotificationBannerSwift

class AfterScanFmgcProductVC: UIViewController , UIScrollViewDelegate {
   
    @IBOutlet weak var mainWishListButto: UIButton!
    //FIXME: - ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrolloverAllView: UIView!
    @IBOutlet weak var stepSyrpmlLbl: UILabel!
    @IBOutlet weak var mfgByLbl: UILabel!
    @IBOutlet weak var microLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var containsNameLbl: UILabel!
    @IBOutlet weak var hsnLbl: UILabel!
    @IBOutlet weak var hsnNumberLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var packsizeLbl: UILabel!
    @IBOutlet weak var selectedsizeLbl: UILabel!
    @IBOutlet weak var selectedSizeTextLbl: UILabel!
    @IBOutlet weak var mlBtnOne: UIButton!
    @IBOutlet weak var mlBtnTwo: UIButton!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var sponserlbl: UILabel!
    @IBOutlet weak var sellerTxtLbl: UILabel!
    @IBOutlet weak var sellerTableView: UITableView!
    @IBOutlet weak var aboutDrugLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTxtLbl: UILabel!
    @IBOutlet weak var quickLinksLbl: UILabel!
    @IBOutlet weak var usageBtn: UIButton!
    @IBOutlet weak var sideEffectBtn: UIButton!
    @IBOutlet weak var contraIndicationBtn: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var usageLbl: UILabel!
    
    @IBOutlet weak var usagedescriptionLbl: UILabel!
    @IBOutlet weak var sideEffectTxtLbl: UILabel!
    @IBOutlet weak var sideEffectDesTxtLbl: UILabel!
    @IBOutlet weak var contraIndicationLbl: UILabel!
    @IBOutlet weak var contraIndicationDesTxtLbl: UILabel!
    @IBOutlet weak var lineTwoLbl: UILabel!
    @IBOutlet weak var recentlyViewedLbl: UILabel!
    @IBOutlet weak var topnavigatorView: UIView!

    @IBOutlet weak var subProductTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollimgView: UIView!
    @IBOutlet weak var scrollImg: UIImageView!
    @IBOutlet weak var pageCon: UIPageControl!
    @IBOutlet weak var imgScrollView: UIScrollView!
    @IBOutlet weak var alternativeCollView: UICollectionView!
    @IBOutlet weak var notesLbl: UILabel!
    
    @IBOutlet weak var wishListView: UIView!
    @IBOutlet weak var shotBookView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var cartBtn: UIButton!
    
   
    
    @IBOutlet weak var wishListbtn: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var descreptionTxtView: UITextView!
    @IBOutlet weak var usagedesTxtView: UITextView!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var sideeffectTxtView: UITextView!
    @IBOutlet weak var contraTxtView: UITextView!
    
    @IBOutlet weak var alternateViewAllButton: UIButton!
    @IBOutlet weak var recentluViewedTbHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fillerSellerBtn: UIButton!
    @IBOutlet weak var slideImgeView: ImageSlideshow!
    @IBOutlet weak var itemshortBookBtn: UIButton!
    @IBOutlet weak var itemWishlistBtn: UIButton!
    
    @IBOutlet weak var desColorLbl: UILabel!
    
    @IBOutlet weak var dotViewsideEffect: UIView!
    @IBOutlet weak var dotViewContra: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var filtterBtn: UIButton!
    
    var sbItemCodeModel:SBItemCodeModel?
    @IBOutlet weak var mainShotBookButton: UIButton!
    var wlItemCodeModel:WLItemCodeModel?
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var selectQty = [String]()
    var addInt = [Int]()

    var addItemModel : AddItemModel?



    
    var selledQtyArray = [String]()

  
    var pdpListModel : PDPModel?
    
    var productwiseModel : ProductVsSellerDetailsModel?
    var itemByMolModel : MoleculeCodeModel?
    
    var productIDStr : String?
    var productNameStr : String?
    var back = 0
    
    
    var filterNum : Int?
    var text : String?


    var tableViewHeight: CGFloat = 0  // Dynamically calcualted height of TableView.
    var moleculesCode:String?
    var moleculesName:String?

    let addToCartView = UINib(nibName: "AddToCartView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    
    let SetPriorityView = UINib(nibName: "SetPriorityFiltterView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? SetPriorityFiltterView
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    
    var removeFromWLModel : RemoveFromWLModel?
    var addtoWLmodel : AWBaseClass?
    
    var addtoSBModel : AddToSBModel?
    var removetoSBModel : RemoveFromSBModel?
    var isAddToCartInt:Int?
    var isAlterativeInt:Int?
    //FIXME: - ShotBook WishList Check Array
    var shotBookIntArray = [Int]()
    var wishListIntArray = [Int]()
    //FIXME: - ShotBook WishList Cell Index
    var shotBookIndexInt = Int()
    var wishListIndexInt = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        imgeShow()
        print(productIDStr)
        isAddToCartInt = 0
        pdpApiCall(pdpItemCodeStr: productIDStr ?? "")
        
      
        mlBtnOne.isHidden = true
        mlBtnTwo.isHidden = true
        
   
    }
    
    func imgeShow(){
        slideImgeView.setImageInputs([
            ImageSource(image: UIImage(named: "injectable")!),
          ImageSource(image: UIImage(named: "injectable")!),
            ImageSource(image: UIImage(named: "injectable")!)
        ])

        self.slideImgeView.contentScaleMode = .scaleAspectFit
        slideImgeView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .left(padding: 50), vertical: .under)
        
         
    }
    func setup(){
        
     
        lineTwoLbl.drawDottedLine(start: CGPoint(x: lineTwoLbl.bounds.minX, y: lineTwoLbl.bounds.minY), end: CGPoint(x: lineTwoLbl.frame.maxX, y: lineTwoLbl.bounds.minY), view: lineTwoLbl)
       
        dotViewsideEffect.drawDottedLine(start: CGPoint(x: dotViewsideEffect.bounds.minX, y: dotViewsideEffect.bounds.minY), end: CGPoint(x: dotViewsideEffect.frame.maxX, y: dotViewsideEffect.bounds.minY), view: dotViewsideEffect)
        dotViewContra.drawDottedLine(start: CGPoint(x: dotViewContra.bounds.minX, y: dotViewContra.bounds.minY), end: CGPoint(x: dotViewContra.frame.maxX, y: dotViewContra.bounds.minY), view: dotViewContra)
        
        itemshortBookBtn.layer.cornerRadius = itemshortBookBtn.frame.height / 2
        itemWishlistBtn.layer.cornerRadius = itemWishlistBtn.frame.height / 2
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .leftToRight)
        //topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        desColorLbl.clipsToBounds = true
        desColorLbl.layer.cornerRadius = 10
        desColorLbl.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        desColorLbl.applyGradient(colours: [UIColor(hexString: "#674cf3"),UIColor(hexString:"#f9f5ff")])
        self.navigationController?.isNavigationBarHidden = true
      
        
        sellerTableView.delegate = self
        sellerTableView.dataSource = self
        alternativeCollView.delegate = self
        alternativeCollView.dataSource = self
        

        sellerTableView.register(UINib(nibName: AfterScanFmcgTableViewCell, bundle: nil), forCellReuseIdentifier: AfterScanFmcgTableViewCell)
        alternativeCollView.register(UINib(nibName: "AlternatesCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"AlternatesCollCell")
        //itemshortBookBtn.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)

        
        if #available(iOS 13.0, *) {
            self.shotBookView.dropShadowPosition(heightInt: 5, colorName: .systemGray5)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.wishListView.dropShadowPosition(heightInt: 5, colorName: .systemGray5)
        } else {
            // Fallback on earlier versions
        }
    }
    @objc func buttonTapped(sender : UIButton) {
                    //Write button action here
                }
   
   

    //MARK: - Button Action
    @IBAction func filtterBtnAct(_ sender: Any) {
        SetPriorityView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
       
               self.view.addSubview(SetPriorityView!)

    }
    
    @IBAction func shareBtnAct(_ sender: Any) {
    }
    
    @IBAction func itemWishListBtnAct(_ sender: UIButton) {
        isAlterativeInt = 0

            sender.isSelected = !sender.isSelected
            if sender.isSelected{
                
                removeWishList(itemCodeStr: productIDStr ?? "" , itemNameStr: productNameStr ?? "")
                sender.isSelected = false

                
            }else{
                
                addToWishList(itemCodeStr:productIDStr ?? "" , itemNameStr: productNameStr ?? "")
                sender.isSelected = true

            }
    }
    @IBAction func itemShortBookBtnAct(_ sender: UIButton) {
        isAlterativeInt = 0

        sender.isSelected = !sender.isSelected

        if sender.isSelected{
            
            removeShotbook(itemCodeStr:productIDStr ?? "", itemNameStr: productNameStr ?? "")
            sender.isSelected = false

            
        }else{

            addToShotook(itemCodeStr:productIDStr ?? "" ,itemNameStr: productNameStr ?? "")
            sender.isSelected = true

        }
    }
    
    
    @IBAction func fillterSellerBtnAct(_ sender: Any) {
        addToCartView?.delegate = self
        addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
       
               self.view.addSubview(addToCartView!)
    }
    
    @IBAction func alternateViewAllAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlpVC")
        as! PlpVC
        vc.viewAllInt = 7
        vc.sellerName = moleculesName
        vc.mfcCode = moleculesCode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        if back == 0 {
            let loHomeTabVC = self.storyboard?.instantiateViewController(withIdentifier: "LoHomeViewController")
            as! LoHomeViewController
            self.navigationController?.pushViewController(loHomeTabVC, animated: true)
        }else if back == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LcMainSearchVC")
            as! LcMainSearchVC
            vc.backPrevious = true
            vc.text = text
            vc.indexfil = filterNum
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlpVC")
            as! PlpVC
            vc.viewAllInt = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    

    @IBAction func searchAction(_ sender: Any) {
    }
    
   
    @IBAction func mlBtnTwoAct(_ sender: Any) {
        mlBtnOne.backgroundColor = .white
        mlBtnTwo.backgroundColor = UIColor(hexString: "2ec4b6", alpha: 0.20)
    }
    @IBAction func mlBtnOneAct(_ sender: Any) {
        mlBtnTwo.backgroundColor = .white
        mlBtnOne.backgroundColor = UIColor(hexString: "2ec4b6", alpha: 0.20)
    }
    @IBAction func searchBtnAct(_ sender: Any) {
    }

    @IBAction func bactBtnAct(_ sender: Any) {
        let loHome = self.storyboard?.instantiateViewController(withIdentifier: "LoHomeViewController") as! LoHomeViewController
        self.navigationController?.pushViewController(loHome, animated: true)
    }
    
    @IBAction func cartBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func mainWishListAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WatchListVC") as? WatchListVC
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func mainShotookAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShortBookVC") as? ShortBookVC
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension AfterScanFmgcProductVC : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productwiseModel?.payloadJson?.data?.jList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: AfterScanFmcgTableViewCell, for: indexPath) as! AfterScanFmcgTbleCell
        
            cell.pharmaNameLbl.text = productwiseModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName
        
            cell.rateLbl.text = "Rate" + "\(productwiseModel?.payloadJson?.data?.jList?[indexPath.row].nMrp ?? 0.0)"
            cell.schemeLbl.text = "Scheme" + "\(productwiseModel?.payloadJson?.data?.jList?[indexPath.row].cSchemes ?? "")"
            cell.numberTextField.text = self.selledQtyArray[indexPath.row]
        cell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)

            cell.addtoCardBtn.tag = indexPath.row
        
        let checkInt = addInt[indexPath.row]
        if checkInt == 1{
            cell.addtoCardBtn.backgroundColor = UIColor(hexString: "272727", alpha: 0.50)
            cell.addtoCardBtn.tintColor = UIColor(hexString: "272727", alpha: 0.50)
            cell.addtoCardBtn.setTitle("Added to Cart", for: .normal)
        }else{
            cell.addtoCardBtn.backgroundColor = UIColor(hexString: "00d3b4")
            cell.addtoCardBtn.tintColor = UIColor(hexString: "00d3b4")
            cell.addtoCardBtn.titleLabel?.text = "Add to Cart"
        }
        
        

            cell.numberTextField.didSelect{(selectedText , index ,id) in
                self.selledQtyArray[indexPath.row] = selectedText
                self.sellerTableView.reloadData()
                        }
        
        return cell
        }
       
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sellerTableView{
            return tableView.estimatedRowHeight

        }else{
            
            return 100.0

        }
    }
    
    //MARK: - Add to Cart Action
    @objc func addToCartAction(sender:UIButton){
        let indexPath = IndexPath(row:sender.tag, section: 0)

        if let cell = self.sellerTableView.cellForRow(at: indexPath) as? AfterScanFmcgTbleCell {

        if cell.numberTextField.text == ""{
            let banner = NotificationBanner(title: "Message", subtitle: "Please enter Quantity", style: .info)
            banner.showToast(message: "Please enter Quantity" , view: self.view)
        }else{
                self.addToCart(selectedIndex:sender.tag)

                
            
        }
    }
        
    }

    
    
}

extension AfterScanFmgcProductVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemByMolModel?.payloadJson?.data?.jList?.count ?? 0
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let alterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlternatesCollCell", for: indexPath) as! AlternatesCollCell
        alterCell.redBtn.isHidden = true
        alterCell.gstLbl.isHidden = true
        alterCell.layer.cornerRadius = 5
        
        alterCell.productNameLbl.text = itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].cItemName ?? ""
        alterCell.packSizeLbl.text = "Pack Size: \(itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].cPackName ?? "")"
        alterCell.mrpLbl.text = "MRP ₹ \(itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].nMrp ?? 0)"
        alterCell.containsresultLbl.text = " \(itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].cContainName ?? "")"
        alterCell.addtoCartbtn.addTarget(self, action: #selector(pdpAddToCartAction), for: .touchUpInside)
        alterCell.wishListbtn.addTarget(self, action: #selector(awishListAction), for: .touchUpInside)
        alterCell.shortBookBtn.addTarget(self, action: #selector(ashortBookAction), for: .touchUpInside)
        alterCell.wishListbtn.tag = indexPath.row
        alterCell.shortBookBtn.tag = indexPath.row
        if wishListIntArray.count != 0{
        if wishListIntArray[indexPath.row] == 1{
            alterCell.wishListbtn.setImage(UIImage(named: "wishlist_1"), for: .normal)

        }else{
            alterCell.wishListbtn.setImage(UIImage(named: "wishlist"), for: .normal)


        }
        }
        if shotBookIntArray.count != 0{
            if shotBookIntArray[indexPath.row] == 1 {
                alterCell.shortBookBtn.setImage(UIImage(named: "shortbook-2"), for: .normal)


            }else{
                alterCell.shortBookBtn.setImage(UIImage(named: "shortbook"), for: .normal)


            }
        }

        return alterCell
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize{
//        
//        return CGSize(width: 159, height: 260)
//        
//        
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let afterScamProductVc = self.storyboard?.instantiateViewController(withIdentifier: "AfterScanFmgcProductVC")
        as! AfterScanFmgcProductVC
        
        let Str = itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode
        print(Str)
        afterScamProductVc.productIDStr = itemByMolModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode ?? "no Value"
        self.navigationController?.pushViewController(afterScamProductVc, animated: true)
    }
    
    @objc func pdpAddToCartAction(sender:UIButton){
        //print(topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode)
        productWiseSellerDetails(wishItemCodeStr:itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "",itemName: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
        
        
    }
   
}
extension AfterScanFmgcProductVC: addcartDelegate{
   
    
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
        
        
    }
    
   
    
    
    
    
}

extension AfterScanFmgcProductVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    
    func pdpApiCall(pdpItemCodeStr:String){
        
        let pdp:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "pdp")
        let pdpParams = ["c_item_code":pdpItemCodeStr]
        print(pdpParams)
//        let pdpHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"165539066092c1fd",
//                                    "Content-Type":"application/json",
//                                        ]

                let pdpHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        pdp.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PDP_URL, type: .post, userData: pdpParams, apiHeader: pdpHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.pdpListModel = PDPModel(object:dict)
            if boolSuccess {
               
                if self.pdpListModel?.appStatusCode == 0{
                    self.sbItemCode(completion: sbItemCode_completion)
                    self.wlItemCode(completion: sbItemCode_completion)
                    self.itemByMolModel = MoleculeCodeModel(object:self.pdpListModel?.payloadJson?.data?.jMolecules)
                    
                    stepSyrpmlLbl.text = pdpListModel?.payloadJson?.data?.cItemName
                    microLbl.text  = pdpListModel?.payloadJson?.data?.cMfgName
                    containsNameLbl.text = pdpListModel?.payloadJson?.data?.cContentName
                    hsnNumberLbl.text = pdpListModel?.payloadJson?.data?.cHsnCode
                    mrpLbl.text = "MRP  ₹\(pdpListModel?.payloadJson?.data?.nMaxMrp ?? 0)"
                    gstLbl.text = "GST Rate: \(pdpListModel?.payloadJson?.data?.cGst ?? "")%"
                    packsizeLbl.text = "Packaging: \(pdpListModel?.payloadJson?.data?.cPackName ?? "")"
                    self.selledQtyArray.removeAll()

                    productWiseSellerDetails(wishItemCodeStr: productIDStr ?? "")//"498283")//

                    if self.pdpListModel?.payloadJson?.data?.jMolecules?.isEmpty == false {
                        descreptionTxtView.text = "\(pdpListModel?.payloadJson?.data?.jMolecules?[0].cDescription ?? "")"
                        usagedesTxtView.text = "\(pdpListModel?.payloadJson?.data?.jMolecules?[0].cUsage ?? "")"
                        
                        notesTxtView.text = "Notes: \(pdpListModel?.payloadJson?.data?.jMolecules?[0].cNote ?? "")"
                        sideeffectTxtView.text = "\(pdpListModel?.payloadJson?.data?.jMolecules?[0].cSideEffect ?? "")"
                        contraTxtView.text = "\(pdpListModel?.payloadJson?.data?.jMolecules?[0].cContraIndications ?? "")"
                        moleculesCode = pdpListModel?.payloadJson?.data?.jMolecules?[0].cMoleculeCode
                        moleculesName = pdpListModel?.payloadJson?.data?.jMolecules?[0].cMoleculeName
                        itemMoleculesCode(moliCode: moleculesCode ?? "")
                    }else{
                        descreptionTxtView.text = "No Info "
                        usagedesTxtView.text = "No Info "
                        notesTxtView.text = "Notes:" + "No Info "
                        sideeffectTxtView.text = "No Info "
                        contraTxtView.text = "No Info "
                    }
                    
                    
                }else{
                    
                    
                    
                    
                    
                    
                }
                
               

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           

        })
        
        
        }
    func itemMoleculesCode(moliCode:String){
        
        
        let pdp:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopMfg")
        let pdpParams = ["c_search_term": moliCode,
                               "n_limit": 20,
                         "n_page": 0] as [String : Any]
        print(pdpParams)
//        let pdpHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"165539066092c1fd",
//                                    "Content-Type":"application/json",
//                                        ]

                let pdpHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        pdp.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_MOL_CODE_URL, type: .post, userData: pdpParams, apiHeader: pdpHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.itemByMolModel = MoleculeCodeModel(object:dict)
            print(dict)
            if boolSuccess {
               
                if self.itemByMolModel?.appStatusCode == 0{
                    self.sbItemCode(completion: sbItemCode_completion)
                    self.wlItemCode(completion: sbItemCode_completion)
                    isAlterativeInt = 1
                    recentlyViewedLbl.text = "Alternates Of \(moleculesName ?? "")"
                    
                    alternativeCollView.reloadData()
                   
                    
                }else{
                    isAlterativeInt = 0
                }
                
               

            }else{
                        
                isAlterativeInt = 0
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            isAlterativeInt = 0

        })
        
    }
    func productWiseSellerDetails(wishItemCodeStr:String){
        print(wishItemCodeStr)
        let productWiseSeller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "proSeller")
        let productWiseSellerParams =  ["c_search_term": wishItemCodeStr,
                                        "n_limit": 10,
                                        "n_page": 0] as [String : Any]
//        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]

                let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        productWiseSeller.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PRODUCT_WISE_SELLER_DETAILS_URL, type: .post, userData: productWiseSellerParams, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.productwiseModel = ProductVsSellerDetailsModel(object:dict)
            print(dict)
            if boolSuccess {
               
                if self.productwiseModel?.appStatusCode == 0{
                    if isAddToCartInt == 0{
                        for (_,ele) in (productwiseModel?.payloadJson?.data?.jList)!.enumerated() {
                            self.selledQtyArray.append("\(ele.nQty ?? 1)")
                            self.addInt.append(0)

                            
                        }
                    }
                    
                    
                    self.sellerTxtLbl.text = "+ \(productwiseModel?.payloadJson?.data?.jList?.count ?? 0 - 3) Sellers"
                    
                    self.sellerTableView.reloadData()
                    print(self.sellerTableView.contentSize.height)
                
                }else{
                    
                    self.subProductTableViewHeightConstraint.constant = 0.0
                    self.sellerTableView.layoutSubviews()
                    self.sellerTxtLbl.text = ""

                }
                
               

            }else{
                        
                self.subProductTableViewHeightConstraint.constant = 0.0
                self.sellerTableView.layoutSubviews()
                self.sellerTxtLbl.text = ""

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.subProductTableViewHeightConstraint.constant = 0.0
            self.sellerTableView.layoutSubviews()
            self.sellerTxtLbl.text = ""


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
                 hideActivityIndicator(self.view)
                    for (_,ele) in (productWiseSellerModel?.payloadJson?.data?.jList)!.enumerated() {
                        self.selectQty.append("1")
                    }
                    
                    print(self.selectQty)
                    

                 
                 if productWiseSellerModel?.payloadJson?.data?.jList?.count == 0{
                     productWiseSellerModel?.payloadJson?.data?.jList?.removeAll()

                 }else{
                     addToCartView?.delegate = self
                     addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                     addToCartView?.productwiseSellerModel = productWiseSellerModel
                     addToCartView?.selectQtyS = selectQty
                     addToCartView?.productName = itemName
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

        })
        
        
    }
    
    
    func addToCart(selectedIndex:Int){
        isAddToCartInt = 1
        print(selectedIndex)
        let indexPathh = IndexPath(row:selectedIndex, section: 0)

        
        
        let addToCart:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToCart")
   
        let addToCartParms = ["c_item_code":"\(pdpListModel?.payloadJson?.data?.cItemCode ?? "")",
                              "c_mobile_no":UserDefaults.standard.value(forKey: usernameConstantStr) ?? "",
                              "c_seller_code":"\(productwiseModel?.payloadJson?.data?.jList?[selectedIndex].cSellerCode ?? "")",
                              "c_seller_item_code":"\(productwiseModel?.payloadJson?.data?.jList?[selectedIndex].cSellerCode ?? "")",
                              "c_seller_name":productwiseModel?.payloadJson?.data?.jList?[selectedIndex].cSellerName ?? "",
                              "n_mrp":productwiseModel?.payloadJson?.data?.jList?[selectedIndex].nMrp ?? 0.0,
                              "n_qty":self.selledQtyArray[selectedIndex],
                              "n_seller_rate": productwiseModel?.payloadJson?.data?.jList?[selectedIndex].nSellerRate ?? 00
        ] as [String : Any]
        print(addToCartParms)
        


                let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        addToCart.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_CART_URL, type: .post, userData: addToCartParms, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.productwiseModel = ProductVsSellerDetailsModel(object:dict)
            print(dict)
            if boolSuccess {
                
                if self.productwiseModel?.appStatusCode == 0{
                    print(addInt[selectedIndex])
                    addInt[selectedIndex] = 1
                    print(addInt)
                }else{
                    print(addInt[selectedIndex])
                    addInt[selectedIndex] = 0
                    print(addInt)
                }
                print(indexPathh)
                productWiseSellerDetails(wishItemCodeStr: productIDStr ?? "")//"498283")//


            }else{
                print(addInt[selectedIndex])
                addInt[selectedIndex] = 0
                print(addInt)
                productWiseSellerDetails(wishItemCodeStr: productIDStr ?? "")//"498283")//

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
            print(addInt[selectedIndex])
            addInt[selectedIndex] = 0
            print(addInt)
            productWiseSellerDetails(wishItemCodeStr: productIDStr ?? "")//"498283")//

        })
        
        
        }
    
    //FIXME: - ADD REMOVE SHO BOOK ADS WISH LIST
    
    func removeWishList(itemCodeStr:String,itemNameStr:String){

        showActivityIndicator(self.view)
        let WishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        let WishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr) ?? ""] as [String:Any]
        print(WishListParams)
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
                
                    
                    wlItemCode(completion: wlItemCode_completion)
                  //  watchlistCount()
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromWLModel?.messages?[0] ?? "", view: self.view)
                
                    
                    wlItemCode(completion: wlItemCode_completion)
                   // watchlistCount()
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            //hideActivityIndicator(self.view)
            
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
                //hideActivityIndicator(self.view)
                if self.addtoWLmodel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                  
                    wlItemCode(completion: wlItemCode_completion)
                    
                    
                    
                }else {
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                  
                    
                    wlItemCode(completion: wlItemCode_completion)

                    
                }
                
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
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
        print(itemCodeParams)
        
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
                   
                    sbItemCode(completion: sbItemCode_completion)
    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                   
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
        print(removeParams)
        
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
                   
                    sbItemCode(completion: sbItemCode_completion)
                  // shortBookCount()
                    
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    
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
                    let queue = DispatchQueue(label: "com.myApp.myQueu")

                        queue.sync {
                            shotBookAddRemove(completion: shotBook_completion )

                            wishListAddRemove(completion: wishList_completion)
                        }
                    if isAlterativeInt == 1{
                        self.alternativeCollView.reloadData()
                    }
                    hideActivityIndicator(self.view)
                    completion()
                }else if self.wlItemCodeModel?.appStatusCode == 5{
                    self.itemWishlistBtn.setBackgroundImage(UIImage(named: "wishlist"), for: .normal)
                    self.itemWishlistBtn.isSelected = true
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
                    
                    let queue = DispatchQueue(label: "com.myApp.myQueu")

                        queue.sync {

                            shotBookAddRemove(completion: shotBook_completion )

                            wishListAddRemove(completion: wishList_completion)                        }
                        
                    
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
                    if isAlterativeInt == 1{
                        self.alternativeCollView.reloadData()
                    }
                    hideActivityIndicator(self.view)
                    completion()

                    
                   
                }else if self.sbItemCodeModel?.appStatusCode == 5 {
                    self.itemshortBookBtn.setBackgroundImage(UIImage(named: "shortbook"), for: .normal)
                    self.itemshortBookBtn.isSelected = true
                    
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
extension AfterScanFmgcProductVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    //MARK: - Completion Shotbook Wish List
        func shotBookAddRemove(completion: @escaping SWCOMPLETION){
            if isAlterativeInt == 1{
                for (inx,ele) in (self.itemByMolModel?.payloadJson?.data?.jList)!.enumerated(){
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
            }else{
                if self.sbItemCodeModel?.payloadJson?.data != nil{
                    for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
                        if productIDStr == sele.cItemCode{
                            self.itemshortBookBtn.setBackgroundImage(UIImage(named: "shortbook-2"), for: .normal)
                            self.itemshortBookBtn.isSelected = false
                        }else{
                            self.itemshortBookBtn.setBackgroundImage(UIImage(named: "shortbook"), for: .normal)
                            self.itemshortBookBtn.isSelected = true


                        }
                    }

                }
            
            completion()
            }
              
        }
        func wishListAddRemove(completion: @escaping SWCOMPLETION){
            if isAlterativeInt == 1{
                for (inx,ele) in (self.itemByMolModel?.payloadJson?.data?.jList)!.enumerated(){
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
            completion()
                
            }else{
                if self.wlItemCodeModel?.payloadJson?.data != nil{
                    for (_,wEle) in (self.wlItemCodeModel?.payloadJson?.data)!.enumerated(){
                        if productIDStr == wEle.cItemCode{
                            self.itemWishlistBtn.setBackgroundImage(UIImage(named: "wishlist_1"), for: .normal)
                            self.itemWishlistBtn.isSelected = false
                        }else{
                            self.itemWishlistBtn.setBackgroundImage(UIImage(named: "wishlist"), for: .normal)
                            self.itemWishlistBtn.isSelected = true
                        }
                    }

                }
            completion()
            }
              


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
    
    
    //MARK: - topmost WLISR BTN ACT AND SHORTBOOK BTN ACR
    @objc func awishListAction(sender:UIButton){
print(wishListIntArray)
        self.wishListIndexInt = sender.tag
        if self.wishListIntArray[sender.tag] == 1{
            
            removeWishList(itemCodeStr: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }else{
            addToWishList(itemCodeStr:itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }
    }
    @objc func ashortBookAction(sender:UIButton){

        self.shotBookIndexInt = sender.tag
        if self.shotBookIntArray[sender.tag] == 1{
            removeShotbook(itemCodeStr:itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }else{
            addToShotook(itemCodeStr:itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "" ,itemNameStr: itemByMolModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
            
        }
    }
    

    
}

