//
//  ChangeBranchCell.swift
//  liveOrder
//
//  Created by Data Prime on 06/08/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift


protocol branchCellHeightDelegate {
    func branchHeight(tableCellHeight: CGFloat)
    func defaultMessage(mage : String)
}

class ChangeBranchCell: UITableViewCell {
    @IBOutlet weak var changeBranchView: UIView!
    @IBOutlet weak var selectedImgView: UIImageView!
    @IBOutlet weak var branchTxtLbl: UILabel!
    @IBOutlet weak var selectimg1: UIImageView!
    @IBOutlet weak var selectImg2: UIImageView!
    @IBOutlet weak var selectImg3: UIImageView!
    @IBOutlet weak var selectImg4: UIImageView!
    @IBOutlet weak var textLbl1: UILabel!
    @IBOutlet weak var txtLbl2: UILabel!
    @IBOutlet weak var txtLbl3: UILabel!
    @IBOutlet weak var txtLbl4: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var makeTxtLbl: UILabel!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var branchListTableView: UITableView!
    @IBOutlet weak var makedefaultBtn: UIButton!
    @IBOutlet weak var lineOneLbl: UILabel!
    @IBOutlet weak var lineTwoLbl: UILabel!
    @IBOutlet weak var lineOneHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    
    var changebranchlist = [String]()
    var getBranchListModel : GetBrListModel?
    var setDefaultBranchModel : SetDefaultBrModel?
    var select : Bool = false
    var selectBtnArrInt = [Int]()
    var selectAllBtnInt = 0
    var tableViewHeight: CGFloat = 0
    
    var delegate:branchCellHeightDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        getBranchList()
        changebranchlist = ["Jaynagar","Banshankari","Kumaraswamy Layout ","Hosakerehalli"]
        branchListTableView.delegate =  self
        branchListTableView.dataSource = self
        
        for (inx,element) in changebranchlist.enumerated(){
            selectBtnArrInt.append(0)
        }
        
        branchListTableView.register(UINib(nibName: "BranchListTableViewCell", bundle: nil), forCellReuseIdentifier: "BranchListTableViewCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func defaultaBtnSct(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if  sender.isSelected {
            selectAllBtnInt = 1
            
            makedefaultBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: .normal)
            makedefaultBtn.backgroundColor = UIColor(hexString: "674CF3")
            makedefaultBtn.borderColor = UIColor(hexString: "674CF3")
            makedefaultBtn.borderWidth = 1.0
            makedefaultBtn.clipsToBounds = true
            //            for (inx,element) in changebranchlist.enumerated(){
            //                selectBtnArrInt[inx] = 1
            //            }
            branchListTableView.reloadData()
            
        }else{
            selectAllBtnInt = 0
            makedefaultBtn.borderColor = UIColor(hexString: "674CF3")
            makedefaultBtn.borderWidth = 1.0
            makedefaultBtn.clipsToBounds = true
            makedefaultBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
            makedefaultBtn.backgroundColor = .white
            //            for (inx,element) in changebranchlist.enumerated(){
            //                selectBtnArrInt[inx] = 0
            //            }
            branchListTableView.reloadData()
            
        }
    }
}
extension ChangeBranchCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBranchListModel?.payloadJson?.items!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let branchlistcell = tableView.dequeueReusableCell(withIdentifier: "BranchListTableViewCell", for: indexPath)as! BranchListTableViewCell
        branchlistcell.branchListLbl.text = getBranchListModel?.payloadJson?.items![indexPath.row].cBrName
        branchlistcell.selectBtn.addTarget(self, action: #selector(selecttnAction), for: .touchUpInside)
        branchlistcell.selectBtn.tag = indexPath.row
        
        
        
        
        if [indexPath.row] == selectBtnArrInt{
            if selectAllBtnInt == 1{
                branchlistcell.selectBtn.isHidden = false
                
            }else{
                branchlistcell.selectBtn.isHidden = true
                
            }
            branchlistcell.selectBtn.isSelected = true
            
            branchlistcell.selectBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: .normal)
            branchlistcell.selectBtn.backgroundColor = UIColor(hexString: "674CF3")
            
        }else{
            if selectAllBtnInt == 1{
                branchlistcell.selectBtn.isHidden = false
                
            }else{
                branchlistcell.selectBtn.isHidden = true
                
            }
            branchlistcell.selectBtn.isSelected = false
            
            branchlistcell.selectBtn.layer.borderWidth = 1
            branchlistcell.selectBtn.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            branchlistcell.selectBtn.layer.cornerRadius = branchlistcell.selectBtn.frame.height / 2
            branchlistcell.selectBtn.backgroundColor = .white
            
            
        }
        return branchlistcell
    }
    
    
    
    @objc func selecttnAction(sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            selectBtnArrInt = [sender.tag]
            print(getBranchListModel?.payloadJson?.items![sender.tag].cBrCode)
            setDefaultbranch(branchCode: getBranchListModel?.payloadJson?.items![sender.tag].cBrCode ?? "")
            
        }else{
            selectBtnArrInt = [sender.tag]
            
        }
        
        self.branchListTableView.reloadData()
    }
    
    
}
extension ChangeBranchCell : WebServiceDelegate{
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
                                   "n_limit":"50"]
        
        let getBranchListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                "Content-Type":"application/json",
        ]
        
        print(getBranchListHeader)
        
        getBranchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_BRANCH_LIST_URL, type: .post, userData: getBranchListParams, apiHeader: getBranchListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.getBranchListModel = GetBrListModel(object:dict)
          //  print(getBranchListModel?.payloadJson?.items?[0].cDefaultStatus)
            if boolSuccess {
                
                
                //            let pro =   self.getBrListModel?.payloadJson?.items!.filter {
                //                    $0.cDefaultStatus == "Y"
                //                }
                headerLbl.text = "Change Branch ( \(getBranchListModel?.payloadJson?.items?.count ?? 0) )"
                branchListTableView.reloadData()
                print(self.branchListTableView.contentSize.height)
                self.tableHeight.constant = branchListTableView.contentSize.height
                self.branchListTableView.layoutSubviews()
                
                for (indx , elem) in self.getBranchListModel!.payloadJson!.items!.enumerated(){
                    print(elem.cDefaultStatus)
                    if elem.cDefaultStatus == "Y"{
                        //                        userNameLbl.text = i.cBrName
                        //                        locationLbl.text = i.cCityName
                        selectBtnArrInt = [indx]
                        branchListTableView.reloadData()
                        
                        
                    }
                }
                delegate?.branchHeight(tableCellHeight: CGFloat(branchListTableView.contentSize.height))
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
    func setDefaultbranch(branchCode : String){
        
        
        let setDefaultbranch:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "setDefaultbranch")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let setDefaultbranchParams = ["c_br_code":branchCode]
        
        let setDefaultbranchHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                   "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                   "Content-Type":"application/json",
        ]
        
        print(setDefaultbranchHeader)
        
        setDefaultbranch.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SET_DEFAULT_BRANCH, type: .post, userData: setDefaultbranchParams, apiHeader: setDefaultbranchHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            setDefaultBranchModel = SetDefaultBrModel(object: dict)
            
            if boolSuccess {
                if setDefaultBranchModel?.appStatusCode == 0{
                    UserDefaults.standard.setValue(self.setDefaultBranchModel?.payloadJson?.data?.key, forKey: ketConstantStr)
                    UserDefaults.standard.setValue(self.setDefaultBranchModel?.payloadJson?.data?.token, forKey: tokenConstantStr)
                    UserDefaults.standard.setValue(branchCode, forKey: branchConstantStr)
                    delegate?.defaultMessage(mage: setDefaultBranchModel?.messages?[0] ?? "")
                }else{
                    print(setDefaultBranchModel?.messages?[0])
                }
                

                
                
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
}
