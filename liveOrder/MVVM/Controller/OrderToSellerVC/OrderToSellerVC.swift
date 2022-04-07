//
//  OrderToSellerVC.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift
import SwiftUI
import CCBottomRefreshControl

class OrderToSellerVC: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var liveOrderLbl: UILabel!
    @IBOutlet weak var brownView: UIView!
    @IBOutlet weak var secTopView: UIView!
    @IBOutlet weak var tabCollView: UICollectionView!
    @IBOutlet weak var tabTableview: UITableView!
    @IBOutlet weak var tiltleView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchAndOPtionBtn: UIButton!
    @IBOutlet weak var ldotLineLbl: UILabel!
    @IBOutlet weak var mappedSellerLbl: UILabel!
    @IBOutlet weak var unMappedSellerLbl: UILabel!
    
    @IBOutlet weak var dotView: DashedLineView!
    
    
    @IBOutlet weak var registerASellerLbl: UILabel!
    @IBOutlet weak var mappedbtn: UIButton!
    @IBOutlet weak var mappedBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var mappedBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var unmappedBtn: UIButton!
    @IBOutlet weak var unmappedBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var unmappedBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var registSellerBtn: UIButton!
    @IBOutlet weak var registerSellerHeight: NSLayoutConstraint!
    @IBOutlet weak var registerSellerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var mappedLblWidth: NSLayoutConstraint!
    
    @IBOutlet weak var unMappedLblWidth: NSLayoutConstraint!
    @IBOutlet weak var registLblWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var searchAndMoreImageView: UIImageView!
    
    var colTitle = ["Mapped Sellers","Un-Mapped Sellers","Register a Seller"]
    var tab = 0
    var btn = 0
    var indexColor = 0
    var osSellerModel:OrderSellerList?
    var searchUnMappedModel:OrderSellerList?
    var searchCitystateUnnMappedModel:OrderSellerList?
    var addasellerModel : AddASellerModel?
    var mappedSellerModel : MpdSellerModel?
    var priorityModel : PriorityBaseClass?
    var searchTapped = 0
    var isApplyButtonSelectedInt = 0
    var aStateStr = String()
    var aCityStr = String()
    var aAreaStr = String()
    var isUnMappedSellerInt = 0
    var mappedSelectedInx = 0
    
    var selectedIndex = 0
    var priorityInt = [Int]()

    
    
    let searchView = UINib(nibName: "searchView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? searchView
    let SetPriorityView = UINib(nibName: "SetPriorityView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? SetPriorityView
    let RetrievalOptionView = UINib(nibName: "RetrievalOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? RetrievalOptionView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bottomRefreshController = UIRefreshControl()
        bottomRefreshController.tintColor = UIColor(hexString: "6c19d8")
        bottomRefreshController.triggerVerticalOffset = 50
        tabTableview.bottomRefreshControl = bottomRefreshController
        setup()
       

       
    }
    
    func setup(){
        
        
       
        unMappedSellerLbl.isHidden = true
        registerASellerLbl.isHidden = true
        mappedbtn.setTitleColor(UIColor(hexString: "674cf3"), for: .normal)
        mappedSellerLbl.backgroundColor = UIColor(hexString: "674cf3")
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .leftToRight)
      //  topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        secTopView.clipsToBounds = true
        secTopView.layer.cornerRadius = 30
        secTopView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        secTopView.backgroundColor = .white
       
        tabTableview.delegate = self
        tabTableview.dataSource = self
//        tabCollView.register(UINib(nibName: "OtoSColCell", bundle: Bundle.main), forCellWithReuseIdentifier: "OtoSColCell")
        tabTableview.register(UINib(nibName: "MSTableViewCell", bundle: nil), forCellReuseIdentifier: "MSTableViewCell")
        tabTableview.register(UINib(nibName: "UMSTableCell", bundle: nil), forCellReuseIdentifier: "UMSTableCell")
        tabTableview.register(UINib(nibName: "registerTableCell", bundle: nil), forCellReuseIdentifier: "registerTableCell")
        
        print(isApplyButtonSelectedInt)
        unSellerList()

        //FIXME: - applyButton Clicket unmapped
        if isApplyButtonSelectedInt == 1{
            unMappedLblWidth.constant = 134
            unMappedSellerLbl.layoutIfNeeded()
            mappedLblWidth.constant = 90
            mappedSellerLbl.layoutIfNeeded()
            registLblWidth.constant = 100
            registerASellerLbl.layoutIfNeeded()
            
            unmappedBtnWidth.constant = 134
            unmappedBtn.layoutIfNeeded()
            mappedBtnWidth.constant = 80
            mappedbtn.layoutIfNeeded()
            registerSellerWidth.constant = 80
            registSellerBtn.layoutIfNeeded()
            unmappedBtn.setTitleColor(UIColor(hexString: "674cf3"), for: .normal)
            unMappedSellerLbl.backgroundColor = UIColor(hexString: "674cf3")
            unMappedSellerLbl.isHidden = false
            mappedbtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
            mappedSellerLbl.isHidden = true
            registSellerBtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
            registerASellerLbl.isHidden = true
            searchAndOPtionBtn.isHidden = false
            searchAndMoreImageView.isHidden = false
            titleLbl.text = "List Of Un-Mapped Sellers"
            searchAndMoreImageView.image = UIImage(named: "more")
            
            tab = 1
            btn = 1
            indexColor = 1
            isUnMappedSellerInt = 1

           
        }else{
            titleLbl.text = "List Of the Sellers"
            
            let origImage = UIImage(named: "search_small")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            searchAndMoreImageView.image = tintedImage
            searchAndMoreImageView.tintColor = UIColor.init(hexString: "6c757d")
            searchAndOPtionBtn.contentMode = .center
            mappedSeller()

           
        }
        
    }
    
    @IBAction func registerSellerAct(_ sender: Any) {
        
        registLblWidth.constant = 115
        registerASellerLbl.layoutIfNeeded()
        unMappedLblWidth.constant = 134
        unMappedSellerLbl.layoutIfNeeded()
        mappedLblWidth.constant = 102
        mappedSellerLbl.layoutIfNeeded()
        
        mappedBtnWidth.constant = 102
        mappedbtn.layoutIfNeeded()
        unmappedBtnWidth.constant = 134
        unmappedBtn.layoutIfNeeded()
        registerSellerWidth.constant = 110
        registSellerBtn.layoutIfNeeded()
        
        registSellerBtn.setTitleColor(UIColor(hexString: "674cf3"), for: .normal)
        registerASellerLbl.backgroundColor = UIColor(hexString: "674cf3")
        registerASellerLbl.isHidden = false
        mappedbtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        mappedSellerLbl.isHidden = true
        unmappedBtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        unMappedSellerLbl.isHidden = true
        
        titleLbl.text = "Register A New Seller"
        searchAndOPtionBtn.isHidden = true
        searchAndMoreImageView.isHidden = true
        indexColor = 2
        isUnMappedSellerInt = 0
        tab = 2

        tabTableview.reloadData()
    }
    @IBAction func unmappedBtnAct(_ sender: Any) {
        unMappedLblWidth.constant = 134
        unMappedSellerLbl.layoutIfNeeded()
        mappedLblWidth.constant = 90
        mappedSellerLbl.layoutIfNeeded()
        registLblWidth.constant = 100
        registerASellerLbl.layoutIfNeeded()
        
        unmappedBtnWidth.constant = 134
        unmappedBtn.layoutIfNeeded()
        mappedBtnWidth.constant = 80
        mappedbtn.layoutIfNeeded()
        registerSellerWidth.constant = 80
        registSellerBtn.layoutIfNeeded()
        unmappedBtn.setTitleColor(UIColor(hexString: "674cf3"), for: .normal)
        unMappedSellerLbl.backgroundColor = UIColor(hexString: "674cf3")
        unMappedSellerLbl.isHidden = false
        mappedbtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        mappedSellerLbl.isHidden = true
        registSellerBtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        registerASellerLbl.isHidden = true
        searchAndOPtionBtn.isHidden = false
        searchAndMoreImageView.isHidden = false
        titleLbl.text = "List Of Un-Mapped Sellers"
        searchAndMoreImageView.image = UIImage(named: "more")
        
        tab = 1
        btn = 1
        indexColor = 1
        isUnMappedSellerInt = 1

        
        
        tabTableview.reloadData()
    }
    @IBAction func mappedBtnAct(_ sender: Any) {
        mappedLblWidth.constant = 102
        mappedSellerLbl.layoutIfNeeded()
        unMappedLblWidth.constant = 134
        unMappedSellerLbl.layoutIfNeeded()
        registLblWidth.constant = 110
        registerASellerLbl.layoutIfNeeded()
        
        
        
        mappedBtnWidth.constant = 102
        mappedbtn.layoutIfNeeded()
        unmappedBtnWidth.constant = 134
        unmappedBtn.layoutIfNeeded()
        registerSellerWidth.constant = 110
        registSellerBtn.layoutIfNeeded()
        
        mappedbtn.setTitleColor(UIColor(hexString: "674cf3"), for: .normal)
        mappedSellerLbl.isHidden = false
        mappedSellerLbl.backgroundColor = UIColor(hexString: "674cf3")
        unmappedBtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        unMappedSellerLbl.isHidden = true
        registSellerBtn.setTitleColor(UIColor(hexString: "002f4f",alpha: 0.50), for: .normal)
        registerASellerLbl.isHidden = true
        searchAndOPtionBtn.isHidden = false
        searchAndMoreImageView.isHidden = false
        titleLbl.text = "List Of the Sellers"
        searchAndMoreImageView.image = UIImage(named: "search_small")
        
        tab = 0
        btn = 0
        indexColor = 0
        isUnMappedSellerInt = 0
        mappedSeller()
        tabTableview.reloadData()
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
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
    //Mark : Search And option Btn Act
    
    @IBAction func searchAndOptionBtnAct(_ sender: Any) {
        if btn == 0 {
            self.searchView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(self.searchView!)
        }else{
            self.RetrievalOptionView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            RetrievalOptionView?.searchDelegate = self;
            RetrievalOptionView?.delegate = self
            self.view.addSubview(self.RetrievalOptionView!)
        }
    }
    
}

extension OrderToSellerVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            if isUnMappedSellerInt == 1{
                
                return CGSize(width: 200.0, height: 100.0)

            }else{
                return CGSize(width: 150.0, height: 100.0)

            }
        }
    
}
  
extension OrderToSellerVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tab == 0 {
            return mappedSellerModel?.payloadJson?.data?.count ?? 0
        }else if tab == 1{
            if searchTapped == 0{
                return osSellerModel?.payloadJson?.data?.count ?? 0
            }else{
               return searchUnMappedModel?.payloadJson?.data?.count ?? 0
            }
            
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tab == 0{
            let MSTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MSTableViewCell", for: indexPath)as! MSTableViewCell
            MSTableViewCell.setPriorityBtn.tag = indexPath.row
            MSTableViewCell.setPriorityBtn.addTarget(self, action: #selector(priorityBtnAct), for: .touchUpInside)

            MSTableViewCell.pharmaLbl.text = mappedSellerModel?.payloadJson?.data?[indexPath.row].cSellerName ?? ""
            return MSTableViewCell
        }else if tab == 1{
            
            let UMSTableCell = tableView.dequeueReusableCell(withIdentifier: "UMSTableCell", for: indexPath)as! UMSTableCell
            UMSTableCell.addbtn.tag = indexPath.row
            UMSTableCell.addbtn.addTarget(self, action: #selector(unMappedaddBtnAct), for: UIControl.Event.touchUpInside)
            if searchTapped == 0{
            UMSTableCell.pharmalbl.text = osSellerModel?.payloadJson?.data?[indexPath.row].cSellerName
            UMSTableCell.sellerCode.text = osSellerModel?.payloadJson?.data?[indexPath.row].cSellerCode
            UMSTableCell.stateName.text = osSellerModel?.payloadJson?.data?[indexPath.row].cStateName
            UMSTableCell.cityNameLbl.text = osSellerModel?.payloadJson?.data?[indexPath.row].cCityName
            UMSTableCell.allOverLbl.text = "All over \(osSellerModel?.payloadJson?.data?[indexPath.row].cAreaName ?? "")"
                return UMSTableCell
            }else{
                UMSTableCell.pharmalbl.text = searchUnMappedModel?.payloadJson?.data?[indexPath.row].cSellerName
                UMSTableCell.sellerCode.text = searchUnMappedModel?.payloadJson?.data?[indexPath.row].cSellerCode
                UMSTableCell.stateName.text = searchUnMappedModel?.payloadJson?.data?[indexPath.row].cStateName
                UMSTableCell.cityNameLbl.text = searchUnMappedModel?.payloadJson?.data?[indexPath.row].cCityName
                UMSTableCell.allOverLbl.text = "All over \(searchUnMappedModel?.payloadJson?.data?[indexPath.row].cAreaName ?? "")"
                
                return UMSTableCell
            }

            
        }else{
            let UMSTableCell = tableView.dequeueReusableCell(withIdentifier: "registerTableCell", for: indexPath)as! registerTableCell
        
            return UMSTableCell
        }
        
    }
    
    @objc func priorityBtnAct(sender:UIButton){
        mappedSelectedInx = sender.tag
        self.SetPriorityView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.SetPriorityView?.prioritySelectedInx = Int(mappedSellerModel?.payloadJson?.data?[sender.tag].cPriority ?? "0") ?? 0
        self.SetPriorityView?.oToSdelegate = self
        self.SetPriorityView?.numArr = self.priorityInt
        
        self.view.addSubview(self.SetPriorityView!)
    }
}
//MARK UNMAPPED ADD BTN ACT
extension OrderToSellerVC{
    @objc func unMappedaddBtnAct(sender:UIButton){
        if searchTapped == 0 {
            print(osSellerModel?.payloadJson?.data?[sender.tag].cSellerCode)
            addAsellerApi(sellerCodeStr: osSellerModel?.payloadJson?.data?[sender.tag].cSellerCode ?? "")
        }else{
            print(searchUnMappedModel?.payloadJson?.data?[sender.tag].cSellerCode)
            addAsellerApi(sellerCodeStr: searchUnMappedModel?.payloadJson?.data?[sender.tag].cSellerCode ?? "")
        }
        
        
    }
}
//MARK: - SearchDelegate
extension OrderToSellerVC : searchdelegate{
    func searchTxt(text: String) {
        if text.count > 2{
            searchUnMappedList(searchText: text)
            
        }else{
            searchUnMappedList(searchText: text)
        }
        
    }
 
}
extension OrderToSellerVC: retrivalDelegate{
    func retrivetapped(type: String) {
        print("ok")
        
        let orderToSellerFilterVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderToSellFiltterVC") as! OrderToSellFiltterVC
        self.navigationController?.pushViewController(orderToSellerFilterVC, animated: true)
        
        
    }
}
extension OrderToSellerVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
//MARK: - Api
extension OrderToSellerVC :WebServiceDelegate {
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }

    func mappedSeller(){
        showActivityIndicator(self.view)
        self.priorityInt.removeAll()
        
        let orderSellerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "OrderSellerList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let orderSellerParams = ["n_page":0,
                               "n_limit":10,
                                 "c_mobile_no":UserDefaults.standard.value(forKey: usernameConstantStr)]

            let orderSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(orderSellerHeader)

        orderSellerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+MAPPED_SELLER_LIST, type: .post, userData: orderSellerParams, apiHeader: orderSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.mappedSellerModel = MpdSellerModel(object:dict)
            
            if boolSuccess {
                
                if mappedSellerModel?.appStatusCode == 0{
                    for (inx,_) in (self.mappedSellerModel?.payloadJson?.data)!.enumerated(){
                      
                                self.priorityInt.append(inx + 1)

                         
                    }
                    tabTableview.reloadData()
                    tabTableview.bottomRefreshControl?.endRefreshing()
                }else{
                    tabTableview.reloadData()
                    tabTableview.bottomRefreshControl?.endRefreshing()
                }
                
                

            }else{
                tabTableview.bottomRefreshControl?.endRefreshing()

            }
            hideActivityIndicator(self.view)

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            tabTableview.bottomRefreshControl?.endRefreshing()
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
    func unSellerList(){
        showActivityIndicator(self.view)
        
        let orderSellerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "OrderSellerList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let orderSellerParams = ["n_page":0,
                               "n_limit":20]

            let orderSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(orderSellerHeader)

        orderSellerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ORDER_TO_SELLER_LIST_URL, type: .post, userData: orderSellerParams, apiHeader: orderSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.osSellerModel = OrderSellerList(object:dict)
            searchTapped = 0
            if boolSuccess {
                tabTableview.reloadData()
                tabTableview.bottomRefreshControl?.endRefreshing()
            }else{
                tabTableview.bottomRefreshControl?.endRefreshing()

            }
            hideActivityIndicator(self.view)

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            tabTableview.bottomRefreshControl?.endRefreshing()
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
    func searchUnMappedList(searchText : String ){
        showActivityIndicator(self.view)
        
        let searchUnMappedList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "searchUnMappedList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let searchUnMappedParams = ["c_name":searchText ,"n_page":"0","n_limit":"10"]

            let searchUnMappedHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(searchUnMappedHeader)

        searchUnMappedList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_UNMAPPED_LIST_URL, type: .post, userData: searchUnMappedParams, apiHeader: searchUnMappedHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.searchUnMappedModel = OrderSellerList(object:dict)
            searchTapped = 1

            if boolSuccess {
                if searchUnMappedModel?.appStatusCode == 0 {
                    tabTableview.reloadData()
                    tabTableview.bottomRefreshControl?.endRefreshing()
                   
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.searchUnMappedModel?.messages?[0], style: .info)
                    banner.showToast(message: self.searchUnMappedModel?.messages?[0] ?? "", view: self.view)
                    tabTableview.bottomRefreshControl?.endRefreshing()
                }

            }else{
                        
                tabTableview.bottomRefreshControl?.endRefreshing()
                
            }
            hideActivityIndicator(self.view)

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            tabTableview.bottomRefreshControl?.endRefreshing()
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
    func searchUnMappedListWithState(){
        showActivityIndicator(self.view)
        
        let searchUnMappedListState:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "searchUnMappedListState")
        

        
        let searchUnMappedParams = ["c_state" : aStateStr,
                                    "c_city" : aCityStr,
                                    "c_area" : aAreaStr,"n_page":"0","n_limit":"5"]
        print(searchUnMappedParams)

            let searchUnMappedHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(searchUnMappedHeader)

        searchUnMappedListState.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SEARCH_BY_CITY_STATE_AREA_URL, type: .post, userData: searchUnMappedParams, apiHeader: searchUnMappedHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(LIVE_ORDER_HOSTURL+SEARCH_BY_CITY_STATE_AREA_URL)
            print(dict)
            self.searchUnMappedModel = OrderSellerList(object:dict)
            searchTapped = 1

            if boolSuccess {
                if searchUnMappedModel?.appStatusCode == 0 {
                    tabTableview.reloadData()
                    tabTableview.bottomRefreshControl?.endRefreshing()
                   
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.searchUnMappedModel?.messages?[0], style: .info)
                    banner.showToast(message: self.searchUnMappedModel?.messages?[0] ?? "", view: self.view)
                    tabTableview.bottomRefreshControl?.endRefreshing()
                }

            }else{
                tabTableview.bottomRefreshControl?.endRefreshing()

            }
            hideActivityIndicator(self.view)

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            tabTableview.bottomRefreshControl?.endRefreshing()
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
    
    
    func addAsellerApi(sellerCodeStr:String){
        showActivityIndicator(self.view)
        
        let addAseller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "addAseller")
        

        
        let addAsellerParams = ["c_seller_code":sellerCodeStr]
        print(addAsellerParams)

            let addAsellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(addAsellerHeader)

        addAseller.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_A_SELLER_URL, type: .post, userData: addAsellerParams, apiHeader: addAsellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            
            print(dict)
            self.addasellerModel = AddASellerModel(object:dict)
            

            if boolSuccess {
                if addasellerModel?.appStatusCode == 0 {
                //    tabTableview.reloadData()
                    unSellerList()
                    let banner = NotificationBanner(title: "Message", subtitle: self.addasellerModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addasellerModel?.messages?[0] ?? "", view: self.view)
                   
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addasellerModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addasellerModel?.messages?[0] ?? "", view: self.view)
                }

            }else{
                        

            }
            hideActivityIndicator(self.view)

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
    func priority(c_buyer_codeStr:String ,c_priorityStr:String,c_sellerStr:String,c_seller_codeStr:String){
        showActivityIndicator(self.view)
        
        let searchUnMappedList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "searchUnMappedList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let priorityParams = ["c_buyer_code":c_buyer_codeStr ,"c_priority":c_priorityStr,"c_seller":c_sellerStr,"c_seller_code":c_seller_codeStr]
print(priorityParams)
            let priorityHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(priorityHeader)

        searchUnMappedList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+OTOS_PRIORITY_URL, type: .post, userData: priorityParams, apiHeader: priorityHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.priorityModel = PriorityBaseClass(object:dict)

            if boolSuccess {
                if priorityModel?.appStatusCode == 0 {
                    let banner = NotificationBanner(title: "Message", subtitle: self.priorityModel?.messages?[0], style: .info)
                    banner.showToast(message: self.priorityModel?.messages?[0] ?? "", view: self.view)
                    SetPriorityView?.removeFromSuperview()
                    mappedSeller()
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.priorityModel?.messages?[0], style: .info)
                    banner.showToast(message: self.priorityModel?.messages?[0] ?? "", view: self.view)
                    SetPriorityView?.removeFromSuperview()

                }

            }else{
                SetPriorityView?.removeFromSuperview()

                
            }
            hideActivityIndicator(self.view)

        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            tabTableview.bottomRefreshControl?.endRefreshing()
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
            SetPriorityView?.removeFromSuperview()

        })
        
        
        }

    
}
extension UICollectionView {
    func scrollToLastItem(at scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally, animated: Bool = true) {
        let lastSection = numberOfSections - 1
        guard lastSection >= 0 else { return }
        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: animated)
    }
}
//MARK: - Pass delegate
extension OrderToSellerVC:orderToSellerDelegate{
    func orderToSellerPassVal(type: Int) {
        print(type)
        
        priority(c_buyer_codeStr:mappedSellerModel?.payloadJson?.data?[mappedSelectedInx].cBuyerCode ?? "" , c_priorityStr: "\(type)", c_sellerStr: mappedSellerModel?.payloadJson?.data?[mappedSelectedInx].cSellerName ?? "", c_seller_codeStr: mappedSellerModel?.payloadJson?.data?[mappedSelectedInx].cSellerCode ?? "")
    }
    
    
    
}

