//
//  LoHomeVC.swift
//  liveOrder
//
//  Created by Data Prime on 07/07/21.
//

import UIKit
import Alamofire
import LazyImage
import CoreMIDI
//import ImageSlideshow
import NotificationBannerSwift
import FSPagerView
import Foundation




class LoHomeVC: UIViewController {
 
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var lSearchTextField: UITextField!
    @IBOutlet weak var lMenuButton: UIButton!
    @IBOutlet weak var lScanButton: UIButton!
    @IBOutlet weak var lMikeButton: UIButton!
    @IBOutlet weak var tpViewAllButton: UIButton!
    @IBOutlet weak var tPCollectionView: UICollectionView!
    @IBOutlet weak var newLaunchViewAllButton: UIButton!
    @IBOutlet weak var newLaunchCollectionView: UICollectionView!
    @IBOutlet weak var smViewAllButton: UIButton!
    @IBOutlet weak var smManifactureButton: UICollectionView!
    @IBOutlet weak var sellerInspiredCollView: UICollectionView!
    @IBOutlet weak var limitedPeriodCollView: UICollectionView!
    @IBOutlet weak var cSquareCollVIew: UICollectionView!
    @IBOutlet weak var topBarBlueView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var wishListBtn: SSBadgeButton!
    @IBOutlet weak var shortBookBtn: SSBadgeButton!
    @IBOutlet weak var cartBtn: SSBadgeButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var sellerInspiredViewBtn: UIButton!
    @IBOutlet weak var limitedViewBtn: UIButton!
    @IBOutlet weak var notificationButton: SSBadgeButton!
    
    @IBOutlet weak var multiViewtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannererView: FSPagerView!{
        didSet {
            self.bannererView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.bannererView.itemSize = FSPagerView.automaticSize
        }
    }
    @IBOutlet weak var bottomView: UIView!
    //MARK: - Height Constrains
    
    @IBOutlet weak var banerTopVerticalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newLaunchHeightConnstraint: NSLayoutConstraint!
    @IBOutlet weak var shopByMafHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var limitedPeriodHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sellerInspiredHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loMainnScrollView: UIScrollView!
    @IBOutlet weak var csqureViewAllBtn: UIButton!
    
    @IBOutlet weak var profilePlaceHolderLbl: UILabel!
    
    @IBOutlet weak var tpAreaLbl: UILabel!
    @IBOutlet weak var nlAreaLbl: UILabel!
    
    @IBOutlet weak var scanBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var mikeBtnWidth: NSLayoutConstraint!
    
    @IBOutlet weak var searcViewTopConstrainnt: NSLayoutConstraint!
    //Mark : Views

    let searchViewpopup = UINib(nibName: "SearchPopView", bundle:
                                    nil).instantiate(withOwner: nil, options: nil)[0] as? SearchPopView
    let askForDemoView = UINib(nibName: "AskForDemoView", bundle:
                                    nil).instantiate(withOwner: nil, options: nil)[0] as? AskForDemoView
    let sendDonePopView = UINib(nibName: "SendDoneView", bundle:
                                    nil).instantiate(withOwner: nil, options: nil)[0] as? SendDoneView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    let addToCartView = UINib(nibName: "AddToCartView", bundle:
                                nil).instantiate(withOwner: nil, options: nil)[0] as? AddToCartView
    
    var bannerListModel:BannerModel?
    var topMostModel : TopMostOrderModel?
    var newLanchModel : NewLaunchModel?
    var shopMfgModel : ShopBymfgModel?
    var limitedoffModel : LimitedOffersModel?
    var branchListModel:BranchListBaseClass?
    var sellerInnspiredyModel : SInspiredBaseClass?
    lazy var bannerlazyImage:LazyImage = LazyImage()
    lazy var topProductsLazyImage:LazyImage = LazyImage()
    lazy var newLaunchLazyImage:LazyImage = LazyImage()
    lazy var sellerInspiredImage:LazyImage = LazyImage()
    lazy var maifactureMGFImage:LazyImage = LazyImage()
    
    var shortBookCountModel : SBCountModel?
    var watchlistCountModel : WLCountModel?
    
    var removeFromWLModel : RemoveFromWLModel?
    var addtoWLmodel : AWBaseClass?
    
    var addtoSBModel : AddToSBModel?
    var removetoSBModel : RemoveFromSBModel?
    var firmProfileModel : FirmProfileModel?
    var cartCountModel: CartCountModel?
    
    var imageURlArray = [String]()
    //var bannerInputSource = [InputSource]()
    var proIdStr = String()
    var bannerIDsStr = String()
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var addItemModel : AddItemModel?
    var sbItemCodeModel:SBItemCodeModel?
    var wlItemCodeModel:WLItemCodeModel?
    var selectQty = [String]()
    var viewTranslation = CGPoint(x: 0, y: 0)
    var Sellertimer = Timer()
    var Sellercounter = 3
    var Mfgtimer = Timer()
    var Mfgcounter = 3
    var pageViewSeller: UIPageControl?
    var pageViewMfg : UIPageControl?
    
    var emailAdd : String?
    var pincode:String?
    var cProduct = ["EG","PS","PA","PA"]
    var isSbItem = false
    var sBrunOnceInt = Int()
    var nextPageInt = 0
   
    
    //FIXME: - ShotBook WishList Check Array
    var shotBookIntArray = [Int]()
    var wishListIntArray = [Int]()
    var nShotBookIntArray = [Int]()
    var nWishListIntArray = [Int]()
    //FIXME: - ShotBook WishList Check Int
    var topOrderInt = Int()
    var tShotookBookInt = Int()
    var tWishListInt = Int()
    //FIXME: - ShotBook WishList Cell Index
    var shotBookIndexInt = Int()
    var wishListIndexInt = Int()
    var nshotBookIndexInt = Int()
    var nwishListIndexInt = Int()
    var loadfirstInt = 0
    var getUserModel:GetUserBaseClass?
    var osSellerModel:OrderSellerList?
    let loadEmView = CartEmptyView.fromNib()
    var isAlternativeInt:Int?
    
    var isNewLaunchInt:Int?


    
   // @IBOutlet weak var multiSearchViewHeightConnstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sellerInspireVerticalHeightConstraint: NSLayoutConstraint!
    var searchVc :SearchWithListFeatureProductVC?

    
    var cSquareTopImg: [UIImage] = [
        UIImage(named: "ecogreen")!,
        UIImage(named: "PharmSoft")!,
        UIImage(named: "pharmsoftwholsesale")!,
        UIImage(named: "logo pharmsoft")!]
    
    var imgName = ["Eco green","PharmSoft","Pharmsoft wholsesale","Pharmsoft Wow"]
    var cSquareBotmImg: [UIImage] = [
        UIImage(named: "mfgimage")!,
        UIImage(named: "illustration 2")!,
        UIImage(named: "illustration 2")!,
        UIImage(named: "Layer 2")!]
    
    
    var cSquareTxt = ["Manage your store inventory,Stock & Sales, Billing, RackManagement etc...","Manage your store inventory,Stock & Sales, Billing, RackManagement etc...","Manage your Sales, Purchase,Inventory and Accountseasily.","Helps in Several Management Sales, Purchase, Inventory,Accounts etc..."]
    
    //    let searchViewpopup = UINib(nibName: "SearchPopView", bundle:
    //                        nil).instantiate(withOwner: nil, options: nil)[0] as? SearchPopView
    
    var apiQueue = DispatchGroup()
    
   
    //FIXME: - FILTTER  APLLY BTN TAPPED
    var availability = "N"
    var brands :[String] = []
    var manufacturers :[String] = []
    var sellers :[String] =  []
    var sort = "Relevance"
    
    private var indexOfCellBeforeDragging = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: - apiCall
    func apiCallBAck(){
            self.getProfile(completion: getProfile_completion)
            self.sbItemCode(completion: sbItemCode_completion)
            self.wlItemCode(completion: sbItemCode_completion)
       

            self.bannerApiCall(completion: banner_completion)
        
            self.sellerInnspiredyApi(completion: sellerInnspiredy_completion)
            
            self.shopMfgApi(completion: shopMfg_completion)
            self.limitedOfferApi(completion: limitedOffer_completion)
        self.NewLanchItemApi(pin:self.pincode ?? "", completion: NewLanchItem_completion)


            self.notificationCount(completion: notificationCount_completion)
            //self.cartCount()
            self.branchApiCall(completion: getProfile_completion)
            self.getUser(mobileNoStr:UserDefaults.standard.value(forKey: usernameConstantStr) as! String, completion: getUse_completion)

    }
    func setup(){
        loadfirstInt = 1
        apiCallBAck()
        smViewAllButton.isHidden = true
        csqureViewAllBtn.isHidden = true
        scanBtnWidth.constant = 0
        lScanButton.layoutIfNeeded()
        mikeBtnWidth.constant = 0
        lMikeButton.layoutIfNeeded()
        sellerInspiredViewBtn.isHidden = true
        smViewAllButton.isHidden = true
        limitedViewBtn.isHidden = true
        wishListBtn.badgeEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
        shortBookBtn.badgeEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
        cartBtn.badgeEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
        bottomView.backgroundColor = .white
        //        bottomView.layer.borderColor = .white
        //        bottomView.layer.borderWidth = 1
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.wishListBtn.badgeLabel.backgroundColor = UIColor(hexString: "00D3B4")
        self.wishListBtn.badgeLabel.borderWidth = 0.5
        self.wishListBtn.badgeLabel.borderColor = UIColor.white
        self.wishListBtn.badgeLabel.clipsToBounds = true
        
        self.bottomView.dropShadow()
        topBarBlueView.clipsToBounds = true
        topBarBlueView.layer.cornerRadius = 30
        topBarBlueView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        sellerInspiredCollView.delegate = self
        sellerInspiredCollView.dataSource = self
        
        tPCollectionView.delegate = self
        tPCollectionView.dataSource = self
        
        newLaunchCollectionView.delegate = self
        newLaunchCollectionView.dataSource = self
        
        smManifactureButton.delegate = self
        smManifactureButton.dataSource = self
        
        limitedPeriodCollView.delegate = self
        limitedPeriodCollView.dataSource = self
        
        cSquareCollVIew.delegate = self
        cSquareCollVIew.dataSource = self
        lSearchTextField.delegate = self
        
        
        searchView.layer.cornerRadius = 5
        
        topBarBlueView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .leftToRight)
        //  topBarBlueView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#6C19D8")])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection =  .horizontal//.vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        
        
        sellerInspiredCollView.register(UINib(nibName: "favouriteSellerCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"favouriteSellerCollCell")
        
        tPCollectionView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier:productlistVariantscelidentifreStr)
        
        newLaunchCollectionView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier:productlistVariantscelidentifreStr)
        
        smManifactureButton.register(UINib(nibName: "ImgCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"ImgCollectionViewCell")
        
        limitedPeriodCollView.register(UINib(nibName: "PrductBannerCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"PrductBannerCollectionViewCell")
        
        cSquareCollVIew.register(UINib(nibName: "CsquareCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"CsquareCollectionViewCell")
        
        
        self.loMainnScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(hideTableView(sender:))) //do that animation to hide the UITableView
        swipeGesture.direction = .down //Swiping down may come into conflict w/ the UITableView itself if it is scrollable, check it out.
        self.view.addGestureRecognizer(swipeGesture)
        
        self.bannererView.delegate = self
        self.bannererView.dataSource = self
        self.bannererView.itemSize = CGSize(width: UIScreen.main.bounds.width - 40 , height: 210)
        self.bannererView.automaticSlidingInterval = 2.0
//        self.bannererView.transformer = FSPagerViewTransformer(type: .linear)
        pageViewSeller?.numberOfPages = sellerInnspiredyModel?.payloadJson?.data?.jList?.count ?? 3
        pageViewSeller?.currentPage = 0
        pageViewMfg?.numberOfPages = shopMfgModel?.payloadJson?.data?.jList?.count ?? 3
        pageViewMfg?.currentPage = 0
        DispatchQueue.main.async {
              self.Sellertimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.autoSlideSeller), userInfo: nil, repeats: true)
           }
        DispatchQueue.main.async {
              self.Mfgtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.autoSlideMfg), userInfo: nil, repeats: true)
           }

        
    }
    @objc func autoSlideSeller() {
        if sellerInnspiredyModel?.payloadJson?.data?.jList?.count != 0{
            if Sellercounter < sellerInnspiredyModel?.payloadJson?.data?.jList?.count ?? 0 {
                 let index = IndexPath.init(item: Sellercounter, section: 0)
                 self.sellerInspiredCollView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageViewSeller?.currentPage = Sellercounter
                Sellercounter += 1
            } else {
                Sellercounter = 0
                 let index = IndexPath.init(item: Sellercounter, section: 0)
                 self.sellerInspiredCollView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                pageViewSeller?.currentPage = Sellercounter
                Sellercounter = 1
              }
        }else{
            
        }

      }
    @objc func autoSlideMfg() {
        if shopMfgModel?.payloadJson?.data?.jList?.count != 0{
                     if Mfgcounter < shopMfgModel?.payloadJson?.data?.jList?.count ?? 0 {
                          let index = IndexPath.init(item: Mfgcounter, section: 0)
                          self.smManifactureButton.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                         pageViewMfg?.currentPage = Mfgcounter
                         Mfgcounter += 1
                     } else {
                         Mfgcounter = 0
                          let index = IndexPath.init(item: Mfgcounter, section: 0)
                          self.smManifactureButton.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                         pageViewMfg?.currentPage = Mfgcounter
                         Mfgcounter = 1
                       }
        }else{
            
        }
//

      }
    //MARK: - Button Action
    @objc func hideTableView(sender: UISwipeGestureRecognizer) {
        self.searchViewpopup?.removeFromSuperview()

        UIView.animate(withDuration: 1.0) {
            self.remove_ViewController(secondViewController: self.searchVc)
        
        }
        
        
    }
    
    
    //MARK: - Button Action
    
    @IBAction func notifyBtnAct(_ sender: Any) {
        let notificationVc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationLOViewController") as! NotificationLOViewController
        self.navigationController?.pushViewController(notificationVc, animated: true)
        
    }
    
    
    @IBAction func scanBtnAct(_ sender: Any) {
        
        let scanfailedview = UINib(nibName: "ScanResultFailedView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ScanResultFailedView
        
        scanfailedview?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(scanfailedview!)
        
    }
    @IBAction func cSquareViewBtnAct(_ sender: Any) {
        
    }
    @IBAction func limitedViewBtnAct(_ sender: Any) {
    }
    @IBAction func shopByViewBtnAct(_ sender: Any) {
    }
    @IBAction func newLaunchViewBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = 3
        vc?.pinCode = pincode
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func topMostViewBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = 2
        vc?.pinCode = pincode
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func sellerInspiredViewBtnAct(_ sender: Any) {
    }
    
    @IBAction func mikeBtnAct(_ sender: Any) {
    }
    
    @IBAction func lmpViewAllBtnAct(_ sender: Any) {
    }
    @IBAction func wishLiistBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WatchListVC") as? WatchListVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func shortBookBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShortBookVC") as? ShortBookVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func cartBtnAct(_ sender: Any) {
        print(cartCountModel?.payloadJson?.data?.count)
        if cartCountModel?.payloadJson?.data?.count != nil{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.loadEmptyCartVierw(vcName: self)
        }
      
    }
    @IBAction func profileBtnAct(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func meuBtnAct(_ sender: Any) {
        
        searchViewpopup?.delegate = self
        searchViewpopup!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        searchViewpopup?.searchBtn.addTarget(self, action:#selector(mSearcAction(sender:)), for: .touchUpInside)
        searchViewpopup?.resetBtn.addTarget(self, action:#selector(resetAct(sender:)), for: .touchUpInside)
        
        //Add the view
        self.view.addSubview(searchViewpopup!)
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
    @objc func mSearcAction(sender:UIButton){
      
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = searchViewpopup!.searchTbleView.cellForRow(at: indexPath) as! SearchTableViewCell
        
        cell.searchTxtField.resignFirstResponder()
       
        add_ViewController()
//        let searchListVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC") as! SearchWithListFeatureProductVC
//        searchListVc.passHeigtViewDelegate = self
//        print(multiSearchArray)
//        self.multiSearchContainerView.addSubview(searchListVc.view)
//        self.multiSearchContainerView.isHidden = false
//        self.multiViewtopConstraint.constant = 185.0
        self.searchViewpopup?.removeFromSuperview()
        
        searchViewpopup?.btn = 1
        

    }
    @objc func mResetAction(sender:UIButton){
        
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
extension LoHomeVC : searchDelegate{
    func onPizzaReady(type: String) {
        print(type)
        let searchVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC") as? SearchWithListFeatureProductVC
        searchVc!.searchTextStr = type
        searchVc!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(searchVc!, animated: true, completion: nil)
        
    }
}
extension LoHomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sellerInspiredCollView{
            return sellerInnspiredyModel?.payloadJson?.data?.jList?.count ?? 5
            
        }else  if collectionView == tPCollectionView{
            return topMostModel?.payloadJson?.data?.jList?.count ?? 5
            
        }else  if collectionView == newLaunchCollectionView{
            return newLanchModel?.payloadJson?.data?.jList?.count ?? 5
            
        }else  if collectionView == smManifactureButton{
            return shopMfgModel?.payloadJson?.data?.jList?.count ?? 5
            
        }else  if collectionView == limitedPeriodCollView{
            return limitedoffModel?.payloadJson?.data?.jList?.count ?? 5
            
        }else{
            return cSquareTxt.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sellerInspiredCollView {
            let favcell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteSellerCollCell", for: indexPath) as! favouriteSellerCollCell
            favcell.titleLabel.text = sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName

            if sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].acSellerImages?.count == 0{
                
                let sellerName = sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName?.getAcronyms().uppercased()
                favcell.imageLetterLabel.text = sellerName?.maxLength(length: 2)
                favcell.imageLetterLabel.isHidden = false
                favcell.imgView.isHidden = true
                
            }else{
                
                self.sellerInspiredImage.showWithSpinner(imageView: favcell.imgView, url:sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].acSellerImages?[0].cSellerImage)
                
               
                favcell.imgView.isHidden = false
                favcell.imageLetterLabel.isHidden = true
                
            }
            
            
            return favcell
            
        }else if collectionView == tPCollectionView {
            let topcell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
           
            
            if topMostModel?.payloadJson?.data?.jList?.isEmpty == true{
                print("end")
            }else{
                
                topProductsLazyImage.showWithSpinner(imageView:topcell.productImgView, url: topMostModel?.payloadJson?.data?.jList?[indexPath.row].acThumbnailImages?[0].cThumbnailImage, defaultImage:"injectable")
                topcell.madicineNameLbl.text = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cContains
                topcell.mrpansLbl.text = "\(topMostModel?.payloadJson?.data?.jList?[indexPath.row].nMrp ?? 0)"
                topcell.productMgLbl.text = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cItemName
                
                topcell.packSizeMlLbl.text = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cPackName
                topcell.addtoCardBtn.tag = indexPath.row
                topcell.wishListBtn.tag = indexPath.row
                topcell.shortBookBtn.tag = indexPath.row
                topcell.wishListBtn.addTarget(self, action: #selector(topwishListAction), for: .touchUpInside)
                topcell.shortBookBtn.addTarget(self, action: #selector(topshortBookAction), for: .touchUpInside)
                topcell.addtoCardBtn.addTarget(self, action: #selector(topAddToCartAction), for: .touchUpInside)
                
                topcell.offerBtn.isHidden = true
                if wishListIntArray.count != 0{
                if wishListIntArray[indexPath.row] == 1{
                    topcell.wishListImg.image = UIImage(named: "wishlist_1")

                }else{
                    topcell.wishListImg.image = UIImage(named: "wishlist")

                }
                }
                if shotBookIntArray.count != 0{
                    if shotBookIntArray[indexPath.row] == 1 {
                        topcell.shortBokImg.image = UIImage(named: "shortbook-2")

                    }else{
                        topcell.shortBokImg.image = UIImage(named: "shortbook")

                    }
                }
               
                if isSbItem == true{
//                    let arr1 = [topMostModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode]
//                    let arr2 = [sbItemCodeModel?.payloadJson?.data?[indexPath.row].cItemCode]
//                    let output = arr1.filter(arr2.contains)
//                    print(output)
                   
                }
                
              
 
            }
            
            
            return topcell
            
        }else if collectionView == newLaunchCollectionView {
            let newLaunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
            
//            newLaunchLazyImage.showWithSpinner(imageView:newLaunchCell.productImgView, url: newLanchModel?.payloadJson?.data?.jList?[indexPath.row].acThumbnailImages?[indexPath.row].cThumbnailImage, defaultImage:"injectable")
            newLaunchCell.productImgView.image = UIImage(named: "injectable")
            newLaunchCell.madicineNameLbl.text = newLanchModel?.payloadJson?.data?.jList?[indexPath.row].cContains
            newLaunchCell.mrpansLbl.text = "\(newLanchModel?.payloadJson?.data?.jList?[indexPath.row].nMrp ?? 0)"
            newLaunchCell.productMgLbl.text = newLanchModel?.payloadJson?.data?.jList?[indexPath.row].cItemName
            newLaunchCell.packSizeMlLbl.text = newLanchModel?.payloadJson?.data?.jList?[indexPath.row].cPackName
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.addTarget(self, action: #selector(nLaddToCartAction), for: .touchUpInside)
            newLaunchCell.offerBtn.isHidden = true
            newLaunchCell.wishListBtn.tag = indexPath.row
            newLaunchCell.shortBookBtn.tag = indexPath.row
            newLaunchCell.addtoCardBtn.tag = indexPath.row
            newLaunchCell.wishListBtn.addTarget(self, action: #selector(wishListAction), for: .touchUpInside)
            newLaunchCell.shortBookBtn.addTarget(self, action: #selector(shortBookAction), for: .touchUpInside)
            
            
            if nWishListIntArray.count != 0{
            if nWishListIntArray[indexPath.row] == 1{
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist_1")

            }else{
                newLaunchCell.wishListImg.image = UIImage(named: "wishlist")

            }
            }
            if nShotBookIntArray.count != 0{
                if nShotBookIntArray[indexPath.row] == 1 {
                    newLaunchCell.shortBokImg.image = UIImage(named: "shortbook-2")

                }else{
                    newLaunchCell.shortBokImg.image = UIImage(named: "shortbook")

                }
            }
            
            return newLaunchCell
        }else if collectionView == smManifactureButton {
            
            let shopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCollectionViewCell", for: indexPath) as! ImgCollectionViewCell
            shopCell.imgGView.image = UIImage(named: "1280_px_abbott_laboratories_svg")
            
            shopCell.overView.layer.borderColor = hexStringToUIColor(hex: "#c3cde4").cgColor
            
            shopCell.overView.layer.borderWidth = 0.5
            
            shopCell.overView.layer.cornerRadius = 5
            shopCell.smLbl.text = shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].cManufactureName
            if shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].acImages?.count == 0{
                shopCell.imgGView.isHidden = true
                shopCell.alterLbl.isHidden = false

                let sellerName = shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].cManufactureName?.getAcronyms().uppercased()
                shopCell.alterLbl.text = sellerName?.maxLength(length: 2)

            }else{
                shopCell.imgGView.isHidden = false
                shopCell.alterLbl.isHidden = true


                maifactureMGFImage.showWithSpinner(imageView:shopCell.imgGView, url: shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].acImages?[0].cItemImage)
                
            }
            
            
            return shopCell
            
        } else if collectionView == self.limitedPeriodCollView {
            let limitedoffCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrductBannerCollectionViewCell", for: indexPath) as! PrductBannerCollectionViewCell
            
            limitedoffCell.layer.cornerRadius = 10
            limitedoffCell.layer.masksToBounds = true
            bannerlazyImage.showWithSpinner(imageView: limitedoffCell.comLogoImgView, url: limitedoffModel?.payloadJson?.data?.jList?[indexPath.row].cOfferImage)
            
            return limitedoffCell
        }else{
            let cSquareCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CsquareCollectionViewCell", for: indexPath) as! CsquareCollectionViewCell
            cSquareCell.getBtn.applyTopGradient(colours: [UIColor(hexString: "#F49F3B"),UIColor(hexString:"#FF7B20")], locations: [0.0,1.0])
            
            cSquareCell.nameImageView.image = cSquareTopImg[indexPath.row]
            cSquareCell.desTxtLbl.text = cSquareTxt[indexPath.row]
            cSquareCell.productImageView.image = cSquareBotmImg[indexPath.row]
            cSquareCell.getBtn.tag = indexPath.row
            cSquareCell.getBtn.addTarget(self, action: #selector(askDemoAct), for: .touchUpInside)
            return cSquareCell
        }
        
        
        
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 0.0, right: 1.0)//here your custom value for spacing
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == sellerInspiredCollView {
            let plp = self.storyboard?.instantiateViewController(withIdentifier: "PlpVC")
            as! PlpVC
            plp.viewAllInt = 1
            plp.sellerName = sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName ?? "no Value"
            plp.mfcCode = sellerInnspiredyModel?.payloadJson?.data?.jList?[indexPath.row].cSellerCode ?? "no Value"
          //  plp.pinCode = sellerInnspiredyModel?.payloadJson?.data?.
            self.navigationController?.pushViewController(plp, animated: true)
           
            
        }else if collectionView == tPCollectionView {
            
            let afterScamProductVc = self.storyboard?.instantiateViewController(withIdentifier: "AfterScanFmgcProductVC")
            as! AfterScanFmgcProductVC
        
            let Str = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode
            
            print(Str)
            
            afterScamProductVc.productIDStr = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode ?? "no Value"
            afterScamProductVc.productNameStr = topMostModel?.payloadJson?.data?.jList?[indexPath.row].cItemName ?? "no Value"
            self.navigationController?.pushViewController(afterScamProductVc, animated: true)
            
        }else if collectionView == newLaunchCollectionView {
            
            
            let afterScamProductVc = self.storyboard?.instantiateViewController(withIdentifier: "AfterScanFmgcProductVC")
            as! AfterScanFmgcProductVC
            afterScamProductVc.productIDStr = newLanchModel?.payloadJson?.data?.jList?[indexPath.row].cItemCode ?? "no Value"
            self.navigationController?.pushViewController(afterScamProductVc, animated: true)
            
        }else if collectionView == smManifactureButton {
            let plp = self.storyboard?.instantiateViewController(withIdentifier: "PlpVC")
            as! PlpVC
            plp.viewAllInt = 4
            plp.sellerName = shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].cManufactureName ?? "no Value"
            plp.mfcCode = shopMfgModel?.payloadJson?.data?.jList?[indexPath.row].cManufactureCode ?? "no Value"
         
            self.navigationController?.pushViewController(plp, animated: true)
            
        } else if collectionView == limitedPeriodCollView{
            
        }else {
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tPCollectionView{
            return CGSize(width: 166, height: 209)

        }else{
            return CGSize(width: 166, height: 209)

        }
    }
    
    //MARK: - topmost WLISR BTN ACT AND SHORTBOOK BTN ACR
    @objc func topwishListAction(sender:UIButton){
        loadfirstInt = 0
        tWishListInt = 1
        isNewLaunchInt = 0
        self.wishListIndexInt = sender.tag
        if self.wishListIntArray[sender.tag] == 1{
            
            removeWishList(itemCodeStr: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }else{
            addToWishList(itemCodeStr:topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }
    }
    @objc func topshortBookAction(sender:UIButton){
        loadfirstInt = 0
        tShotookBookInt = 1
        isNewLaunchInt = 0
        self.shotBookIndexInt = sender.tag
        if self.shotBookIntArray[sender.tag] == 1{
            removeShotbook(itemCodeStr:topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")

        }else{
            addToShotook(itemCodeStr:topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "" ,itemNameStr: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
            
        }
    }
    //MARK: - Cel Wishlist button actions
    
    @objc func wishListAction(sender:UIButton){
        loadfirstInt = 0
        tWishListInt = 1
        isNewLaunchInt = 1
        self.nwishListIndexInt = sender.tag

        if nWishListIntArray[sender.tag] == 1{
            removeWishList(itemCodeStr: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
        }else{
            addToWishList(itemCodeStr:newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
        }
    }
    //MARK: - Cel Shortbook button actions
    @objc func shortBookAction(sender:UIButton){
        loadfirstInt = 0
        tShotookBookInt = 1
        isNewLaunchInt = 1
        self.nshotBookIndexInt = sender.tag

        if nShotBookIntArray[sender.tag] == 1{
            removeShotbook(itemCodeStr:newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
            
        }else{
            addToShotook(itemCodeStr:newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "", itemNameStr: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
            
        }
        
        
        
    }
    
    //MARK: - Add to cart utton actions
    @objc func nLaddToCartAction(sender:UIButton){
        
        productWiseSellerDetails(wishItemCodeStr:newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "",itemName: newLanchModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
        
    }
    @objc func topAddToCartAction(sender:UIButton){
        //print(topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode)
        productWiseSellerDetails(wishItemCodeStr:topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? "",itemName: topMostModel?.payloadJson?.data?.jList?[sender.tag].cItemName ?? "")
        
        
    }
    @objc func askDemoAct(sender:UIButton){
        askForDemoView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        askForDemoView?.thankLbl.text = "ThankYou for Showing Interest \"\(imgName[sender.tag])\""
        askForDemoView?.productName = cProduct[sender.tag]
        askForDemoView?.delegate = self
        //Add the view
        self.view.addSubview(askForDemoView!)
    }
}
extension LoHomeVC : closeDelegate{
    func close() {
        askForDemoView?.removeFromSuperview()
    }
    
    
}
extension LoHomeVC:cSquareSendDemoDelegate{
    func cSquareDetails(storeName: String, owner: String, mobileNum: String, pincode: String, description: String) {
        print(storeName, owner, mobileNum, pincode, description)
        sendEmailForDemo(storeName: storeName, mobile_noStr: mobileNum, owner: owner, pincode: pincode, des: description ,email: emailAdd ?? "")
    }
    func demoDetails(storeName: String, owner: String, mobileNum: String, pincode: String, description: String, cProduct: String) {
        demoDemo(storeName: storeName, mobile_noStr: mobileNum, owner: owner, pincode: pincode, des: description,cPro: cProduct )
    }

}
extension LoHomeVC: addcartDelegate{
    func openSeller(c_item_codeStr: String,itemIndex: Int) {
        let sellerPopUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SellerTableViewController") as! SellerTableViewController
        
        sellerPopUpVc.sAeaCodeStr = osSellerModel?.payloadJson?.data?[itemIndex].cAreaCode as! String
        sellerPopUpVc.sAreaNameStr = osSellerModel?.payloadJson?.data?[itemIndex].cAreaName as! String
        sellerPopUpVc.sCityNamestr = osSellerModel?.payloadJson?.data?[itemIndex].cCityName as! String
        sellerPopUpVc.sSellerNameStr = osSellerModel?.payloadJson?.data?[itemIndex].cSellerName as! String
        sellerPopUpVc.sStateNameStr = osSellerModel?.payloadJson?.data?[itemIndex].cStateName as! String
        sellerPopUpVc.comNameStr = osSellerModel?.payloadJson?.data?[itemIndex].cSellerName as! String
        self.navigationController?.present(sellerPopUpVc, animated: true, completion: nil)
        
    }
    
    func addcartReady(c_item_codeStr: String, c_mobile_noStr: String, c_seller_codeStr: String, c_seller_item_codeStr: String, c_seller_nameStr: String, n_mrpStr: Float, n_qtystr: String, n_seller_rateStr: Float) {
        
        addToCart(item_codeStr: c_item_codeStr, mobile_noStr: c_mobile_noStr, seller_codeStr: c_seller_codeStr, seller_item_codeStr: c_seller_item_codeStr, seller_nameStr: c_seller_nameStr, n_mrpStr:n_mrpStr, n_qtyStr: n_qtystr, n_seller_rateStr: n_seller_rateStr)
        
    }
    
    
    
}
extension LoHomeVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LcMainSearchVC") as? LcMainSearchVC
        multiSearchArray = ["","","","",""]
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        if textField.text?.count == 0 {
            
            
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
}
extension LoHomeVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension LoHomeVC:passHeigtDeleate{
    func passViewHeigt() {
       // self.multiViewtopConstraint.constant = 0.0
        
    }
    
    //MARK: - addRemove containerView
    func add_ViewController() {
        let controller  = self.storyboard?.instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC")as! SearchWithListFeatureProductVC
        controller.view.frame = CGRect(x: 0, y: self.view.frame.origin.y + 150, width: self.view.frame.size.width, height:self.view.frame.size.height - 150 )
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
    
    func loadEmptyCartVierw(vcName:UIViewController){
        
        loadEmView.tag = 112
        loadEmView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        vcName.view.addSubview(loadEmView)
   
    }

    

}
extension UIView {
    /// Remove allSubView in view
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }

}



