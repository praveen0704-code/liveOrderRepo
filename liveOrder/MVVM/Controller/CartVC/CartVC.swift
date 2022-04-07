//
//  CartVC.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift

class CartVC: UIViewController ,viewCouponDelegate,editBtnDelegate{
    
   
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartLbl: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    let DiscountDetailsView = UINib(nibName: "DiscountDetailsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? DiscountDetailsView
    let ChangeAddressView = UINib(nibName: "ChangeAddressView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? ChangeAddressView
    let ChangeBranchView = UINib(nibName: "ChangeBranchView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? ChangeBranchView
    var selectedIndexone : NSInteger! = -1
    var selectedIndextwo : NSInteger! = -1
    var selectVal = 0
    var arrowimg = false
    var arrowimgtwo = false
    var cartlistModel : CartListModel?
    var tableViewHeightFloat = CGFloat()
    var getBranchListModel : GetBrListModel?
    var getBranchDetailsModel : GetBranchDetailsModel?
    var defaultBrName : String?
    var defaultBrCode : String?
    var cityName:String?
    var pinCode:String?
    var runOceInnt = Int()
    var cartValRunOnce = Int()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
       // tableViewHeightFloat = 50.0
        
        NotificationCenter.default.addObserver(self,selector: #selector(hideContainerView),name: NSNotification.Name(rawValue: "HideViewNotify"),object: nil)
       
    }
    
    @objc func hideContainerView() {
        print("a")
         tableViewHeightFloat = cartTableHeightFloat
         print(cartTableHeightFloat)
         print(tableViewHeightFloat)
         cartTableView.reloadData()
        
        
    }
 

    func setup(){
        getBranchList()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        bottomView.backgroundColor = .white
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor(hexString: "dbdbdb", alpha: 0.50).cgColor
        bottomView.dropShadow()
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        //FIXME: - TaleViewCell
        cartTableView.register(UINib(nibName: "CartFirstCell", bundle: nil), forCellReuseIdentifier: "CartFirstCell")
        cartTableView.register(UINib(nibName: "CartSecCell", bundle: nil), forCellReuseIdentifier: "CartSecCell")
        cartTableView.register(UINib(nibName: "CartThirdCell", bundle: nil), forCellReuseIdentifier: "CartThirdCell")
        cartTableView.register(UINib(nibName: "CartFourthCell", bundle: nil), forCellReuseIdentifier: "CartFourthCell")
        cartTableView.register(UINib(nibName: "CartFifthVC", bundle: nil), forCellReuseIdentifier: "CartFifthVC")

    }
    //MARK: - Button Action
    @IBAction func continueBtnAct(_ sender: Any) {
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func viewDetailsBtnAct(_ sender: Any) {
        
        
    }
    //MARK: - Delegate Functions
    func editBtn(type: String) {
        
        if type == "1"{
            self.ChangeBranchView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.ChangeBranchView?.delegate = self
            self.view.addSubview(self.ChangeBranchView!)
        }else{
            self.ChangeAddressView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            ChangeAddressView?.delegate = self
            self.view.addSubview(self.ChangeAddressView!)
        }
       
    }
    
    func details(type: String) {
        self.DiscountDetailsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(self.DiscountDetailsView!)
        
    }
    func cartValeight(heigtFloat: CGFloat) {
        let cartValueIndexPath = IndexPath(row: 2, section: 1)
        
        self.cartTableView.reloadRows(at: [cartValueIndexPath], with: .none)
    }
    
    
   

}

extension CartVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "CartFirstCell", for: indexPath)as! CartFirstCell
            firstCell.secndMedicalNameLbl.text = defaultBrName
            firstCell.madicalsName.text = "\(cityName ?? "") , \(pinCode ?? "")"
            firstCell.delegate = self
          
            
            return firstCell
        }else if indexPath.row == 1 {
            
            let SecCell = tableView.dequeueReusableCell(withIdentifier: "CartSecCell", for: indexPath)as! CartSecCell
            
            
            if arrowimg == true{
                SecCell.arrowImge.image = UIImage(named: "upArrow")
            }else{
                SecCell.arrowImge.image = UIImage(named: "downArrow")
            }
            
            return SecCell
        }else if indexPath.row == 2 {
            
            let ThirdCell = tableView.dequeueReusableCell(withIdentifier: "CartThirdCell", for: indexPath)as! CartThirdCell
            ThirdCell.delegate = self
            if runOceInnt == 1{
                ThirdCell.loadCartDetails()
                runOceInnt = 0
            }
            return ThirdCell
        }else if indexPath.row == 3 {
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "CartFourthCell", for: indexPath)as! CartFourthCell
            firstCell.delegate = self
            if cartValRunOnce == 1{
                firstCell.loadCartValues()
                cartValRunOnce = 0
            }
            
            return firstCell
        }else if indexPath.row == 4 {
            
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "CartFifthVC", for: indexPath)as! CartFifthVC
            
            return firstCell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0
        {
            return 125
        }
        
        else if indexPath.row == 1
        {
            return 0
        }else if indexPath.row == 2
        {
//            if selectVal == 1 {
////                print(tableViewHeightFloat)
//                selectVal = 0
//
//                return tableViewHeightFloat
//            }else{
////                selectVal = 1
//
//                return 50
//            }
            return tableViewHeightFloat
            
        }else if indexPath.row == 3
        {
            return 648
        }else if indexPath.row == 4
        {
            return 10 //400
        }
        else{
            return 60
            
        }
         
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if indexPath.row == selectedIndexone{
                selectedIndexone = -1
                arrowimg = false
               }else{
                selectedIndexone = indexPath.row
                arrowimg = true
               }
           
        }
        if indexPath.row == 2 {
            if indexPath.row == selectedIndextwo{
                selectedIndextwo = -1
                arrowimgtwo = false
               }else{
                selectedIndextwo = indexPath.row
                arrowimgtwo = true
               }
           
        }
        tableView.reloadData()
    }
}
extension CartVC : arrowBtnTappedDelegate{
    func cartTotalAmt(cartTotal: String) {
        print(cartTotal)
       self.amountLbl.text = cartTotal
    }
    
    func arrow(type: String, tableViewHeight: CGFloat) {
        print(tableViewHeight)
        tableViewHeightFloat = tableViewHeight
        print(type)
        selectVal = 1
        cartTableView.reloadData()
    }
    func showBannr(messageStr:String ) {
        let banner = NotificationBanner(title: "Message", subtitle: messageStr, style: .info)
        banner.showToast(message: messageStr ?? "", view: self.view)
    }
    
   
    
    
}
extension CartVC:changeAddDelegate{
    func changeAddBrCode(brCode: String,edit:String) {
        if brCode == "1"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewAddVC") as? AddNewAddVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else  if edit == "1"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewAddVC") as? AddNewAddVC
            vc?.brCode = brCode
            vc?.edit = 1
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            getBranchDetails(brCodeDetails: brCode)
        }
        
    }
    
    
}
extension CartVC : changeBranchapplyBtnDelegate{
    func applyBrCode(brCode: String) {
        getBranchDetails(brCodeDetails: brCode)
    }
    
    
}
extension CartVC : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    
    func getBranchList(){
        
        
        let getBranchList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getBranchList")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let getBranchListParams = ["n_page":"0",
                                   "n_limit":"10"]
        
        let getBranchListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                "Content-Type":"application/json",
        ]
        
        print(getBranchListHeader)
        
        getBranchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_BRANCH_LIST_URL, type: .post, userData: getBranchListParams, apiHeader: getBranchListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.getBranchListModel = GetBrListModel(object:dict)
         //   print(getBranchListModel?.payloadJson?.items?[0].cDefaultStatus)
            if boolSuccess {
                
                
                //            let pro =   self.getBrListModel?.payloadJson?.items!.filter {
                //                    $0.cDefaultStatus == "Y"
                //                }
//                headerLbl.text = "Change Branch ( \(getBranchListModel?.payloadJson?.items?.count ?? 0) )"
//                branchListTableView.reloadData()
//                print(self.branchListTableView.contentSize.height)
//                self.tableHeight.constant = branchListTableView.contentSize.height
//                self.branchListTableView.layoutSubviews()
//                delegate?.branchHeight(tableCellHeight: CGFloat(branchListTableView.contentSize.height))
                for (indx , elem) in self.getBranchListModel!.payloadJson!.items!.enumerated(){
                    print(elem.cDefaultStatus)
                    
                    if elem.cDefaultStatus == "Y"{

                        //defaultBrName = elem.cBrName
                        //defaultBrCode = elem.cBrCode
                        getBranchDetails(brCodeDetails: elem.cBrCode ?? "")

                    }
                }
                cartTableView.reloadData()
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
    func getBranchDetails(brCodeDetails: String){
        
        
        let getBranchDetails:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getBranchDetails")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let getBranchDetailsParams = ["c_br_code": brCodeDetails]
        
        let getBranchDetailsHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                "Content-Type":"application/json",
        ]
        
        print(getBranchDetailsHeader)
        
        getBranchDetails.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_BRANCH_DETAILS, type: .post, userData: getBranchDetailsParams, apiHeader: getBranchDetailsHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.getBranchDetailsModel = GetBranchDetailsModel(object:dict)
        
            if boolSuccess {
                cityName = getBranchDetailsModel?.payloadJson?.data?.cCityName
                pinCode = getBranchDetailsModel?.payloadJson?.data?.cPincode
                defaultBrName = getBranchDetailsModel?.payloadJson?.data?.cFirmName
                defaultBrCode = getBranchDetailsModel?.payloadJson?.data?.cBrCode
                print(defaultBrCode)
                UserDefaults.standard.set(defaultBrCode, forKey:defaultBranchCodeConStr)
                runOceInnt = 1
                cartValRunOnce = 1
                cartTableView.reloadData()
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
}
