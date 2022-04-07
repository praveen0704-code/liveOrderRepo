//
//  MenuVC.swift
//  liveOrder
//
//  Created by Data Prime on 10/07/21.
//

import UIKit
import Alamofire
import SwiftUI

class MenuVC: UIViewController {
    @IBOutlet weak var menuTopView: UIView!
    @IBOutlet weak var menuTxtLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
   
    var selectedIndex : NSInteger! = -1 //Delecre this global
    var arrowimgone = false
    var zerothIndex = false
    var categorisHeight : CGFloat?
    
    var categoryListmodel: CategoryListModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        setup()
    }
    
    
    func setup(){
        
        categoryListapi()
        
        
        self.menuTopView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        menuTopView.clipsToBounds = true
        menuTopView.layer.cornerRadius = 40
        menuTopView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MenulistTableViewCell, bundle: nil), forCellReuseIdentifier: MenulistTableViewCell)
        menuTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        menuTableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        menuTableView.register(UINib(nibName: "OrderToSellerTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderToSellerTableViewCell")
        menuTableView.register(UINib(nibName: "LiveOrderGoldTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveOrderGoldTableViewCell")
        menuTableView.register(UINib(nibName: "OffersPromotionsTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersPromotionsTableViewCell")
        menuTableView.register(UINib(nibName: "PatientTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTableViewCell")
        
        
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

extension MenuVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let downimage = UIImage(named: "down")
        let sideimage = UIImage(named: "sideArrow")
        
        if indexPath.row == 0 {
            
            
            let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath)as! CategoriesTableViewCell
            catCell.categoryListmodelc = self.categoryListmodel
            catCell.allProductBtn.addTarget(self, action: #selector(allProductBtnAct), for: .touchUpInside)
            catCell.delegate = self
            if arrowimgone == true{
                //catCell.rightImageView.image = UIImage(named: "upArrow")
                let tintedImage = downimage?.withRenderingMode(.alwaysTemplate)
                
                catCell.rightImageView.image = tintedImage
                catCell.rightImageView.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)

            }else{
                let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
                
                catCell.rightImageView.image = sideimg
                catCell.rightImageView.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
            }
            
            if zerothIndex == true{
                catCell.catView.backgroundColor = UIColor(hexString: "e8eef2", alpha: 0.20)
                catCell.topLineHeight.constant = 0.0
                catCell.lineViewTop.layoutIfNeeded()
            }else{
                catCell.catView.backgroundColor = .white
                catCell.topLineHeight.constant = 1.0
                catCell.lineViewTop.layoutIfNeeded()
            }
            
            
            return catCell
            
        }
        if indexPath.row == 1 {
            
            let dashcell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath)as! DashboardTableViewCell
            
            return dashcell
            
        }
        if indexPath.row == 2 {
            
            
            let ordercell = tableView.dequeueReusableCell(withIdentifier: "OrderToSellerTableViewCell", for: indexPath)as! OrderToSellerTableViewCell
            
            return ordercell
            
        }
//        if indexPath.row == 3 {
//
//
//            let goldcell = tableView.dequeueReusableCell(withIdentifier: "LiveOrderGoldTableViewCell", for: indexPath)as! LiveOrderGoldTableViewCell
//
//            return goldcell
//
//        }
//        if indexPath.row == 4 {
//
//
//            let offercell = tableView.dequeueReusableCell(withIdentifier: "OffersPromotionsTableViewCell", for: indexPath)as! OffersPromotionsTableViewCell
//
//            return offercell
//
//        }
//        if indexPath.row == 3 {
//
//
//            let patientcell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath)as! PatientTableViewCell
//
//            return patientcell
//
//        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex
        {
            return categorisHeight ?? 280
        }else{
            return 49
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            if indexPath.row == selectedIndex{
                selectedIndex = -1
                arrowimgone = false
                zerothIndex = false
            }else{
                selectedIndex = indexPath.row
                zerothIndex = true
                arrowimgone = true
            }
            
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderToSellerVC") as? OrderToSellerVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        tableView.reloadData()
        
        
    }
    
    @objc func allProductBtnAct(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = 6
        vc?.sellerName = "All PRODUCTS"
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension MenuVC : catHeightDelegate{
    func didselectCode(itemCode: String,name:String) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlpVC") as? PlpVC
        vc?.viewAllInt = 5
        vc?.sellerName = name
        vc?.mfcCode = itemCode
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func catHeight(heightCat: CGFloat) {
        print(heightCat)
        categorisHeight = heightCat + 100
        print(categorisHeight)
        
        
    }
    
    
}
extension MenuVC:WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    func categoryListapi(){
        showActivityIndicator(self.view)

        let categoryList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "categoryList")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let catHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        categoryList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+CATEGORY_LIST_URL, type: .get, userData: nil, apiHeader: catHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.categoryListmodel = CategoryListModel(object:dict)
            if boolSuccess {
               
                if self.categoryListmodel?.appStatusCode == 0{
                    menuTableView.reloadData()
                }else{
                    
                }
                
               
                
            }else{
                        

            }
            hideActivityIndicator(self.view)
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)


        })
        
        
        }
    
}


