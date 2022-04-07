//
//  OrderVC.swift
//  liveOrder
//
//  Created by Data Prime on 24/11/21.
//

import UIKit
import Alamofire
import LazyImage

class OrderVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var allOrderView: UIView!
   
    @IBOutlet weak var allOrderBtn: UIButton!
    @IBOutlet weak var frequentlyOrderBtn: UIButton!
    @IBOutlet weak var dotView: DashedLineView!
    @IBOutlet weak var allOrderBottomLbl: UILabel!
    @IBOutlet weak var frequenlyBottomLbl: UILabel!
    @IBOutlet weak var lastMonthLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var moreImgView: UIImageView!
    @IBOutlet weak var orderTableView: UITableView!
    
    
    @IBOutlet weak var calenderContainerView: UIView!
    
    
    let optionView = UINib(nibName: "OrderHistoryOptionView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? OrderHistoryOptionView
    let docView = UINib(nibName: "DownloadView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? DownloadView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    
   
    
    var orderHistoryModel : OrderHistoryModel?
    
    var currentDate : String?
    var beforeSixMonthDate : String?
    lazy var productsLazyImage:LazyImage = LazyImage()
    var downbtnact : Int?
    var errorMesg = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
       // MARK : - Date Getting
        print(Date.getCurrentDate())

      print(runOnce)
        if runOnce == 0{
            
            let date = Date.getCurrentDate()
            currentDate = "\(date)"
            let  sub = SubtractMonth(month: -6)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: sub)
            print(dateString)
            beforeSixMonthDate = "\(dateString)"
            orderHistoryList()
            runOnce = 1
            
        }else{
           print("deleate call")
            runOnce = 0
           orderHistoryList()


        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
       // calenderContainerView.isHidden = true
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if downbtnact == 0{
            downbtnact = 5
            orderTableView.reloadData()
        }
    }
  
    func SubtractMonth(month:Int)->Date{
      return Calendar.current.date(byAdding: .month, value: month, to: Date())!
        
    }
   
    
    func setup(){
        orderTableView.delegate = self
        orderTableView.dataSource = self
        frequenlyBottomLbl.isHidden = true
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .leftToRight)
        orderTableView.register(UINib(nibName: "OrderTableCell", bundle: nil), forCellReuseIdentifier: "OrderTableCell")
      //  topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
    }
    
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as! LoHomeViewController

        vc.loged = 3
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func moreBtnAct(_ sender: Any) {
        optionView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        optionView?.delegate = self
        UIView.transition(with: optionView!, duration: 0.25, options: .curveEaseIn, animations: {
            self.view.addSubview(self.optionView!)
                self.view.bringSubviewToFront(self.optionView!)
            }, completion: nil)
               //Add the view
     //   self.view.addSubview(optionView!)
        
    }
    @IBAction func frequentlyOrderBtnAct(_ sender: Any) {
    }
    
    @IBAction func allOrderBtnAct(_ sender: Any) {
    }
}
extension OrderVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSec : Int = 0
        if errorMesg == true{
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.tag = 201
            noRecordsErrorView.noHistoryLbl.isHidden = false
            noRecordsErrorView.nothingHereLbl.textColor = UIColor.red
            noRecordsErrorView.nothingHereLbl.text = "Oops.!products not found."
            orderTableView.backgroundView = noRecordsErrorView
            orderTableView.isScrollEnabled = false
            numberOfSec = 0
        }else{
            orderTableView.backgroundView = nil
            numberOfSec = 1
        }
        return numberOfSec
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryModel?.payloadJson?.data?.jList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cOrderStatus == "OO"{
            return 592
        }else{
            return 525
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let OrderCell = tableView.dequeueReusableCell(withIdentifier: "OrderTableCell", for: indexPath)as! OrderTableCell
        
        
        if downbtnact == indexPath.row{
            OrderCell.docView.isHidden = false
        }else{
            OrderCell.docView.isHidden = true
        }
        if indexPath.row == 0{
            OrderCell.downLoadBtn.isHidden = false
            OrderCell.downloadImge.isHidden = false
            
        }else{
            OrderCell.downLoadBtn.isHidden = true
            OrderCell.downloadImge.isHidden = true
        }
        
        OrderCell.downLoadBtn.tag = indexPath.row
        OrderCell.downLoadBtn.addTarget(self, action: #selector(docBtnAct), for: .touchUpInside)
        productsLazyImage.showWithSpinner(imageView: OrderCell.MfgImgView, url: orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cSellerLogoImage,defaultImage: "mahaveer"  )
        OrderCell.medicalNameLbl.text = "\(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName ?? "")"
        OrderCell.orderIdLbl.text = "(Order Id: \(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cOrderId ?? ""))"
        OrderCell.orderDataLbl.text = "Ordered Date: \(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cOrderedDate ?? "")"
        OrderCell.itemLbl.text = "\(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cNoOfItemsOrdered ?? "0") Items"
        OrderCell.topAmountlbl.text = "\(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cTotalOrderAmount ?? "0.00")"
        OrderCell.botomAmountLbl.text = "\(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cOutstandingAmount ?? "0.00")"
        let colorString = "Friday, 18 Sep"
        
        OrderCell.deliveryLbl.text =  "Delivery"
        OrderCell.deliveryLbl.setSubTextColor(pSubString: colorString, pColor: UIColor(hexString: "ff7b20"))
        
        let sellerName = orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName?.getAcronyms().uppercased()
        
        
    
      
        OrderCell.alterNameLbl.text = sellerName?.maxLength(length: 2)
        
        OrderCell.alterNameLbl.isHidden = false
        OrderCell.MfgImgView?.isHidden = true
        if orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cOrderStatus == "OP"{
                       
            OrderCell.stepperView.currentStep = 1
            
            

            
        }else{
           
        }
        return OrderCell
    }
    @objc func docBtnAct(sender : UIButton){
        
        downbtnact = 0
        orderTableView.reloadData()
//        docView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//
//        UIView.transition(with: docView!, duration: 0.25, options: .curveEaseIn, animations: {
//            self.view.addSubview(self.docView!)
//                self.view.bringSubviewToFront(self.docView!)
//            }, completion: nil)
    }
    
}
extension OrderVC : retrivalBtnDelegate{
    func retrivalBtnAct(taped: String, isDatePickerInt: Int) {
        if isDatePickerInt == 1{
            self.optionView?.removeFromSuperview()

         //   calenderContainerView.isHidden = false

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LCalenderViewController") as! LCalenderViewController
            
            
            vc.isProfileInfoInt = 0
            vc.dateDelegare = self


            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: false)
//
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderHistoryFiltterVC") as! OrderHistoryFiltterVC
           
            vc.passDel = self
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
   
    
    
}
extension OrderVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}

extension OrderVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func orderHistoryList(){
        showActivityIndicator(self.view)
        
        
        let orderHistory:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "orderHistory")
        
//            let nHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
//                                        "X-csquare-api-token":"-448945721a86225",
//                                        "Content-Type":"application/json",
//                                            ]
        let cmobile_noStr  = UserDefaults.standard.value(forKey:usernameConstantStr) as! String
        let oHParams = ["c_from_date": beforeSixMonthDate ?? "",
                        "c_mobile_no": cmobile_noStr,
                        "c_to_date": currentDate ?? "",
                        "j_seller_code":jsellerCodeArr,
                        "n_limit": 15,
                        "n_page": 0] as [String : Any]
        print(oHParams)
        let oHHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        orderHistory.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ORDER_HISTORY_URL, type: .post, userData: oHParams, apiHeader: oHHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.orderHistoryModel = OrderHistoryModel(object:dict)
            if boolSuccess {
               
                if self.orderHistoryModel?.appStatusCode == 0{
                    if self.orderHistoryModel?.payloadJson?.data?.jList?.count == 0{
                        errorMesg = true


                        orderTableView.reloadData()
                        hideActivityIndicator(self.view)

                    }else{
                        errorMesg = false

                        orderTableView.reloadData()
                        hideActivityIndicator(self.view)

                    }
                   


                }else{
                    hideActivityIndicator(self.view)
                    errorMesg = true
                    orderTableView.reloadData()

                }
                

            }else{
                hideActivityIndicator(self.view)
                errorMesg = true
                orderTableView.reloadData()



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
            errorMesg = true
            orderTableView.reloadData()



        })
        
        
        }
   
     func addChildView(viewController: UIViewController, in view: UIView) {
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewController.view.frame = view.bounds
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
     }
    
}
extension OrderVC:fromToDateDelegate{
    func passDate(dateStr: String) {
        
    }
    
    func passFromToData(fromDateStr: String, toDateStr: String) {
       
        beforeSixMonthDate = fromDateStr
        currentDate = toDateStr
        runOnce = 1
    }
    
    
}
extension OrderVC:passArray{
    func passArray(arr: [String]) {
        //runOnce = 1
        jsellerCodeArr = arr
        //orderHistoryList()
    }
    
    
}


