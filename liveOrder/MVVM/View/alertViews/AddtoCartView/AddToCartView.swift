//
//  AddToCartView.swift
//  liveOrder
//
//  Created by Data Prime on 22/07/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift

protocol addcartDelegate {
    func addcartReady(c_item_codeStr:String ,c_mobile_noStr: String,c_seller_codeStr: String,c_seller_item_codeStr: String,c_seller_nameStr: String,n_mrpStr:Float,n_qtystr:String,n_seller_rateStr:Float)
    func openSeller(c_item_codeStr:String,itemIndex:Int)
}

class AddToCartView: UIView {

    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var blackLbl: UILabel!
    @IBOutlet weak var selectSellerLbl: UILabel!
    
    @IBOutlet weak var bestSchemesTableView: UITableView!
    @IBOutlet weak var dotView: DashedLineView!
    
    
    @IBOutlet weak var cartMainViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var removeView: UIView!
    
    var delegate: addcartDelegate?

    var itemCodeStr = String()

    var productwiseSellerModel : ProductVsSellerDetailsModel?
    var osSellerModel:OrderSellerList?
    var selectQtyS = [String]()
    var productName : String?
    var addInt = [Int]()
    var cartBtnIndex = Int()


    override func awakeFromNib() {
       super.awakeFromNib()
        bestSchemesTableView.register(UINib(nibName: AfterScanFmcgTableViewCell, bundle: nil), forCellReuseIdentifier: AfterScanFmcgTableViewCell)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overAllView.addGestureRecognizer(swipeDown)
        blackLbl.layer.cornerRadius = 4
        blackLbl.layer.masksToBounds = true
        overAllView.clipsToBounds = true
        overAllView.layer.cornerRadius = 30
        overAllView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bestSchemesTableView.delegate = self
        bestSchemesTableView.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.removeView.addGestureRecognizer(gesture)

    }
    override func layoutSubviews() {
        print(itemCodeStr)
        print(self.selectQtyS)
        print(self.addInt)
        print(self.bestSchemesTableView.contentSize.height)
        if productwiseSellerModel?.payloadJson?.data?.jList != nil{
            selectSellerLbl.text = "Select Seller For \(productName ?? "")"
            for (_,element) in (self.productwiseSellerModel?.payloadJson?.data?.jList)!.enumerated() {
                
                self.addInt.append(0)
                
            }
            bestSchemesTableView.reloadData()
            if productwiseSellerModel?.payloadJson?.data?.jList?.count == 1{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 280
                self.overAllView.layoutIfNeeded()
            }else if productwiseSellerModel?.payloadJson?.data?.jList?.count == 2{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 315
                self.overAllView.layoutIfNeeded()
            }else if productwiseSellerModel?.payloadJson?.data?.jList?.count == 3{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 385
                self.overAllView.layoutIfNeeded()
            }else if productwiseSellerModel?.payloadJson?.data?.jList?.count == 4{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 460
                self.overAllView.layoutIfNeeded()
            }else if productwiseSellerModel?.payloadJson?.data?.jList?.count == 5{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 530
                self.overAllView.layoutIfNeeded()
            }else{
                self.cartMainViewHeightConstraint.constant = self.frame.height - 150
                self.overAllView.layoutIfNeeded()
                
            }
        }else{
            selectSellerLbl.text = "Add Seller For \(productName ?? "")"

            for (_,element) in (self.osSellerModel?.payloadJson?.data)!.enumerated() {
                
                self.addInt.append(0)
                
            }
            bestSchemesTableView.reloadData()
            if osSellerModel?.payloadJson?.data?.count == 1{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 280
                self.overAllView.layoutIfNeeded()
            }else if osSellerModel?.payloadJson?.data?.count == 2{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 315
                self.overAllView.layoutIfNeeded()
            }else if osSellerModel?.payloadJson?.data?.count == 3{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 385
                self.overAllView.layoutIfNeeded()
            }else if osSellerModel?.payloadJson?.data?.count == 4{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 460
                self.overAllView.layoutIfNeeded()
            }else if osSellerModel?.payloadJson?.data?.count == 5{
                self.cartMainViewHeightConstraint.constant = self.frame.height - self.frame.height + 530
                self.overAllView.layoutIfNeeded()
            }else{
                self.cartMainViewHeightConstraint.constant = self.frame.height - 150
                self.overAllView.layoutIfNeeded()
                
            }
        }
        
        
      
    }

    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        self.addInt.removeAll()

        self.removeFromSuperview()

       // self.subviews.forEach { $0.removeFromSuperview() }
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
                let left = CGAffineTransform(translationX: -300, y: 0)
                let right = CGAffineTransform(translationX: 300, y: 0)
                let top = CGAffineTransform(translationX: 0, y: -self.frame.size.height)
                let bottom = CGAffineTransform(translationX: 0, y: self.frame.size.height)

                UIView.animate(withDuration:  0.6, delay: 0.0, options: []) {

                    self.transform = bottom

                } completion: { res in
                    self.cartMainViewHeightConstraint.constant = 0.0
                    self.overAllView.layoutIfNeeded()
//                    self.subviews.forEach { $0.removeFromSuperview() }
                    self.addInt.removeAll()
                    self.removeFromSuperview()
                }
    
                
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}


extension AddToCartView:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if productwiseSellerModel?.payloadJson?.data?.jList?.count == 0 || osSellerModel?.payloadJson?.data?.count == 0  {
            let noRecordsErrorView = NoRecordsErrorView.fromNib()
            noRecordsErrorView.tag = 201
            noRecordsErrorView.noHistoryLbl.text = "No Record Found"
            tableView.backgroundView = noRecordsErrorView
            tableView.isScrollEnabled = false
            tableView.separatorStyle  = .none
        }else{
            tableView.separatorStyle = .none
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
        }
       
     
        
        return numOfSections
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productwiseSellerModel?.payloadJson?.data?.jList != nil{
            print(productwiseSellerModel?.payloadJson?.data?.jList?.count ?? 0)
            return productwiseSellerModel?.payloadJson?.data?.jList?.count ?? 0


        }else{
            return osSellerModel?.payloadJson?.data?.count ?? 0

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AfterScanFmcgTableViewCell, for: indexPath) as! AfterScanFmcgTbleCell
        cell.addtoCardBtn.tag = indexPath.row
        cell.addtoCardBtn.addTarget(self, action: #selector(addcart), for: .touchUpInside)
        if productwiseSellerModel?.payloadJson?.data?.jList != nil{
            cell.pharmaNameLbl.text = "\(productwiseSellerModel?.payloadJson?.data?.jList?[indexPath.row].cSellerName ?? "")"
            cell.rateLbl.text = "Rate: ₹ \(productwiseSellerModel?.payloadJson?.data?.jList?[indexPath.row].nMrp ?? 0.0)"
            cell.schemeLbl.text = "Scheme: \(productwiseSellerModel?.payloadJson?.data?.jList?[indexPath.row].cSchemes ?? "")"
            cell.numberTextField.isHidden = false
            cell.numberTextField.tag = indexPath.row
            cell.numberTextField.text = self.selectQtyS[indexPath.row]
            cell.numberTextField.delegate = self
//print(addInt)
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
                self.selectQtyS[indexPath.row] = selectedText
                
                print(self.selectQtyS)
                        }
        }else{
            cell.pharmaNameLbl.text = "\(osSellerModel?.payloadJson?.data?[indexPath.row].cSellerName ?? "")"
            cell.rateLbl.text = "Rate: ₹ \(osSellerModel?.payloadJson?.data?[indexPath.row].nSellerRate ?? 0.0)"
            cell.schemeLbl.text = "Available Stocks: \(osSellerModel?.payloadJson?.data?[indexPath.row].nSellerStock ?? 0)"
            cell.numberTextField.isHidden = true

            cell.addtoCardBtn.tag = indexPath.row
            cell.addtoCardBtn.setTitle("Add Seller", for: .normal)
            
            cell.addtoCardBtn.addTarget(self, action: #selector(addcart), for: .touchUpInside)
            cell.numberTextField.didSelect{(selectedText , index ,id) in
                self.selectQtyS[indexPath.row] = selectedText
                
                print(self.selectQtyS)
                        }
           
        }
        
        
        return cell
        
    }
    
    @objc func addcart(_ sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        cartBtnIndex = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)

        
        if let cell = self.bestSchemesTableView.cellForRow(at: indexPath) as? AfterScanFmcgTbleCell {
               
            addInt[sender.tag] = 0
            if cell.numberTextField.text == ""{
                let banner = NotificationBanner(title: "Message", subtitle: "Please enter Quantity", style: .info)
                banner.showToast(message: "Please enter Quantity" , view: self)
            }else{
                if sender.isSelected{
                    print(addInt[sender.tag])
                    addInt[sender.tag] = 1
                    print(addInt)
                    if  productwiseSellerModel?.payloadJson?.data?.jList != nil{
                        let citem_codeStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? ""
                        let cmobile_noStr  = UserDefaults.standard.value(forKey:usernameConstantStr) as! String
                        let cseller_codeStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].cSellerCode ?? ""
                        let cseller_item_codeStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].cSellerCode ?? ""
                        let cseller_nameStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].cSellerName ?? ""
                        let nmrpStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].nMrp ?? 0.0
                        let nqtystr = selectQtyS[sender.tag]
                        let nseller_rateStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].nSellerRate ?? 00
                        
                        print(selectQtyS[sender.tag])
                        
                        delegate?.addcartReady(c_item_codeStr: citem_codeStr, c_mobile_noStr: cmobile_noStr, c_seller_codeStr: cseller_codeStr, c_seller_item_codeStr: cseller_item_codeStr, c_seller_nameStr: cseller_nameStr, n_mrpStr: nmrpStr, n_qtystr: nqtystr, n_seller_rateStr: nseller_rateStr)
                    }else {
                        let citem_codeStr = productwiseSellerModel?.payloadJson?.data?.jList?[sender.tag].cItemCode ?? ""
                        delegate?.openSeller(c_item_codeStr: osSellerModel?.payloadJson?.data?[sender.tag].cSellerCode ?? "", itemIndex: sender.tag)
                        
                    }
                }else{
                    print(addInt[sender.tag])
                    addInt[sender.tag] = 0
                    print(addInt)
                }
            }
            bestSchemesTableView.reloadData()
        }
        
            
        
        
        
       
    }
}
extension AddToCartView:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text == ""{
            textField.resignFirstResponder()
            
            let banner = NotificationBanner(title: "Message", subtitle: "Please enter Quantity", style: .info)
            banner.showToast(message: "Please enter Quantity" , view: self)
//            let indexPath = IndexPath(row:textField.tag, section: 0)
//             
//            if let cell = self.bestSchemesTableView.cellForRow(at: indexPath) as? AfterScanFmcgTbleCell {
//                   
//                
//                bestSchemesTableView.reloadData()
//            }
            
            
        }
    }
}




