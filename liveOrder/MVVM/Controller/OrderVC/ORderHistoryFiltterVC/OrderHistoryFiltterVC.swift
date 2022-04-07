//
//  OrderHistoryFiltterVC.swift
//  liveOrder
//
//  Created by Data Prime on 04/12/21.
//

import UIKit
import Alamofire
protocol passArray{
    func passArray(arr:[String])
}

class OrderHistoryFiltterVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var retrivelLbl: UILabel!
    @IBOutlet weak var paymentStatusLbl: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var dotView: DashedLineView!
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    var catIndx = 0
    var catlist = ["Sellers","Payment Status"]
    var sellerCheckInt = [Int]()
    var payCheckInt = [Int]()
    var paymentResultArray = ["Outstanding","Settled"]
    var orderHistoryModel : OrderHistoryModel?
    var sellerCodeArr = [String]()
    var passDel:passArray?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for (i,indx) in paymentResultArray.enumerated(){
            payCheckInt.append(0)
            
        }
        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        orderHistoryList()
        searchTxtField.placeholder = "Search State"
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search_icon")
        imageView.image = image
        
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        
        padView.addSubview(imageView)
        searchTxtField.leftView = padView
        searchTxtField.translatesAutoresizingMaskIntoConstraints = false
        searchTxtField.leftViewMode = .always
        
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5217301325)
        
        self.topView.backgroundColor = UIColor(hexString: "092448", alpha: 0.54)
        catTableView.delegate = self
        catTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.dataSource = self
        catTableView.register(UINib(nibName: "FiltterCatListTableViewCell", bundle: nil), forCellReuseIdentifier: "FiltterCatListTableViewCell")
        resultTableView.register(UINib(nibName: "OptionLIstTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionLIstTableViewCell")
    }
    
    @IBAction func applyBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as! LoHomeViewController
        passDel?.passArray(arr: sellerCodeArr)
        sellerSelectCount = sellerCodeArr.count

        vc.loged = 2
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func closeBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeVC") as! LoHomeVC
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clearBtnAct(_ sender: Any) {
        
        sellerCheckInt.removeAll()
        sellerCodeArr.removeAll()
//        for (_,indx) in (orderHistoryModel?.payloadJson?.data?.jList)!.enumerated(){
//            sellerCheckInt.append(0)
//            sellerCodeArr.append("0")
//
//        }
        
        self.resultTableView.reloadData()
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
extension OrderHistoryFiltterVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == catTableView {
            return catlist.count
        }
        if tableView == resultTableView{
            if catIndx == 0{
                return orderHistoryModel?.payloadJson?.data?.jList?.count ?? 0
            }else{
                return paymentResultArray.count
            }
            
            
        }
       return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == catTableView {
            let filttercell = tableView.dequeueReusableCell(withIdentifier: "FiltterCatListTableViewCell") as! FiltterCatListTableViewCell
            filttercell.catListLbl.text = catlist[indexPath.row]
            filttercell.selectedBackgroundView?.backgroundColor = .white
            if indexPath.row == catIndx{
                filttercell.overView.backgroundColor = .white
                filttercell.backgroundColor = .white
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40")
               
            }else{
                filttercell.catListLbl.textColor = UIColor(hexString: "343a40",alpha:  0.50)
                filttercell.overView.backgroundColor = UIColor(hexString: "c3cde4",alpha:  0.30)
            }
           
            return filttercell
        }
        else{
            let listoptioncell = tableView.dequeueReusableCell(withIdentifier: "OptionLIstTableViewCell") as! OptionLIstTableViewCell
            listoptioncell.checkBoxBtn.tag = indexPath.row
            
            listoptioncell.checkBoxBtn.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
           
            if catIndx == 0{
                listoptioncell.listLbl.text = "\(orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName ?? "")"
               let checkInt = sellerCheckInt[indexPath.row]
                if checkInt == 1{
                    listoptioncell.checkBoxBtn.backgroundColor = UIColor(hexString: "674CF3")
                                       listoptioncell.checkBoxBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
                                       listoptioncell.checkBoxBtn.isSelected = true
                    
                    
                }else{
                    listoptioncell.checkBoxBtn.borderColor = UIColor(hexString: "C3CDE4")
                                       listoptioncell.checkBoxBtn.borderWidth = 1.0
                                       listoptioncell.checkBoxBtn.clipsToBounds = true
                                       listoptioncell.checkBoxBtn.backgroundColor = .white
                                       listoptioncell.checkBoxBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
                                       listoptioncell.checkBoxBtn.isSelected = false
                }
            }else{
                listoptioncell.listLbl.text = paymentResultArray[indexPath.row]
                let checkInt = payCheckInt[indexPath.row]
                if checkInt == 1{
                    listoptioncell.checkBoxBtn.backgroundColor = UIColor(hexString: "674CF3")
                                       listoptioncell.checkBoxBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
                                       listoptioncell.checkBoxBtn.isSelected = true
                }else{
                    listoptioncell.checkBoxBtn.borderColor = UIColor(hexString: "C3CDE4")
                                       listoptioncell.checkBoxBtn.borderWidth = 1.0
                                       listoptioncell.checkBoxBtn.clipsToBounds = true
                                       listoptioncell.checkBoxBtn.backgroundColor = .white
                                       listoptioncell.checkBoxBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
                                       listoptioncell.checkBoxBtn.isSelected = false
                }
            }
           
 
          
            
          
           
            
            
            return listoptioncell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == catTableView{
            if indexPath.row == 0 {
                catIndx = 0
                searchTxtField.text = ""
                searchTxtField.placeholder = "Search State"
                catTableView.reloadData()
                 resultTableView.reloadData()
            }
            else if indexPath.row == 1 {
                catIndx = 1
                searchTxtField.text = ""
                searchTxtField.placeholder = "Search City"
                catTableView.reloadData()
                resultTableView.reloadData()

            }
          

        }else{
            print(self.orderHistoryModel?.payloadJson?.data?.jList?[indexPath.row])
            sellerCheckInt[indexPath.row] = 1
            resultTableView.reloadData()
        }

    }
    @objc func buttonClicked(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        if catIndx == 0{
            if sender.isSelected{
                sellerCheckInt[sender.tag] = 1
                sellerCodeArr[sender.tag] = self.orderHistoryModel?.payloadJson?.data?.jList?[sender.tag].cSellerCode ?? ""
                applyBtn.backgroundColor = .blue

            }else{
                print(self.orderHistoryModel?.payloadJson?.data?.jList?[sender.tag])
                sellerCodeArr[sender.tag] = "0"

                sellerCheckInt[sender.tag] = 0
                
                print(sellerCheckInt)
                applyBtn.backgroundColor = UIColor(hexString: "#C3CDE4")

            }
        }else{
            if sender.isSelected{
                print(paymentResultArray[sender.tag])
                payCheckInt[sender.tag] = 1
                print(payCheckInt)
            }else{
                print(paymentResultArray[sender.tag])
                payCheckInt[sender.tag] = 0
                print(payCheckInt)
            }
        }
       
//        orCheckArray = [sender.tag]
        resultTableView.reloadData()
    }
 
}
extension OrderHistoryFiltterVC:WebServiceDelegate{
   
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
        
        let oHParams = ["c_mobile_no": UserDefaults.standard.value(forKey: usernameConstantStr),
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
                        
                        resultTableView.reloadData()
                        hideActivityIndicator(self.view)
     
                    }else{
                        catIndx = 0

                        for (_,indx) in (orderHistoryModel?.payloadJson?.data?.jList)!.enumerated(){
                            sellerCheckInt.append(0)
                            sellerCodeArr.append("0")
                            
                        }
                        
                        resultTableView.reloadData()
                        hideActivityIndicator(self.view)
                    }
                }else{
                    resultTableView.reloadData()
                    hideActivityIndicator(self.view)

                }
            }else{
                resultTableView.reloadData()
                hideActivityIndicator(self.view)

            }
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
            hideActivityIndicator(self.view)
           
        })
        
        
        }

    
}

