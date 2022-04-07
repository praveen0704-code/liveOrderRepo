//
//  CartFourthCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//
protocol viewCouponDelegate {
    func details(type: String)
    func cartValeight(heigtFloat:CGFloat)
}
import UIKit
import Alamofire

class CartFourthCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var cartValueLbl: UILabel!
    @IBOutlet weak var amountTableView: UITableView!
    @IBOutlet weak var lineOneLbl: UILabel!
    @IBOutlet weak var coupanLbl: UILabel!
    @IBOutlet weak var copenImage: UIImageView!
    @IBOutlet weak var applyCodeTxtField: UITextField!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var youAreEligableLbl: UILabel!
    @IBOutlet weak var lineTwoLbl: UILabel!
    @IBOutlet weak var estimateLbl: UILabel!
    @IBOutlet weak var cartTotalLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var totalCoupanLbl: UILabel!
    @IBOutlet weak var deliveryTxtLbl: UILabel!
    @IBOutlet weak var totalRupeeLbl: UILabel!
    @IBOutlet weak var gstRupeeLbl: UILabel!
    @IBOutlet weak var couponRupeeLbl: UILabel!
    @IBOutlet weak var deliveryRupeeLbl: UILabel!
    @IBOutlet weak var toGetFreeLbl: UILabel!
    
    @IBOutlet weak var finaltotalLbl: UILabel!
    
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var cartValueHeigtConnstraint: NSLayoutConstraint!
    var delegate:viewCouponDelegate?
    var selectstring : Int?
    var cartlistModel : CartListModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    func loadCartValues(){
        amountTableView.delegate = self
        amountTableView.dataSource = self
       
        let colorString = " ₹ 1000.00"
        self.toGetFreeLbl.text = "To get Free Delivery Add" + colorString + " In Mahaveer."
        toGetFreeLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ffbe0b"))
        amountTableView.register(UINib(nibName: "FourthInnerCell", bundle: nil), forCellReuseIdentifier: "FourthInnerCell")
        cartListCall()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showBtnAct(_ sender: Any) {
        delegate?.details(type: "Pizza di Mama")
    }
    
}
extension CartFourthCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartlistModel?.payloadJson?.data?.jSupplier?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            
            let innerCell = tableView.dequeueReusableCell(withIdentifier: "FourthInnerCell", for: indexPath)as! FourthInnerCell
        innerCell.checkBtn.tag = indexPath.row
        innerCell.checkBtn.addTarget(self, action: #selector(checkBtnAction), for: .touchUpInside)
        innerCell.productLbl.text = cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.row].cSellerName
        innerCell.productAmountLbl.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.row].nSellerItemAmount ?? 0)"
        innerCell.deliveryAmountLbl.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.row].nSellerGstAmount ?? 0)"
        innerCell.totalAmountLbl.text = "\(cartlistModel?.payloadJson?.data?.jSupplier?[indexPath.row].nSellerNetAmount ?? 0)"
        
        if selectstring == indexPath.row{
            innerCell.checkBtn.backgroundColor = UIColor(hexString: "674CF3")
            innerCell.checkBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
        }else{

            innerCell.checkBtn.borderColor = UIColor(hexString: "C3CDE4")
            innerCell.checkBtn.borderWidth = 1.0
            innerCell.checkBtn.clipsToBounds = true
            innerCell.checkBtn.backgroundColor = .white
            innerCell.checkBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        }
        
            
            return innerCell
   
    }
   
    
    @objc func checkBtnAction(sender:UIButton){
        selectstring = sender.tag
        print(selectstring)
        amountTableView.reloadData()

        
    }
}
extension CartFourthCell : WebServiceDelegate {
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
 
            self.cartlistModel = CartListModel(object:dict)
            if boolSuccess {
                
                if self.cartlistModel?.appStatusCode == 0{
                    
                 
                    
                    self.amountTableView.reloadData()
                    print(self.amountTableView.contentSize.height)
                    cartValueHeigtConnstraint.constant = self.amountTableView.contentSize.height + 70
                    amountTableView.layoutSubviews()
                    delegate?.cartValeight(heigtFloat:self.amountTableView.contentSize.height)
                    self.estimateLbl.text = "ESTIMATED PRICE DETAILS \(cartlistModel?.payloadJson?.data?.nCartItemCount ?? 0) ITEMS"
                    self.totalRupeeLbl.text = "\(cartlistModel?.payloadJson?.data?.nNetAmount ?? 0)"
                    self.gstRupeeLbl.text = "\(cartlistModel?.payloadJson?.data?.nNetGst ?? 0)"
                    let totalGSTFloat = cartlistModel?.payloadJson?.data?.nNetGst ?? 0
                    let totalAmountFloat = cartlistModel?.payloadJson?.data?.nNetAmount ?? 0
                    let totalAmounnt = Int(totalGSTFloat) + Int(totalAmountFloat)
                    self.finaltotalLbl.text = "\(totalAmounnt)"

                }else{
                    
                }
                
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
}
