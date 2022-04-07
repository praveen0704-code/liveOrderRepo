//
//  CartThirdCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit
import Alamofire
protocol arrowBtnTappedDelegate {
    func arrow(type: String,tableViewHeight:CGFloat)
    func cartTotalAmt(cartTotal:String)
    func showBannr(messageStr: String)
    
}

class CartThirdCell: UITableViewCell {
    
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var mfgLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var arrowImge: UIImageView!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var amountGstLbl: UILabel!
    @IBOutlet weak var totalAmountRupeeLbl: UILabel!
    @IBOutlet weak var gstRupeLbl: UILabel!
    @IBOutlet weak var amountGstRupeeLbl: UILabel!
    var cartlistModel : CartListModel?
    var selectedIndextwo : NSInteger! = -1
    var delegate : arrowBtnTappedDelegate?
    var hiddenSections = Set<Int>()
    var footerHiddenInt = Int()
    var selectQtyS = [String]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }
    
    func loadCartDetails(){
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(UINib(nibName: "CartInnerCell", bundle: nil), forCellReuseIdentifier: "CartInnerCell")
        productTableView.register(UINib(nibName: "CartHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CartHeaderView")
        productTableView.register(UINib(nibName: "FooterTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterTableViewCell")
        
        cartListCall()
        self.productTableView.tableFooterView = nil
        footerHiddenInt = 1
        self.hiddenSections.removeAll()
    }
    
    //MARK: - Notification Call
    
    
    override func layoutSubviews() {
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension CartThirdCell : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return cartlistModel?.payloadJson?.data?.jSupplier?.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return cartlistModel?.payloadJson?.data?.jSupplier?[section].jItems?.count ?? 0
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return "\(cartlistModel?.payloadJson?.data?.jSupplier?[section].cSellerWiseCartCount)"
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = productTableView.dequeueReusableHeaderFooterView(withIdentifier: "CartHeaderView") as! CartHeaderView
        //       // c_seller_name
        headerView.arrowBtn.tag = section
        headerView.arrowBtn.addTarget(self,
                                      action: #selector(self.hideSection(sender:)),
                                      for: .touchUpInside)
        
        headerView.arrowBtn.isSelected = false
        
        headerView.supplierNameLabel.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[section].cSellerName ?? "")"
        headerView.itemsLbl.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[section].nSellerCartCount ?? 0) Items"
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if indexPath.row == 0 {
        //            if indexPath.row == selectedIndextwo{
        //                selectedIndextwo = -1
        //
        //               }else{
        //                selectedIndextwo = indexPath.row
        //
        //               }
        //
        //        }
        //        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1{
            let totalCell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell", for: indexPath)as! FooterTableViewCell
            totalCell.totalGSTLabel.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].nSellerGstAmount ?? 0)"
            totalCell.totalAmoutLabel.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].nSellerItemAmount ?? 0)"
//            var totalGSTFloat = Int()
//            var totalAmountFloat = Int()
//            totalGSTFloat = Int(totalCell.totalGSTLabel.text ?? "0") ?? 0
//            totalAmountFloat = Int(totalCell.totalAmoutLabel.text ?? "0") ?? 0
//            let totalAmounnt = totalGSTFloat + totalAmountFloat
//            print(totalAmounnt)
            totalCell.totalAmountGSTLael.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].nSellerNetAmount ?? 0)"
            
            return totalCell
            
        }else{
            let innerCell = tableView.dequeueReusableCell(withIdentifier: "CartInnerCell", for: indexPath)as! CartInnerCell
            innerCell.productName.text = cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cItemName
            innerCell.packSizeLbl.text = "Pack Size: \(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cPackName ?? "") Syrup"
            innerCell.ptrLbl.text = "PTR ₹ \(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cnMrp ?? 0.0)"
           // innerCell.gstLbl.text = "GST: \(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cGstPercentage ?? "")%"
            innerCell.paracetamalLbl.text = cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cContainName
            innerCell.schemeLbl.text = "Scheme:\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].cSchemeQty ?? "")"
            innerCell.totalMrpLbl.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems?[indexPath.row].nTotal ?? 0.0)"
            self.endEditing(true)
            innerCell.dropDownTxtField.tag = indexPath.row
            innerCell.deleteBtn.tag = indexPath.row
            innerCell.deleteBtn.addTarget(self, action: #selector(deleteBtnAct), for: .touchUpInside)
            innerCell.shortBookBtn.tag = indexPath.row

            innerCell.shortBookBtn.addTarget(self, action: #selector(moveToShotbook), for: .touchUpInside)
            innerCell.innerCellSelectQtyArr = self.selectQtyS
            for (_,ele) in (cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.section].jItems)!.enumerated() {
                self.selectQtyS.append("1")
            }
            innerCell.dropDownTxtField.didSelect{(selectedText , index ,id) in
                self.selectQtyS[indexPath.row] = selectedText
                
            }
            
            
            return innerCell
            
        }
        
    }
    //MARK: - Button actions
    @objc func deleteBtnAct(sender: UIButton){
        print(sender.tag)
        //print(cartlistModel?.payloadJson?.data?.jSupplier?[sender.tag].cSellerCode ?? "")
        deleteCart(cItemCodeStr:cartlistModel?.payloadJson?.data?.jSupplier?[sender.tag].jItems?[sender.tag].cItemCode ?? "" , cSellerCodeStr: cartlistModel?.payloadJson?.data?.jSupplier?[sender.tag].cSellerCode ?? "")
        
    }
    @objc func moveToShotbook(sender:UIButton){
        
    }
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        // sender.isSelected = !sender.isSelected
        print(footerHiddenInt)
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            //            for row in 0..<self.tableViewData[section].count {
            //                indexPaths.append(IndexPath(row: row,
            //                                            section: section))
            
            //            }
            print(cartlistModel?.payloadJson?.data?.jSupplier?.count)
            for row in 0..<(cartlistModel?.payloadJson?.data?.jSupplier?[section].jItems?.count)! {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            print(indexPaths)
            return indexPaths
        }
        
        
        if self.hiddenSections.contains(section) {
            
            self.hiddenSections.remove(section)
            self.productTableView.insertRows(at: indexPathsForSection(),
                                             with: .fade)
            print(self.productTableView.contentSize.height)
            
            self.delegate?.arrow(type: "1", tableViewHeight:self.productTableView.contentSize.height)
            footerHiddenInt = 1
            self.productTableView.tableFooterView?.isHidden = false
            
            
        } else {
            
            self.hiddenSections.insert(section)
            self.productTableView.deleteRows(at: indexPathsForSection(),
                                             with: .fade)
            print(self.productTableView.contentSize.height)
            
            self.delegate?.arrow(type: "0", tableViewHeight:self.productTableView.contentSize.height)
            footerHiddenInt = 0
            
            self.productTableView.tableFooterView?.isHidden = true
            
            
            
        }
        
        self.productTableView.reloadData()
    }
    
    
    
}
extension CartThirdCell:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()

    }
}
extension CartThirdCell : WebServiceDelegate {
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    
    func cartListCall(){
        let cartList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "BranchList")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let cartListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                           "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                           "Content-Type":"application/json",
        ]
        print(cartListHeader)
        
        let cartListParm = ["n_branch_id":UserDefaults.standard.value(forKey: defaultBranchCodeConStr) ?? ""] as [String:Any]
        
        cartList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+CART_LIST_URL, type: .post, userData: cartListParm, apiHeader: cartListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            
            let appDict = ["c_discount_amount" : 0,
                           "c_rate" : "0.0",
                           "c_scheme_qty" : "",
                           "n_qty" : 0,
                           "c_pack_name" : "60ML",
                           "ac_thumbnail_images" : "",
                           "n_total" : "0.0",
                           "c_seller_item_code" : "null498283",
                           "c_max_mrp" : "47.0",
                           "c_contain_name" : "PARACETAMOL",
                           "c_item_name" : "DOLO 125MG SUSP 60ML",
                           "c_short_book_status" : "N",
                           "c_cart_code" : 0,
                           "c_item_code" : "498283",
                           "c_gst_percentage" : "12",
                           "c_discount_percentage" : 0,
                           "n_gst_amount" : "0.0",
                           "c_seller_code" : 0,
                           "n_pack_size" : 0
            ] as [String : Any]
            self.cartlistModel = CartListModel(object:dict)
            if boolSuccess {
                
                if self.cartlistModel?.appStatusCode == 0{
                    
                    for (inx,element) in (cartlistModel?.payloadJson?.data?.jSupplier)!.enumerated(){
                        cartlistModel?.payloadJson?.data?.jSupplier?[inx].jItems?.append(CartListJItems.init(object: appDict))
                        
                    }
                    
                    // print(cartlistModel?.payloadJson?.data?.jSupplier?[0].cSellerWiseCartCount)
                    
                    
                    productTableView.reloadData()
                    
                    cartTableHeightFloat = productTableView.contentSize.height
                    print(cartTableHeightFloat)
                    let totalGSTFloat = cartlistModel?.payloadJson?.data?.nNetGst ?? 0
                    let totalAmountFloat = cartlistModel?.payloadJson?.data?.nNetAmount ?? 0
                    let totalAmounnt = Int(totalGSTFloat) + Int(totalAmountFloat)

                    delegate?.cartTotalAmt(cartTotal: "₹ \(totalAmounnt)")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideViewNotify"), object: nil)
              
                }else{
                    productTableView.reloadData()
                    cartTableHeightFloat = productTableView.contentSize.height
                    print(cartTableHeightFloat)
                    delegate?.cartTotalAmt(cartTotal: "₹ \(0)")

                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideViewNotify"), object: nil)

                }
                
            }else{
                productTableView.reloadData()
                cartTableHeightFloat = productTableView.contentSize.height + 200
                print(cartTableHeightFloat)
                delegate?.cartTotalAmt(cartTotal: "₹ \(0)")

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideViewNotify"), object: nil)

                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
    func deleteCart(cItemCodeStr:String,cSellerCodeStr:String){
        
        
        let getBranchDetails:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getBranchDetails")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let getDeleteCartParm = ["c_item_code": cItemCodeStr,"c_seller_code":cSellerCodeStr]
        
        let getDeleteCartEader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                "Content-Type":"application/json",
        ]
        
        print(getDeleteCartParm)
        
        getBranchDetails.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+DELETE_CART_URL, type: .post, userData: getDeleteCartParm, apiHeader: getDeleteCartEader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            let jsonDict = dict as! NSDictionary
            
            
            let appStatusCodeInt = jsonDict.value(forKey:"appStatusCode") as! Int

            if appStatusCodeInt != 0{
                
                let messageArray = jsonDict.value(forKey:"messages") as! NSArray
                let msgStr = messageArray[0] as! String
                
                delegate?.showBannr(messageStr: msgStr)
                
                
            }else{
                
                let messageArray = jsonDict.value(forKey:"messages") as! NSArray
                let msgStr = messageArray[0] as! String
                cartListCall()
                delegate?.showBannr(messageStr: msgStr)

            }
          
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }

}
