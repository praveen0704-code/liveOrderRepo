//
//  PDPVC.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit
import Alamofire
import CoreMIDI

class PDPVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var wishListImg: UIImageView!
    @IBOutlet weak var shortBooKimage: UIImageView!
    @IBOutlet weak var cartImag: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var shortBtn: UIButton!
    @IBOutlet weak var wishLIstBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var pdpTableVie: UITableView!
    var pdpListModel : PDPModel?
    var productWiseSellerModel : ProductVsSellerDetailsModel?
    var selectQty = [String]()
    var productCodeStr = String()
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        pdpApiCall()
    }
    func setup(){
        pdpTableVie.dataSource = self
        pdpTableVie.delegate = self
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        pdpTableVie.register(UINib(nibName: "PdpFirstCell", bundle: nil), forCellReuseIdentifier: "PdpFirstCell")
        pdpTableVie.register(UINib(nibName: "PdpSecViewTableCell", bundle: nil), forCellReuseIdentifier: "PdpSecViewTableCell")
        pdpTableVie.register(UINib(nibName: "AboutDrugCell", bundle: nil), forCellReuseIdentifier: "AboutDrugCell")
        pdpTableVie.register(UINib(nibName: "QuickLinksCell", bundle: nil), forCellReuseIdentifier: "QuickLinksCell")
        pdpTableVie.register(UINib(nibName: "AlterTableCell", bundle: nil), forCellReuseIdentifier: "AlterTableCell")




    }
    @IBAction func searchBtnAct(_ sender: Any) {
    }
    @IBAction func wiahListBtnAct(_ sender: Any) {
        
        
    }
    @IBAction func shortBtnAct(_ sender: Any) {
        
        
    }
    @IBAction func cartBtnAct(_ sender: Any) {
        
        
        
    }
    

    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PLPFiltterVc") as? PLPFiltterVc
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

}
extension PDPVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let PdpFirstcell = tableView.dequeueReusableCell(withIdentifier: "PdpFirstCell", for: indexPath)as! PdpFirstCell
            PdpFirstcell.productNameLbl.text = pdpListModel?.payloadJson?.data?.cItemName
            PdpFirstcell.selectSizeAnsLbl.text = pdpListModel?.payloadJson?.data?.cPackName
            PdpFirstcell.microLabLbl.text = pdpListModel?.payloadJson?.data?.cMfgName
            PdpFirstcell.containNameLbl.text = pdpListModel?.payloadJson?.data?.cContentName
            PdpFirstcell.hsnNumber.text = pdpListModel?.payloadJson?.data?.cHsnCode
            PdpFirstcell.mrpNumberLbl.text =  "\(pdpListModel?.payloadJson?.data?.nMaxMrp ?? 0)"
            PdpFirstcell.gstNumberLbl.text = "\(pdpListModel?.payloadJson?.data?.cGst ?? "")%"
            PdpFirstcell.pakageTxtLbl.text = pdpListModel?.payloadJson?.data?.cPackName
                
            return PdpFirstcell
            
        } else if indexPath.row == 1 {
            
            let PdpSecCell = tableView.dequeueReusableCell(withIdentifier: "PdpSecViewTableCell", for: indexPath)as! PdpSecViewTableCell
            
            PdpSecCell.sellerTableView.isScrollEnabled = false
            tabHeight = PdpSecCell.sellerTableView.contentSize.height

            return PdpSecCell
            
        }else if indexPath.row == 2 {
            
            let Aboutcell = tableView.dequeueReusableCell(withIdentifier: "AboutDrugCell", for: indexPath)as! AboutDrugCell
            Aboutcell.desTxtView.text = pdpListModel?.payloadJson?.data?.jMolecules?[0].cDescription
            
            return Aboutcell
            
        }else if indexPath.row == 3 {
            
            let Quickcell = tableView.dequeueReusableCell(withIdentifier: "QuickLinksCell", for: indexPath)as! QuickLinksCell
            Quickcell.usageTxtView.text = pdpListModel?.payloadJson?.data?.jMolecules?[0].cUsage
            Quickcell.noteTxtView.text = pdpListModel?.payloadJson?.data?.jMolecules?[0].cNote
            Quickcell.sideEffctDesLbl.text = pdpListModel?.payloadJson?.data?.jMolecules?[0].cSideEffect
            Quickcell.contraDesLbl.text = pdpListModel?.payloadJson?.data?.jMolecules?[0].cContraIndications
            
            return Quickcell
            
        }else if indexPath.row == 4 {
            
            let Altercell = tableView.dequeueReusableCell(withIdentifier: "AlterTableCell", for: indexPath)as! AlterTableCell
            
            return Altercell
            
        }
        
        
        return UITableViewCell()
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            print(tabHeight)
            return tabHeight
       
        } else{
            return tableView.contentSize.height
        }
    }
}
extension PDPVC: WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    
    func pdpApiCall(){
        
        
        let pdp:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopMfg")
        let pdpParm = ["c_item_code":"\(productCodeStr)"]
//        let pdpHeader :HTTPHeaders = ["X-csquare-api-key":"TihpuDEJ0nq2LuqL1e0CuA==",
//                                    "X-csquare-api-token":"128703890945b457",
//                                    "Content-Type":"application/json",
//                                        ]

                let pdpHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        pdp.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PDP_URL, type: .post, userData: pdpParm, apiHeader: pdpHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.pdpListModel = PDPModel(object:dict)
            print(dict)
            if boolSuccess {
               
                if self.pdpListModel?.appStatusCode == 0{
                    pdpTableVie.reloadData()
                   
                }else{
                    
                }
                
               

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           

        })
        
        
        }


}
