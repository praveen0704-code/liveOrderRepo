//
//  PlpVC.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift
import LazyImage
import CCBottomRefreshControl

class PlpVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartbtn: UIButton!
    @IBOutlet weak var shortbookBtn: SSBadgeButton!
    @IBOutlet weak var wishListBtn: SSBadgeButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var mostorderLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var leftImageview: UIImageView!
    @IBOutlet weak var shortLbl: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var fillterLbl: UILabel!
    @IBOutlet weak var centreLineLbl: UILabel!
    @IBOutlet weak var stackBtnView: UIStackView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var fillterBtn: UIButton!
    @IBOutlet weak var fillterAppliedLbl: UILabel!
    @IBOutlet weak var plpCollView: UICollectionView!
    
    let sortoption = UINib(nibName: "SortOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? SortOptionView
    let addToCartView = UINib(nibName: "AddToCartView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    var viewAllInt : Int?
    var back = 0
    var filterNum : Int?
    var text : String?
    
    var newLanchModel : NewLaunchModel?
    var topmostModel : TopMostOrderModel?
    var addToWIshListModel: AWBaseClass?
    var addtoshortBookModel : AddToSBModel?
    var removeFromSBModel : RemoveFromSBModel?
    var removefromWLModel : RemoveFromWLModel?
    var sbCountModel : SBCountModel?
    var wlcountModel: WLCountModel?
    var loader = BlurLoader()
    var nextPageInt = 0
    var itemcode = String()
    var wishlist = String()
    
    lazy var topProductsLazyImage:LazyImage = LazyImage()
    lazy var newLaunchLazyImage:LazyImage = LazyImage()
    lazy var sellerInspiredLazyImage:LazyImage =  LazyImage()
    
    var isNextPageAPICall : Bool = false

    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var itemBySellerCodeModel : ItemBySellerFiltterModel?
    var itemByMfcCodeModel : ItemByMfcCodeModel?
    var itembyMolCodeMOdel : ItemByMolCodeModel?
    var itemByCatMOdel : ItemByCategCodeModel?
    var allProductModel : ItemByCategCodeModel?
    
    var arrayJItems:[NewLaunchJList]?
    var arrayTopJItems:[TopMostOrderJList]?
    var sellerInspiredItems : [ItemBySellerFiltterJList]?
    var shopByMfcItems : [ItemByMfcCodeJList]?
    var moleculeItems : [ItemByMolCodeJList]?
    var categoriesItems : [ItemByCategCodeJList]?
    var addItemModel : AddItemModel?
    var selectQty = [String]()
    var sellerName : String?
    var mfcCode : String?
    var pinCode : String?
    
    var apiQueue = DispatchGroup()
    var shotBookSelectedInndexInt = Int()
    var wishListSelectedInndexInt = Int()
    
    var shortBookCountModel : SBCountModel?
    var watchlistCountModel : WLCountModel?
    var totalCountModl : TotalCountBaseClass?



    
    
    // :- FILTTER APLLY BTN TAPPED
    var availability = "N"
    var brands :[String] = []
    var manufacturers :[String] = []
    var sellers :[String] =  []
    var sort = "Relevance"
    
    var errorMesg = false
    
    //FIXME: - ShotBook WishList Check Array
    var shotBookIntArray = [Int]()
    var wishListIntArray = [Int]()
    //FIXME: - ShotBook WishList Check Int
    var isShotBookInt = 0
    var isWishListInt = 0
    //FIXME: - SBModel
    var sbItemCodeModel:SBItemCodeModel?
    var wlItemCodeModel:WLItemCodeModel?
    //FIXME: - Top Order ShotBook WishList Queue
    typealias SWCOMPLETION = () -> ()

    let shotBook_completion = {
        print("functionOne COMPLETED")
    }

    let wishList_completion = {
        print("functionTwo COMPLETED")
    }



    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.SortOptionView
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellSize = CGSize(width:screenWidth/2 - 22 , height:252)

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            layout.itemSize = cellSize
//            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//            layout.minimumLineSpacing = 1.0
//            layout.minimumInteritemSpacing = 1.0
        plpCollView.setCollectionViewLayout(layout, animated: true)
        let bottomRefreshController = UIRefreshControl()
        
        bottomRefreshController.triggerVerticalOffset = 50
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.attributedTitle = NSMutableAttributedString(string: "Loading...")
        plpCollView.bottomRefreshControl = bottomRefreshController
        setup()
       
        
    }
    func setup(){
        plpCollView.bottomRefreshControl?.beginRefreshing()
        self.sbItemCode()
        self.wlItemCode()
        self.shortBookCount()
        self.watchlistCount()
        if viewAllInt == 1{
            mostorderLbl.text = sellerName
            self.sellerInspiredByCount(urStr: LIVE_ORDER_HOSTURL+SHOPBYMANIFACTURE_COUNT_URL, sellerCode: mfcCode ?? "")
            sellerInspiredPurchase(wishItemCodeStr: mfcCode ?? "")
            
        }else if viewAllInt == 2 {
            mostorderLbl.text = "Top Most Orders"
            topMostOrderCount(urStr:LIVE_ORDER_HOSTURL+TOPMOSTORDER_COUNT_URL , pincode: pinCode ?? "")
            topmostApi(pin: pinCode ?? "")
            
        }else if viewAllInt == 3{
            mostorderLbl.text = "New Launches"
            NewLanchItemApi(pin: pinCode ?? "")
        }else if viewAllInt == 4{
            mostorderLbl.text = sellerName
           shopByMfcCode(wishItemCodeStr: mfcCode ?? "")
            shopByMfcCount(urStr:LIVE_ORDER_HOSTURL+SHOPBYMFC_COUNT_URL, searchStr:mfcCode ?? "" )
        }else if viewAllInt == 5{
            mostorderLbl.text = sellerName
           categoriesList(wishItemCodeStr: mfcCode ?? "")
            categoriesListCount(urStr:LIVE_ORDER_HOSTURL+CATEORIES_COUNT_URL , searchStr: mfcCode ?? "")
        }else if viewAllInt == 6{
            mostorderLbl.text = sellerName
            categoriesAllProductList()
            allProductsCount(urStr:LIVE_ORDER_HOSTURL+CATEORIES_COUNT_URL)

        }else{
            mostorderLbl.text = sellerName
           searchMolCode(wishItemCodeStr: mfcCode ?? "")
        }
        
        self.fillterAppliedLbl.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        fillterAppliedLbl.layer.cornerRadius = self.fillterAppliedLbl.frame.width / 2
        fillterAppliedLbl.clipsToBounds = true
        fillterAppliedLbl.isHidden = true
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //.horizontal
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
        bottomView.backgroundColor = .white
        sortBtn.backgroundColor = .clear
        
        fillterBtn.backgroundColor = .clear
        plpCollView.dataSource = self
        plpCollView.delegate = self
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .topToBottom)
       // topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        plpCollView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier: productlistVariantscelidentifreStr)
       
    }
   
    @IBAction func fillterBtnAct(_ sender: Any) {
        fillterAppliedLbl.isHidden = false
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PLPFiltterVc") as? PLPFiltterVc
        vc?.viewAllInt = viewAllInt
        vc?.sellerName = sellerName
        vc?.mfcCode = mfcCode
        vc?.pin = pinCode
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func sortBtnAct(_ sender: Any) {
        sortoption!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        sortoption?.delegate = self
        self.view.addSubview(sortoption!)
    }
    @IBAction func searchBtnAct(_ sender: Any) {
        
    }
    @IBAction func wishLIstBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WatchListVC") as? WatchListVC
              
              self.navigationController?.navigationBar.isHidden = true
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backBtnAct(_ sender: Any) {
        if back == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LcMainSearchVC") as? LcMainSearchVC
            vc?.backPrevious = true
            vc?.text = text
            vc?.indexfil = filterNum
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    @IBAction func cartBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
               
               self.navigationController?.navigationBar.isHidden = true
               self.navigationController?.pushViewController(vc!, animated: true)

    }
    @IBAction func shortBookBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShortBookVC") as? ShortBookVC
             
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
extension PlpVC : sortDelegate{
    func shortBy(txt: String) {
        print(txt)
        sort = txt
        setup()
    }
    
    
}
extension PlpVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numberOfSec : Int = 0
        if errorMesg == true{
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.tag = 201
            noRecordsErrorView.noHistoryLbl.isHidden = true
            noRecordsErrorView.nothingHereLbl.textColor = UIColor.red
            noRecordsErrorView.nothingHereLbl.text = "Oops.!products not found."
            plpCollView.backgroundView = noRecordsErrorView
            plpCollView.isScrollEnabled = false
            numberOfSec = 0
        }else{
            collectionView.backgroundView = nil
            numberOfSec = 1
        }
        return numberOfSec
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if viewAllInt == 1{
             return sellerInspiredItems?.count ?? 0
        }else if viewAllInt == 2 {
            return arrayTopJItems?.count ?? 0
        }else if viewAllInt == 3 {
            return arrayJItems?.count ?? 0
        }else if viewAllInt == 4{
            return shopByMfcItems?.count ?? 0
        }else if viewAllInt == 5{
            return categoriesItems?.count ?? 0
        }else if viewAllInt == 6{
            return categoriesItems?.count ?? 0
        }else{
            return moleculeItems?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let newLaunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
        newLaunchCell.overAllView.layer.cornerRadius = 5
        if viewAllInt == 1 {
            newLaunchCell.overAllView.layer.cornerRadius = 8
//            sellerInspiredLazyImage.showWithSpinner(imageView: newLaunchCell.productImgView, url: sellerInspiredItems?[indexPath.row].acThumbnailImages?[0], defaultImage: "injectable")
//
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = sellerInspiredItems?[indexPath.row].cContains
            newLaunchCell.mrpansLbl.text = "\(sellerInspiredItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = sellerInspiredItems?[indexPath.row].cItemName
            newLaunchCell.packSizeMlLbl.text = sellerInspiredItems?[indexPath.row].cPackName
        
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
          
        //FIXME: - Add images
            if wishListIntArray[indexPath.row] == 1{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

        }else{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

        }
            if shotBookIntArray[indexPath.row] == 1{
            newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")
            }else{
                newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")
            }
            return newLaunchCell

        }else if viewAllInt == 2 {
            newLaunchCell.overAllView.layer.cornerRadius = 8
            
            if arrayTopJItems?[indexPath.row].cPackTypeName == "BAR" {
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"injectable")
                
            }else if arrayTopJItems?[indexPath.row].cPackTypeName == "STRIPS"{
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"tablet")
                
            }else if arrayTopJItems?[indexPath.row].cPackTypeName == "TUBE"{
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"oral sus")
                
            }else if arrayTopJItems?[indexPath.row].cPackTypeName == "DROPS"{
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"injectable")
                
            }else if arrayTopJItems?[indexPath.row].cPackTypeName == "INHALER"{
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"drops")
                
//            }else if arrayTopJItems?[indexPath.row].cPackTypeName == "BOTTLE"{

            }
            else {
                topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: arrayTopJItems?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"injectable")
                
            }
            
            newLaunchCell.madicineNameLbl.text = arrayTopJItems?[indexPath.row].cContains
            newLaunchCell.mrpansLbl.text = "\(arrayTopJItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = arrayTopJItems?[indexPath.row].cItemName
            newLaunchCell.packSizeMlLbl.text = arrayTopJItems?[indexPath.row].cPackName
            if arrayTopJItems?[indexPath.row].cScheme == ""{
                 newLaunchCell.offerBtn.isHidden = true

            }else{
                newLaunchCell.offerBtn.isHidden = false

            }
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        //FIXME: - Add images
                if wishListIntArray.count != 0 {
                if self.wishListIntArray[indexPath.row] == 1{
                    
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

            }else{
                
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

            }

            }
            if shotBookIntArray.count != 0{
                if shotBookIntArray[indexPath.row] == 1{
                newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")

            }else{
               newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")

            }
            }
           
            
            return newLaunchCell
        }else if viewAllInt == 3 {
            newLaunchCell.overAllView.layer.cornerRadius = 8
//            newLaunchLazyImage.showWithSpinner(imageView: newLaunchCell.productImgView, url: arrayJItems?[indexPath.row].acThumbnailImages?[indexPath.row].cThumbnailImage,defaultImage: "injectable")
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = arrayJItems?[indexPath.row].cItemName
            newLaunchCell.mrpansLbl.text = "\(arrayJItems?[indexPath.row].nMrp)"
            newLaunchCell.productMgLbl.text = arrayJItems?[indexPath.row].cItemName
            newLaunchCell.packSizeMlLbl.text = arrayJItems?[indexPath.row].cPackName
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        //FIXME: - Add images
            if wishListIntArray.count != 0 {
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

        }else{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

        }
            if shotBookIntArray[indexPath.row] == 1{
            newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")

        }else{
           newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")

        }
            
            return newLaunchCell
            }
        else if viewAllInt == 4{
            newLaunchCell.overAllView.layer.cornerRadius = 8
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = shopByMfcItems?[indexPath.row].cContains
            newLaunchCell.mrpansLbl.text = "\(shopByMfcItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = shopByMfcItems?[indexPath.row].cItemName
            newLaunchCell.packSizeMlLbl.text = shopByMfcItems?[indexPath.row].cPackName
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        //FIXME: - Add images
            if wishListIntArray[indexPath.row] == 1{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

        }else{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

        }
            if shotBookIntArray[indexPath.row] == 1{
            newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")
            }else{
                newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")
            }
            return newLaunchCell

        }else if viewAllInt == 5{
            newLaunchCell.overAllView.layer.cornerRadius = 8
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = categoriesItems?[indexPath.row].cItemName
            newLaunchCell.mrpansLbl.text = "\(categoriesItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = categoriesItems?[indexPath.row].cContains
            newLaunchCell.packSizeMlLbl.text = categoriesItems?[indexPath.row].cPackName
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
            if categoriesItems?[indexPath.row].cScheme == ""{
                newLaunchCell.offerBtn.isHidden = true
            }else{
                newLaunchCell.offerBtn.isHidden = false

            }
        //FIXME: - Add images
            if wishListIntArray[indexPath.row] == 1{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

        }else{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

        }
            if shotBookIntArray[indexPath.row] == 1{
            newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")
            }else{
                newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")
            }
            return newLaunchCell

        }else if viewAllInt == 6{
            newLaunchCell.overAllView.layer.cornerRadius = 8
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = categoriesItems?[indexPath.row].cItemName
            newLaunchCell.mrpansLbl.text = "\(categoriesItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = categoriesItems?[indexPath.row].cContains
            newLaunchCell.packSizeMlLbl.text = categoriesItems?[indexPath.row].cPackName
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        //FIXME: - Add images
            if wishListIntArray[indexPath.row] == 1{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

        }else{
            newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

        }
            if shotBookIntArray[indexPath.row] == 1{
            newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")
            }else{
                newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")
            }
            return newLaunchCell

        }else{
            newLaunchCell.overAllView.layer.cornerRadius = 8
            topProductsLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: moleculeItems?[indexPath.row].cWebImgLink, defaultImage:"injectable")
            newLaunchCell.madicineNameLbl.text = moleculeItems?[indexPath.row].cItemName
            newLaunchCell.mrpansLbl.text = "\(moleculeItems?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = moleculeItems?[indexPath.row].cContains
            newLaunchCell.packSizeMlLbl.text = moleculeItems?[indexPath.row].cPackName
            newLaunchCell.offerBtn.isHidden = true
        //FIXME: - Actions and tag
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        //FIXME: - Add images
            
                if self.wishListIntArray[indexPath.row] == 1{
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")
            }else{
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist")
            }
                if shotBookIntArray.count != 0{
                    if shotBookIntArray[indexPath.row] == 1{
                    newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")

                }else{
                   newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")

                }
                }
            
            return newLaunchCell
        }
           
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  11
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (plpCollView.cellForItem(at: indexPath)as? ProductsListofvariantsaftersearchCollCell?) != nil {
            
            if viewAllInt == 1{
                
            }else if viewAllInt == 2{
                itemcode = arrayTopJItems?[indexPath.row].cItemCode ?? ""
                print(itemcode)
            }else if viewAllInt == 3 {
                itemcode = arrayJItems?[indexPath.row].cItemCode ?? ""
                print(itemcode)
            }else if viewAllInt == 4 {
                itemcode = shopByMfcItems?[indexPath.row].cItemCode ?? ""
                print(itemcode)
            }else if viewAllInt == 5 {
                itemcode = categoriesItems?[indexPath.row].cItemCode ?? ""
                print(itemcode)
            }else if viewAllInt == 6 {
                itemcode = categoriesItems?[indexPath.row].cItemCode ?? ""
                print(itemcode)
            }
            else{
                itemcode = moleculeItems?[indexPath.row].cItemCode ?? ""
                
            }
            
           
            }
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AfterScanFmgcProductVC") as? AfterScanFmgcProductVC
        vc?.back = 3
        vc?.productIDStr = itemcode
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)

        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
//    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
           // print(newLanchModel?.messages?.isEmpty)

            if newLanchModel?.messages?.isEmpty == false {
                nextPageInt = newLanchModel?.payloadJson?.data?.nNextPage ?? 0//nextPageInt // - 1
                if viewAllInt == 3{
                    NewLanchItemApi(pin: pinCode ?? "")
                    isNextPageAPICall = true
                }else{
                    topmostApi(pin: pinCode ?? "")
                }
                print("down end")
                print(nextPageInt)
            }else{
                
                if viewAllInt == 1{
                    nextPageInt = itemByMfcCodeModel?.payloadJson?.data?.nNextPage ?? 0
                    isNextPageAPICall = true
                    sellerInspiredPurchase(wishItemCodeStr: mfcCode ?? "")
                    
                }else if viewAllInt == 2{
                    isNextPageAPICall = true
                    nextPageInt = topmostModel?.payloadJson?.data?.nNextPage ?? 0
                    topmostApi(pin: pinCode ?? "")
                }else if viewAllInt == 3{
                    nextPageInt = newLanchModel?.payloadJson?.data?.nNextPage ?? 0
                    isNextPageAPICall = true

                    NewLanchItemApi(pin: pinCode ?? "")
                }else if viewAllInt == 4{
                    isNextPageAPICall = true
                    nextPageInt = itemByMfcCodeModel?.payloadJson?.data?.nNextPage ?? 0
                    shopByMfcCode(wishItemCodeStr: mfcCode ?? "")
                }else if viewAllInt == 5{
                    isNextPageAPICall = true
                    nextPageInt = itemByCatMOdel?.payloadJson?.data?.nNextPage ?? 0
                    categoriesList(wishItemCodeStr: mfcCode ?? "")
                }else if viewAllInt == 6{
                    isNextPageAPICall = true
                    nextPageInt = itemByCatMOdel?.payloadJson?.data?.nNextPage ?? 0
                    categoriesAllProductList()
                }else{
                    isNextPageAPICall = true
                    nextPageInt = itembyMolCodeMOdel?.payloadJson?.data?.nNextPage ?? 0
                    searchMolCode(wishItemCodeStr: mfcCode ?? "")
                }
              
                print("down")
                print(nextPageInt)
            }



        }

    }
    

    
    //MARK: - Button Action
    //shortBookAction
    @objc func shortBookAction(sender:UIButton){
        shotBookSelectedInndexInt = sender.tag
        if viewAllInt == 1{
            if shotBookIntArray[sender.tag] == 1{
               
                removeShotook(itemCodeStr: self.sellerInspiredItems?[sender.tag].cItemCode ?? "", itemNameStr: self.sellerInspiredItems?[sender.tag].cItemName ?? "")

            }else{
                addToShotook(itemCodeStr:self.sellerInspiredItems?[sender.tag].cItemCode ?? "", itemNameStr: self.sellerInspiredItems?[sender.tag].cItemName ?? "")

            }
        }else if viewAllInt == 2 {
            if shotBookIntArray[sender.tag] == 1{
                removeShotook(itemCodeStr:arrayTopJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayTopJItems?[sender.tag].cItemName ?? "")

            }else{
                addToShotook(itemCodeStr:arrayTopJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayTopJItems?[sender.tag].cItemName ?? "")

            }
        }
        else if viewAllInt == 3 {
            if shotBookIntArray[sender.tag] == 1{
                removeShotook(itemCodeStr:arrayJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayJItems?[sender.tag].cItemName ?? "")

            }else{
                addToShotook(itemCodeStr:arrayTopJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayTopJItems?[sender.tag].cItemName ?? "")

            }
        }else if viewAllInt == 4 {
            if shotBookIntArray[sender.tag] == 1{
               
                removeShotook(itemCodeStr: self.shopByMfcItems?[sender.tag].cItemCode ?? "", itemNameStr: self.shopByMfcItems?[sender.tag].cItemName ?? "")

            }else{
                addToShotook(itemCodeStr:self.shopByMfcItems?[sender.tag].cItemCode ?? "", itemNameStr: self.shopByMfcItems?[sender.tag].cItemName ?? "")

            }
        }else{
            if shotBookIntArray[sender.tag] == 1{
                removeShotook(itemCodeStr:categoriesItems?[sender.tag].cItemCode ?? "", itemNameStr: categoriesItems?[sender.tag].cItemName ?? "")

            }else{
                addToShotook(itemCodeStr:categoriesItems?[sender.tag].cItemCode ?? "", itemNameStr: categoriesItems?[sender.tag].cItemName ?? "")

            }
        }
        self.shortBookCount()
       
    }
    //FIXME: - WishList
    @objc func addToCartAction(sender:UIButton){
        if viewAllInt == 1{
            productWiseSellerDetails(wishItemCodeStr:sellerInspiredItems?[sender.tag].cItemCode ?? "", itemName: sellerInspiredItems?[sender.tag].cItemName ?? "")
        }else if viewAllInt == 2{
            productWiseSellerDetails(wishItemCodeStr:arrayTopJItems?[sender.tag].cItemCode ?? "", itemName: arrayTopJItems?[sender.tag].cItemName ?? "")
        }else if viewAllInt == 3 {
            productWiseSellerDetails(wishItemCodeStr:arrayJItems?[sender.tag].cItemCode ?? "", itemName: arrayJItems?[sender.tag].cItemName ?? "")
        }else{
            productWiseSellerDetails(wishItemCodeStr:shopByMfcItems?[sender.tag].cItemCode ?? "", itemName: shopByMfcItems?[sender.tag].cItemName ?? "")
        }

       
    }
    @objc func wishListAction(sender:UIButton){
        wishListSelectedInndexInt = sender.tag
        if viewAllInt == 1 {
            if wishListIntArray[sender.tag] == 1 {
               
                removeWishList(itemCodeStr: sellerInspiredItems?[sender.tag].cItemCode ?? "", itemNameStr: sellerInspiredItems?[sender.tag].cItemName ?? "")

            }else{
                addToWishList(itemCodeStr:sellerInspiredItems?[sender.tag].cItemCode ?? "", itemNameStr: sellerInspiredItems?[sender.tag].cItemName ?? "")

            }
        }else if viewAllInt == 2 {
            if wishListIntArray[sender.tag] == 1{
               
                removeWishList(itemCodeStr: arrayTopJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayTopJItems?[sender.tag].cItemName ?? "")

            }else{
                addToWishList(itemCodeStr:arrayTopJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayTopJItems?[sender.tag].cItemName ?? "")

            }
        }
        else if viewAllInt == 3 {
            if wishListIntArray[sender.tag] == 1{
               
                removeWishList(itemCodeStr: arrayJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayJItems?[sender.tag].cItemName ?? "")

            }else{
                addToWishList(itemCodeStr:arrayJItems?[sender.tag].cItemCode ?? "", itemNameStr: arrayJItems?[sender.tag].cItemName ?? "")

            }
        }else if viewAllInt == 4 {
            if wishListIntArray[sender.tag] == 1{
               
                removeWishList(itemCodeStr: self.shopByMfcItems?[sender.tag].cItemCode ?? "", itemNameStr: self.shopByMfcItems?[sender.tag].cItemName ?? "")

            }else{
                addToWishList(itemCodeStr:self.shopByMfcItems?[sender.tag].cItemCode ?? "", itemNameStr: self.shopByMfcItems?[sender.tag].cItemName ?? "")

            }
        }else{
            if wishListIntArray[sender.tag] == 1{
                removeWishList(itemCodeStr: categoriesItems?[sender.tag].cItemCode ?? "", itemNameStr: categoriesItems?[sender.tag].cItemName ?? "")

            }else{
                addToWishList(itemCodeStr:categoriesItems?[sender.tag].cItemCode ?? "", itemNameStr: categoriesItems?[sender.tag].cItemCode ?? "")

            }
        }
        self.watchlistCount()
       
    }
}
extension PlpVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension PlpVC:addcartDelegate{
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
    }
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    
   
  
    
    
}
extension PlpVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func NewLanchItemApi(pin:String){
//        showActivityIndicator(self.view)
        
        let newLanchItems:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "NewlanchList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
//                                    "X-csquare-api-token":"-448945721a86225",
//                                    "Content-Type":"application/json",
//                                        ]
    
        let NewLaunchParams = ["c_availability": availability,"c_brands": brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_pincode": pin,
                               "n_limit": 20,
                               "n_page": nextPageInt] as [String : Any]
        print(NewLaunchParams)
            let nHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        newLanchItems.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_NEW_LAUNCH_FILTTER_URL, type: .post, userData: NewLaunchParams, apiHeader: nHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.newLanchModel = NewLaunchModel(object:dict)
            if boolSuccess {
                
               
                if self.newLanchModel?.appStatusCode == 0{
                   // itemLbl.text = "\(newLanchModel?.payloadJson?.data?.nTotal ?? 0) Items"
                    if self.isNextPageAPICall {
                        if let newLaunchVal = newLanchModel?.payloadJson?.data?.jList{
                            if newLaunchVal.count != 0{
                                self.arrayJItems = self.arrayJItems!.count > 0 ? self.arrayJItems! + newLaunchVal : newLaunchVal
                                
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {
                                        nshotBookAddRemove(completion: shotBook_completion )
                                        nwishListAddRemove(completion: wishList_completion)
                                    }
                                
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    else{
                        if let newLaunchVal = newLanchModel?.payloadJson?.data?.jList{
                            if newLaunchVal.count != 0{
                                self.arrayJItems = newLaunchVal
                                
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {

                                        nshotBookAddRemove(completion: shotBook_completion )
                                        nwishListAddRemove(completion: wishList_completion)

                                    }
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    
                    plpCollView.reloadData()
                }else{
                    
                }
                
                

            }else{


            }
            
            plpCollView.bottomRefreshControl?.endRefreshing()
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    
    
    func topmostApi(pin:String){
        nextPageInt = 0
        let topmost:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "TopMostApi")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let topmostParams = ["c_availability": availability,"c_brands":brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_pincode": pin,
                             "n_limit": 20,
                             "n_page": nextPageInt] as [String : Any]
        print(topmostParams)

            let nHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        print(nHeader)

        topmost.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_TOP_OFFER_FILTTER_URL, type: .post, userData: topmostParams, apiHeader: nHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.topmostModel = TopMostOrderModel(object:dict)
           // itemLbl.text = "\(topmostModel?.payloadJson?.data?.nTotal ?? 0) Items"
            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.isNextPageAPICall {
                    if let topLaunchVal = topmostModel?.payloadJson?.data?.jList{
                        if topLaunchVal.count != 0{
                            errorMesg = false

                            self.arrayTopJItems = self.arrayTopJItems!.count > 0 ? self.arrayTopJItems! + topLaunchVal : topLaunchVal
                            
                            let queue = DispatchQueue(label: "com.myApp.myQueue")

                                queue.sync {

                                    shotBookAddRemove(completion: shotBook_completion )
                                    wishListAddRemove(completion: wishList_completion)

                                }
                            
                            print(shotBookIntArray)
                            

                            
                        }else{
                            errorMesg = true
                            plpCollView.reloadData()
                        }
                    }
                }else{
                    if let topLaunchVal = topmostModel?.payloadJson?.data?.jList{
                        if topLaunchVal.count != 0{
                            errorMesg = false
                            self.arrayTopJItems = topLaunchVal
                            let queue = DispatchQueue(label: "com.myApp.myQueue")
                                queue.sync {
                                    shotBookAddRemove(completion: shotBook_completion )
                                    wishListAddRemove(completion: wishList_completion)
                                }
                                
                            print(shotBookIntArray)
                        }else{
                            errorMesg = true
                            plpCollView.reloadData()
                        }
                    }
                }
               
                
                plpCollView.reloadData()
                hideActivityIndicator(self.view)
            }else{
                        
                hideActivityIndicator(self.view)
            }
            plpCollView.reloadData()
            plpCollView.bottomRefreshControl?.endRefreshing()
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            errorMesg = true
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    
//MARK: - Seller Ispired Purchase
    func sellerInspiredPurchase(wishItemCodeStr:String){
//        self.showActivityIndicator(self.view)
        print(wishItemCodeStr)
        let sellerInspired:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sellerInspired")
        let sellerInspiredParams = ["c_availability": availability,"c_brands": brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_search_term": wishItemCodeStr,
                                    "n_limit": 20,
                                    "n_page": nextPageInt,"c_product_search":""] as [String : Any]
       // print(sellerInspiredParams)
        //let productWiseSellerParams = ["c_uitem_code":"498283"]
        //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let sellerInspiredHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        sellerInspired.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_SELLER_CODE_URL, type: .post, userData: sellerInspiredParams, apiHeader: sellerInspiredHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            
            print(dict)
            self.itemBySellerCodeModel = ItemBySellerFiltterModel(object:dict)
          //  itemLbl.text = "\(itemBySellerCodeModel?.payloadJson?.data?.nTotal ?? 0) Items"
            if boolSuccess {
                
                if self.itemBySellerCodeModel?.appStatusCode == 0{
                    if self.isNextPageAPICall {
                        
                        if let sellerInspiredVal = itemBySellerCodeModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false

                                self.sellerInspiredItems = self.sellerInspiredItems!.count > 0 ? self.sellerInspiredItems! + sellerInspiredVal : sellerInspiredVal
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {
                                        shopBySBAddRemove(completion: shotBook_completion )
                                        shopByWLAddRemove(completion: wishList_completion)
                                    }
                                    
                                print(shotBookIntArray)
                                
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    else{
                        if let sellerInspiredVal = itemBySellerCodeModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false

                                self.sellerInspiredItems = sellerInspiredVal
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {
                                        shopBySBAddRemove(completion: shotBook_completion )
                                        shopByWLAddRemove(completion: wishList_completion)
                                    }
                                    
                                print(shotBookIntArray)
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    plpCollView.reloadData()
                    plpCollView.bottomRefreshControl?.endRefreshing()
                    hideActivityIndicator(self.view)
                    
                }else{
                    errorMesg = true

                    plpCollView.bottomRefreshControl?.endRefreshing()
                    hideActivityIndicator(self.view)
                }
                plpCollView.bottomRefreshControl?.endRefreshing()
                hideActivityIndicator(self.view)
                
            }else{
                errorMesg = true

                plpCollView.bottomRefreshControl?.endRefreshing()
                hideActivityIndicator(self.view)
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    func shopByMfcCode(wishItemCodeStr:String){
//        self.showActivityIndicator(self.view)
        print(wishItemCodeStr)
        let shopByMfc:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopByMfc")
        let shopByMfcParams = ["c_availability": availability,"c_brands": brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_search_term": wishItemCodeStr,
                                             "n_limit": 20,
                                             "n_page": nextPageInt] as [String : Any]
        
        
        print(shopByMfcParams)
        //let productWiseSellerParams = ["c_uitem_code":"498283"]
        //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let shopByMfcHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        print(shopByMfcHeader)
        
        shopByMfc.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_MFC_CODE_URL, type: .post, userData: shopByMfcParams, apiHeader: shopByMfcHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.itemByMfcCodeModel = ItemByMfcCodeModel(object:dict)
            
            if boolSuccess {
                plpCollView.bottomRefreshControl?.endRefreshing()
                
               // itemLbl.text = "\(itemByMfcCodeModel?.payloadJson?.data?.nTotal ?? 0) Items"
                if self.itemByMfcCodeModel?.appStatusCode == 0{
                    if self.isNextPageAPICall {
                        
                        if let sellerInspiredVal = itemByMfcCodeModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false

                                self.shopByMfcItems = self.shopByMfcItems!.count > 0 ? self.shopByMfcItems! + sellerInspiredVal : sellerInspiredVal
                                
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                                                    queue.sync {
                                    sellerInspiredSBAddRemove(completion: shotBook_completion)
                                    sellerInspiredWLAddRemove(completion: wishList_completion)
                                                                    }
                                                                    
                                                                print(shotBookIntArray)
                                
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    else{
                        if let sellerInspiredVal = itemByMfcCodeModel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false

                                self.shopByMfcItems = sellerInspiredVal
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                                                    queue.sync {
                                                                        sellerInspiredSBAddRemove(completion: shotBook_completion)
                                                                        sellerInspiredWLAddRemove(completion: wishList_completion)
                                                                    }
                                                                    
                                                                print(shotBookIntArray)
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    plpCollView.reloadData()
                    hideActivityIndicator(self.view)
                    plpCollView.bottomRefreshControl?.endRefreshing()
                    
                }else{
                    errorMesg = true

                    hideActivityIndicator(self.view)
                    plpCollView.reloadData()

                    plpCollView.bottomRefreshControl?.endRefreshing()
                }
                
                hideActivityIndicator(self.view)
                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }else{
                errorMesg = true

                hideActivityIndicator(self.view)
                plpCollView.reloadData()

                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    func searchMolCode(wishItemCodeStr:String){
//        self.showActivityIndicator(self.view)
        print(wishItemCodeStr)
        let shopByMfc:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopByMfc")
        let shopByMfcParams = ["c_availability": availability,"c_brands":brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_search_term": wishItemCodeStr,
                               "n_limit": 20,
                               "n_page": nextPageInt] as [String : Any]
        print(shopByMfcParams)
        //let productWiseSellerParams = ["c_uitem_code":"498283"]
        //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let shopByMfcHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        print(shopByMfcHeader)
        
        shopByMfc.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_MOLECULES_FILTTER_URL, type: .post, userData: shopByMfcParams, apiHeader: shopByMfcHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.itembyMolCodeMOdel = ItemByMolCodeModel(object:dict)
            
            if boolSuccess {
                plpCollView.bottomRefreshControl?.endRefreshing()
                
               // itemLbl.text = "\(itembyMolCodeMOdel?.payloadJson?.data?.nTotal ?? 0) Items"
                if self.itembyMolCodeMOdel?.appStatusCode == 0{
                    if self.isNextPageAPICall {

                        if let sellerInspiredVal = itembyMolCodeMOdel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false
                                self.moleculeItems = self.moleculeItems!.count > 0 ? self.moleculeItems! + sellerInspiredVal : sellerInspiredVal
                                
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    else{
                        if let sellerInspiredVal = itembyMolCodeMOdel?.payloadJson?.data?.jList{
                            if sellerInspiredVal.count != 0{
                                errorMesg = false

                                self.moleculeItems = sellerInspiredVal
                                plpCollView.reloadData()

                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    plpCollView.reloadData()
                    hideActivityIndicator(self.view)
                    plpCollView.bottomRefreshControl?.endRefreshing()
                    
                }else{
                    errorMesg = true

                    hideActivityIndicator(self.view)
                    plpCollView.bottomRefreshControl?.endRefreshing()
                }
                
                hideActivityIndicator(self.view)
                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }else{
                errorMesg = true

                plpCollView.reloadData()

                hideActivityIndicator(self.view)
                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    func categoriesList(wishItemCodeStr:String){
//        self.showActivityIndicator(self.view)
        print(wishItemCodeStr)
        let shopByMfc:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopByMfc")
        let shopByMfcParams = ["c_availability": availability,
                                     "c_brands": brands,
                                     "c_manufacturers": manufacturers,
                                     "c_search_term": wishItemCodeStr,
                                     "c_sellers": sellers,
                                     "c_sort": sort,
                                     "n_page": nextPageInt,
                                     "n_limit": 20] as [String : Any]
        print(shopByMfcParams)
        //let productWiseSellerParams = ["c_uitem_code":"498283"]
        //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let shopByMfcHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        print(shopByMfcHeader)
        
        shopByMfc.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_CATEGORIES_ITEMS_URL, type: .post, userData: shopByMfcParams, apiHeader: shopByMfcHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.itemByCatMOdel = ItemByCategCodeModel(object:dict)
            
            if boolSuccess {
                plpCollView.bottomRefreshControl?.endRefreshing()
                
               // itemLbl.text = "\(itemByCatMOdel?.payloadJson?.data?.nTotal ?? 0) Items"
                if self.itemByCatMOdel?.appStatusCode == 0{
                    if self.isNextPageAPICall {
                        
                        if let catgoriesVal = itemByCatMOdel?.payloadJson?.data?.jList{
                            if catgoriesVal.count != 0{
                                errorMesg = false

                                self.categoriesItems = self.categoriesItems!.count > 0 ? self.categoriesItems! + catgoriesVal : catgoriesVal
                                
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {

                                        calteoriesAddRemove(completion: shotBook_completion)
                                        cateoriesWLAddRemove(completion: wishList_completion)

                                    }
                                
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    }
                    else{
                        if let catgoriesVal = itemByCatMOdel?.payloadJson?.data?.jList{
                            if catgoriesVal.count != 0{
                                errorMesg = false

                                self.categoriesItems = catgoriesVal
                                
                                let queue = DispatchQueue(label: "com.myApp.myQueue")
                                    queue.sync {

                                        calteoriesAddRemove(completion: shotBook_completion )
                                        cateoriesWLAddRemove(completion: wishList_completion)

                                    }
                            }else{
                                errorMesg = true
                                plpCollView.reloadData()
                            }
                        }
                    
                    }
                    plpCollView.reloadData()
                    hideActivityIndicator(self.view)
                    plpCollView.bottomRefreshControl?.endRefreshing()
                    
                }else{
                    
                    hideActivityIndicator(self.view)
                    plpCollView.bottomRefreshControl?.endRefreshing()
                }
                
                hideActivityIndicator(self.view)
                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }else{
                hideActivityIndicator(self.view)
                plpCollView.bottomRefreshControl?.endRefreshing()
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
              
            plpCollView.bottomRefreshControl?.endRefreshing()
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
    func categoriesAllProductList(){
        //        self.showActivityIndicator(self.view)
                 
                let AllProductList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AllProductList")
                let shopByMfcParams = ["c_availability": availability,
                                             "c_brands": brands,
                                             "c_manufacturers": manufacturers,
                                       "c_mobile_no": UserDefaults.standard.value(forKey: usernameConstantStr) ?? "",
                                             "c_sellers": sellers,
                                             "c_sort": sort,
                                             "n_page": nextPageInt,
                                             "n_limit": 20] as [String : Any]
                print(shopByMfcParams)
                //let productWiseSellerParams = ["c_uitem_code":"498283"]
                //        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
                //                                    "X-csquare-api-token":"99355562095561bc",
                //                                    "Content-Type":"application/json",
                //                                        ]
                
                let AllProductListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                            "Content-Type":"application/json",
                ]
                print(AllProductListHeader)
                
        AllProductList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_CATEGORIES_ITEMS_URL, type: .post, userData: shopByMfcParams, apiHeader: AllProductListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                    print(dict)
                    self.allProductModel = ItemByCategCodeModel(object:dict)
                    
                    if boolSuccess {
                        plpCollView.bottomRefreshControl?.endRefreshing()
                        
                       // itemLbl.text = "\(itemByCatMOdel?.payloadJson?.data?.nTotal ?? 0) Items"
                        if self.allProductModel?.appStatusCode == 0{
                            if self.isNextPageAPICall {
                                
                                if let catgoriesVal = allProductModel?.payloadJson?.data?.jList{
                                    if catgoriesVal.count != 0{
                                        errorMesg = false

                                        self.categoriesItems = self.categoriesItems!.count > 0 ? self.categoriesItems! + catgoriesVal : catgoriesVal
                                        let queue = DispatchQueue(label: "com.myApp.myQueue")

                                            queue.sync {

                                                allProductsAddRemove(completion: shotBook_completion )
                                                allProductsWLAddRemove(completion: wishList_completion)

                                            }
                                        print(shotBookIntArray)
                                        print(wishListIntArray)
                                        
                                    }else{
                                        errorMesg = true
                                        plpCollView.reloadData()
                                    }
                                }
                            }
                            else{
                                if let catgoriesVal = allProductModel?.payloadJson?.data?.jList{
                                    if catgoriesVal.count != 0{
                                        errorMesg = false

                                        self.categoriesItems = catgoriesVal
                                        let queue = DispatchQueue(label: "com.myApp.myQueue")

                                            queue.sync {

                                                allProductsAddRemove(completion: shotBook_completion )
                                                allProductsWLAddRemove(completion: wishList_completion)

                                            }
                                        print(shotBookIntArray)
                                        print(wishListIntArray)
                                    }else{
                                        errorMesg = true
                                        plpCollView.reloadData()
                                    }
                                }
                            }
                            plpCollView.reloadData()
                            hideActivityIndicator(self.view)
                            plpCollView.bottomRefreshControl?.endRefreshing()
                            
                        }else{
                            
                            hideActivityIndicator(self.view)
                            plpCollView.bottomRefreshControl?.endRefreshing()
                        }
                        
                        hideActivityIndicator(self.view)
                        plpCollView.bottomRefreshControl?.endRefreshing()
                        
                    }else{
                        hideActivityIndicator(self.view)
                        plpCollView.bottomRefreshControl?.endRefreshing()
                        
                    }
                    
                }, failureBlock: {[unowned self] (errorMesssage) in
                     
                    plpCollView.bottomRefreshControl?.endRefreshing()
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
    //MARK: - WisList Add
    func addToWishList(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let addToWishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToWishList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let addToWishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
            print(addToWishListParams)
            let WlHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        addToWishList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_WISHLIST_URL, type: .post, userData: addToWishListParams, apiHeader: WlHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addToWIshListModel = AWBaseClass(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.addToWIshListModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addToWIshListModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addToWIshListModel?.messages?[0] ?? "", view: self.view)
                    let wlIndexPath = IndexPath(item:wishListSelectedInndexInt, section: 0)
                    wishListIntArray[wishListSelectedInndexInt] = 1
                    self.plpCollView.reloadItems(at: [wlIndexPath])
                    self.wlItemCode()
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addToWIshListModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addToWIshListModel?.messages?[0] ?? "", view: self.view)
                    let wlIndexPath = IndexPath(item:wishListSelectedInndexInt, section: 0)
                    wishListIntArray[wishListSelectedInndexInt] = 1
                    self.plpCollView.reloadItems(at: [wlIndexPath])
                    self.wlItemCode()
                    
                }
                
                

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
    //MARK: - Shotook Add

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
            self.addtoshortBookModel = AddToSBModel(object:dict)

            if boolSuccess {
                plpCollView.reloadData()
                hideActivityIndicator(self.view)
                if self.addtoshortBookModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoshortBookModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoshortBookModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 1
                    self.plpCollView.reloadItems(at: [sbIndexPath])
                    self.sbItemCode()
//                    self.shortBookCount()
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoshortBookModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoshortBookModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 1
                    self.plpCollView.reloadItems(at: [sbIndexPath])
                    self.sbItemCode()
//                    self.shortBookCount()


                }
                
                

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
    //MARK: - removeSotook Add

    func removeShotook(itemCodeStr:String,itemNameStr :String){
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
            self.removeFromSBModel = RemoveFromSBModel(object:dict)

            if boolSuccess {
                hideActivityIndicator(self.view)
                
                if self.removeFromSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 0
                    self.plpCollView.reloadItems(at: [sbIndexPath])
                    self.sbItemCode()

                  
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookSelectedInndexInt, section: 0)
                    shotBookIntArray[shotBookSelectedInndexInt] = 0
                    self.plpCollView.reloadItems(at: [sbIndexPath])
                    self.sbItemCode()

                    
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
    //MARK: - removeWishList Add

    func removeWishList(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let WishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let WishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        print(WishListParams)
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
                    let wlIndexPath = IndexPath(item:wishListSelectedInndexInt, section: 0)
                    wishListIntArray[wishListSelectedInndexInt] = 0
                    self.plpCollView.reloadItems(at: [wlIndexPath])
                    self.wlItemCode()
                  
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removefromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removefromWLModel?.messages?[0] ?? "", view: self.view)
                    let wlIndexPath = IndexPath(item:wishListSelectedInndexInt, section: 0)
                    wishListIntArray[wishListSelectedInndexInt] = 0
                    self.plpCollView.reloadItems(at: [wlIndexPath])
                    self.wlItemCode()
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
                    
                    
                    addToCartView?.delegate = self
                    addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    addToCartView?.productName = itemName
                    addToCartView?.productwiseSellerModel = productWiseSellerModel
                    addToCartView?.selectQtyS = selectQty
                    print(addToCartView?.bestSchemesTableView.contentSize.height)
                    
                    self.view.addSubview(addToCartView!)
                    
                    
                    
                }else{
                    
                    
                }
                
                
                
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
    //MARK: - shotBookCount
    func sbItemCode(){
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
//                    if viewAllInt == 1{
//                                sellerInspiredPurchase(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 2 {
//                                topmostApi(pin: pinCode ?? "")
//
//
//                            }else if viewAllInt == 3{
//                                NewLanchItemApi(pin: pinCode ?? "")
//                            }else if viewAllInt == 4{
//                                shopByMfcCode(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 5{
//                                categoriesList(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 6{
//                                categoriesAllProductList()
//                            }else{
//                                searchMolCode(wishItemCodeStr: mfcCode ?? "")
//                            }
//                    isSbItem = true
//
//                    tPCollectionView.reloadData()
//                    newLaunchCollectionView.reloadData()
                    
                    
                }else{
                    
                }
                
                hideActivityIndicator(self.view)
                
            }else{
                        

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

        })
        apiQueue.leave()
        
        }
    //MARK: - Wish ListItem Code
    func wlItemCode(){
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
//                    if viewAllInt == 1{
//                                sellerInspiredPurchase(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 2 {
//                                topmostApi(pin: pinCode ?? "")
//
//                            }else if viewAllInt == 3{
//                                NewLanchItemApi(pin: pinCode ?? "")
//                            }else if viewAllInt == 4{
//                                shopByMfcCode(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 5{
//                                categoriesList(wishItemCodeStr: mfcCode ?? "")
//                            }else if viewAllInt == 6{
//                                categoriesAllProductList()
//                            }else{
//                                searchMolCode(wishItemCodeStr: mfcCode ?? "")
//                            }
//                    isSbItem = true
//
//                    tPCollectionView.reloadData()
//                    newLaunchCollectionView.reloadData()
                    
                 
                }else{
                    
                }
                
                hideActivityIndicator(self.view)
                
            }else{
                        

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

        })
        apiQueue.leave()
        
        }
    
}
