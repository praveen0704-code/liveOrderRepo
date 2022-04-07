//
//  LandingPageVC.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit
import Alamofire




class LandingPageVC: UIViewController,searchDelegate ,mostOrder{
    func share(date: String) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func onPizzaReady(type: String) {
        print(type)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC") as? SearchWithListFeatureProductVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBOutlet weak var supportView: UIView!
    //MARK TOP BAR
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    // SEARCHVIEW
    @IBOutlet weak var searchVView: UIView!
    @IBOutlet weak var searchImgBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var mikeBtn: UIButton!
    @IBOutlet weak var totalTableView: UITableView!
    //MARK BTRNIMG VIEW 
    @IBOutlet weak var notifieImgr: UIImageView!
    @IBOutlet weak var wishListImge: UIImageView!
    @IBOutlet weak var cartImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var shortBookImg: UIImageView!
    
    let searchViewpopup = UINib(nibName: "SearchPopView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? SearchPopView
    let ScanResultFailedView = UINib(nibName: "ScanResultFailedView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? ScanResultFailedView
    var imStringArray : [String] = []
    var sellerCode : [String] = []
    var sellerImg : [String] = []
    var j_seller_lists : [S_seller_lists] = []
    var topMostorderList : [MostOrderList] = []
    var getnewLaunchList : [NewLaunchlist] = []
    
    var bannerListModel:BannerModel?
    
    

     var headers: HTTPHeaders = []
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        
//       headers = ["X-csquare-api-key": key ,"X-csquare-api-token": token,
//        "Content-Type" : "application/json"]
        
       
     setup()
       bannerApiCall()
       sellerapi()
        topMostItemApi()
        newLanchedApi()
        shopbyManifacture()
        limitedPeriodCall()
    
    }
    func setup(){
        
        
        
        DispatchQueue.main.async {
            self.searchViewpopup?.delegate = self
            self.searchViewpopup!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(self.searchViewpopup!)
        }
        profileImg.layer.cornerRadius = 8
        searchTxtField.delegate = self
        totalTableView.dataSource = self
        totalTableView.delegate = self
        searchVView.layer.cornerRadius = 8
        topBarView.clipsToBounds = true
        topBarView.layer.cornerRadius = 30
        topBarView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topBarView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
      
        
        
        
    }
    
    func bannerApiCall(){
        AF.request("https://dev-lc.livc.in/c2/lc/ms/mst/g/banner",method: .get, headers: headers).responseJSON { response in
            //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
                
                if let banner = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                    
                    
                    for i in banner{
                        self.imStringArray.append(i.value(forKey: "c_banner_image_url") as! String)
                        self.imStringArray.append(i.value(forKey: "c _redirect_url") as! String)
                    }
                    
                    self.totalTableView.reloadData()
                    
                }
                
            }catch{
                
            }
        }
    }
    
    func sellerapi (){
        
        let json: [String: Any] = ["c_pincode": "641668","n_page":"1","n_limit":"5"]
        AF.request(baseURL + ApiService.SellerInspiredUrlStr,method: .post,parameters: json, headers: headers).responseJSON { [self] response in
           //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
            
            if let seller = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                
                
               print(seller)
                if let jsonData = seller[0].value(forKey: "j_seller_lists") as? [NSDictionary]{
                    print(jsonData)
                    
                    for i in jsonData{
                        
                        let obj = S_seller_lists()
                        
                        obj.c_seller_code = i.value(forKey: "c_seller_code") as? String
                        
                        obj.c_seller_image = i.value(forKey: "c_seller_image") as? String
                        
                        obj.c_seller_name = i.value(forKey: "c_seller_name") as? String
                        
                        self.j_seller_lists.append(obj)
                    
                    }
                    
                    print(j_seller_lists)
                
                    self.totalTableView.reloadData()

                }
                
            
                                
            }
            
            }catch{
                
            }
        }
       

    }
    func topMostItemApi(){
        let json: [String: Any] = ["c_pincode": "641668","n_page":"1","n_limit":"5"]
        AF.request(baseURL + ApiService.topMostItemStr,method: .post,parameters: json, headers: headers).responseJSON { response in
           //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
            
            if let topMostItem = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                
                
               print(topMostItem)
                if let jsonData = topMostItem[0].value(forKey: "j_item_lists") as? [NSDictionary]{
                    print(jsonData)
                    for i in jsonData{
                        let obje = MostOrderList()
                        obje.ac_thumbnail_images = i.value(forKey: "ac_thumbnail_images") as? String
                        obje.c_contain_name = i.value(forKey: "c_contain_name") as? String
                        obje.c_discount_status = i.value(forKey: "c_discount_status") as? String
                        obje.c_item_code = i.value(forKey: "c_item_code") as? String
                        obje.c_item_name = i.value(forKey: "c_item_name") as? String
                        obje.c_pack_name = i.value(forKey: "c_pack_name") as? String
                        obje.c_shortbook_status = i.value(forKey: "c_shortbook_status") as? String
                        obje.c_watchlist_status = i.value(forKey: "c_watchlist_status") as? String
                        obje.n_max_mrp = i.value(forKey: "n_mrp") as? String
                        
                        self.topMostorderList.append(obje)
                    }
                    print(self.topMostorderList)
                
                    self.totalTableView.reloadData()
                }
                
            
                                
            }
            
            }catch{
                
            }
        }

        
    }
    func newLanchedApi(){
        let json: [String: Any] = ["n_page":"1","n_limit":"5"]
        AF.request(baseURL + ApiService.NewLanchedStr,method: .post,parameters: json, headers: headers).responseJSON { response in
           //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
            
            if let newLaunch = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                
                
               print(newLaunch)

                
                
                 if let jsonData = newLaunch[0].value(forKey: "j_item_lists") as? [NSDictionary]{
                     print(jsonData)
                     for i in jsonData{
                         let obje = NewLaunchlist()
                         obje.ac_thumbnail_images = i.value(forKey: "ac_thumbnail_images") as? String
                         obje.c_contain_name = i.value(forKey: "c_contain_name") as? String
                         obje.c_discount_status = i.value(forKey: "c_discount_status") as? String
                         obje.c_item_code = i.value(forKey: "c_item_code") as? String
                         obje.c_item_name = i.value(forKey: "c_item_name") as? String
                         obje.c_pack_name = i.value(forKey: "c_pack_name") as? String
                         obje.c_shortbook_status = i.value(forKey: "c_shortbook_status") as? String
                         obje.c_watchlist_status = i.value(forKey: "c_watchlist_status") as? String
                         obje.n_max_mrp = i.value(forKey: "n_mrp") as? String
                         
                         self.getnewLaunchList.append(obje)
                     }
                     print(self.getnewLaunchList)
                 
                     self.totalTableView.reloadData()
                 }
                 
                                
            }
            
            }catch{
                
            }
        }

    }
    func shopbyManifacture(){
        let json: [String: Any] = ["n_page":"1","n_limit":"5"]
        AF.request(baseURL + ApiService.ShopFromManifacture,method: .post,parameters: json, headers: headers).responseJSON { response in
           //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
            
            if let shopFromMani = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                
                
               print(shopFromMani)

                
            
                                
            }
            
            }catch{
                
            }
        }
    }
    func limitedPeriodCall(){
        let json: [String: Any] = ["n_page":"1","n_limit":"5"]
        AF.request(baseURL + ApiService.LimitedPeriodStr,method: .post,parameters: json, headers: headers).responseJSON { response in
           //Parse or print your response.
            print(response)
            do{
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
            
            if let limitedOffer = json?.value(forKey: "payloadJson") as? [NSDictionary]{
                
                
               print(limitedOffer)

                
            
                                
            }
            
            }catch{
                
            }
        }
    }
    @IBAction func notificationBtnAct(_ sender: Any) {
    }
    @IBAction func wiahListBtnAct(_ sender: Any) {
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
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func profileBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func menuBtnAct(_ sender: Any) {
    }
    @IBAction func scanBtnAct(_ sender: Any) {
       
        ScanResultFailedView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(ScanResultFailedView!)
    }
    @IBAction func mikeBtnAct(_ sender: Any) {
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
extension LandingPageVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    // Set the spacing between sections
     
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            totalTableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")

                let listcell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath)as! BannerTableViewCell
                    
                    
                        
                return listcell
                
            }
        if indexPath.row == 1 {
            totalTableView.register(UINib(nibName: "favouriteSellerTavleViewcell", bundle: nil), forCellReuseIdentifier: "favouriteSellerTavleViewcell")

                let sellercell = tableView.dequeueReusableCell(withIdentifier: "favouriteSellerTavleViewcell", for: indexPath)as! favouriteSellerTavleViewcell
            
                sellercell.seller(data: j_seller_lists)
            
                return sellercell
                
            }
        if indexPath.row == 2 {
            totalTableView.register(UINib(nibName: "MostOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MostOrderTableViewCell")

                let mostOrdercell = tableView.dequeueReusableCell(withIdentifier: "MostOrderTableViewCell", for: indexPath)as! MostOrderTableViewCell
            mostOrdercell.delegate = self
            
            mostOrdercell.order(data: topMostorderList)
                return mostOrdercell
                
            }
        if indexPath.row == 3 {
                totalTableView.register(UINib(nibName: "NewLaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "NewLaunchTableViewCell")

                    let sellercell = tableView.dequeueReusableCell(withIdentifier: "NewLaunchTableViewCell", for: indexPath)as! NewLaunchTableViewCell
            sellercell.order(data: getnewLaunchList)
                    return sellercell
                    
                }
        if indexPath.row == 4 {
                totalTableView.register(UINib(nibName: "ShopByManifactureTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopByManifactureTableViewCell")

                    let sellercell = tableView.dequeueReusableCell(withIdentifier: "ShopByManifactureTableViewCell", for: indexPath)as! ShopByManifactureTableViewCell
                
                    return sellercell
                    
                }
        if indexPath.row == 5 {
                totalTableView.register(UINib(nibName: "LimitedOfferTableViewCell", bundle: nil), forCellReuseIdentifier: "LimitedOfferTableViewCell")

                    let sellercell = tableView.dequeueReusableCell(withIdentifier: "LimitedOfferTableViewCell", for: indexPath)as! LimitedOfferTableViewCell
                
                    return sellercell
                    
                }
        if indexPath.row == 6 {
                totalTableView.register(UINib(nibName: "CsqureTableViewCell", bundle: nil), forCellReuseIdentifier: "CsqureTableViewCell")

                    let csqureCell = tableView.dequeueReusableCell(withIdentifier: "CsqureTableViewCell", for: indexPath)as! CsqureTableViewCell
                
                    return csqureCell
                    
                }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 185
        }
        if indexPath.row == 1 {
            return 214
        }
        if indexPath.row == 2 {
            return 380
        }
        if indexPath.row == 3 {
            return 330
        }
        if indexPath.row == 4 {
            return 180
        }
        if indexPath.row == 5 {
            return 230
            
        }
        if indexPath.row == 6 {
            return 250
        }
        
        else{
            return 50
        }
    }
   
    
}
extension LandingPageVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == searchTxtField {
               print("You edit myTextField")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LcMainSearchVC") as? LcMainSearchVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
           
           }
}
}
extension LandingPageVC:WebServiceDelegate{
        func webServiceGotExpiryMessage(errorMessage: String) {
            
            
        }
    
        func bannerApiCall(areaCodeStr:String){
           
            
            let bannerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "BannerList")
            
    //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
    //                                    "X-csquare-api-token":"1371757505f37f2c",
    //                                    "Content-Type":"application/json",
    //                                        ]

            let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

            bannerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+BANNER_URL, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                self.bannerListModel = BannerModel(object:dict)
                if boolSuccess {
                   
                    if self.bannerListModel?.appStatusCode == 0{
                        
                        
                    }else{
                        
                    }
                    
                    

                }else{
                            

                }
                
            }, failureBlock: {[unowned self] (errorMesssage) in
               
            })
            
            
            }
        

        
       

        
    }



