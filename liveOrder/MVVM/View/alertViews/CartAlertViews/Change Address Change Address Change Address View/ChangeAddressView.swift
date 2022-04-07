//
//  ChangeAddressView.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//
protocol changeAddDelegate{
    func changeAddBrCode(brCode:String,edit:String)
}
import UIKit
import Alamofire
class ChangeAddressView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var selectAddLbl: UILabel!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var newAddBtn: UIButton!
    @IBOutlet weak var lineOneLbl: UILabel!
    @IBOutlet weak var linetwoLbl: UILabel!
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var deliverBtn: UIButton!
    var delegate : changeAddDelegate?
    var getBranchListModel : GetBrListModel?
    var checkArr = [Int]()
    var brCodeStr :String?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     
    }
 
  
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        getBranchList()
        overView.layer.borderWidth = 1
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.frame = UIScreen.main.bounds
        addTableView.dataSource = self
        addTableView.delegate = self
        addTableView.register(UINib(nibName: "ChangeAddInnerCell", bundle: nil), forCellReuseIdentifier: "ChangeAddInnerCell")
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)
        
       
       

}
     
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
                self.removeFromSuperview()
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    @IBAction func crossBtnAct(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func newAddBtnAct(_ sender: Any) {
        delegate?.changeAddBrCode(brCode: "1" ,edit:"")
        self.removeFromSuperview()
    }
    @IBAction func deliverBtnAct(_ sender: Any) {
        delegate?.changeAddBrCode(brCode: brCodeStr ?? "",edit:"")
        self.removeFromSuperview()
    }
}
extension ChangeAddressView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBranchListModel?.payloadJson?.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeAddInnerCell") as! ChangeAddInnerCell
        cell.checkBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtnAct(sender:)), for: .touchUpInside)
        cell.checkBtn.addTarget(self, action: #selector(checkAct(sender:)), for: .touchUpInside)
        cell.pharmaLbl.text = getBranchListModel?.payloadJson?.items?[indexPath.row].cBrName
        cell.addTxtView.text = "\(getBranchListModel?.payloadJson?.items?[indexPath.row].cCityName ?? ""). \n \(getBranchListModel?.payloadJson?.items?[indexPath.row].cPincode ?? ""). "
        let isIndexValid = checkArr.indices.contains(indexPath.row)
        
      
            
            let checkListInt = checkArr[indexPath.row]
            
            if checkListInt == 1{
                

                cell.checkBtn.backgroundColor = UIColor(hexString: "674CF3")
                cell.checkBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
                cell.checkBtn.isSelected = true
                
            }else{
                cell.checkBtn.borderColor = UIColor(hexString: "C3CDE4")
                cell.checkBtn.borderWidth = 1.0
                cell.checkBtn.clipsToBounds = true
                cell.checkBtn.backgroundColor = .white
                cell.checkBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
                cell.checkBtn.isSelected = false
                
            }
        return cell
    }
    
    @objc func checkAct(sender:UIButton){
        sender.isSelected = !sender.isSelected
        for (inx,element) in (self.getBranchListModel?.payloadJson?.items)!.enumerated() {
            if inx == sender.tag{
                self.checkArr[inx] = 1
                brCodeStr = getBranchListModel?.payloadJson?.items?[sender.tag].cBrCode
               
            }else{
                self.checkArr[inx] = 0
                
            }
        }
        addTableView.reloadData()
    }
    @objc func editBtnAct(sender:UIButton){
       
        brCodeStr = getBranchListModel?.payloadJson?.items?[sender.tag].cBrCode
        delegate?.changeAddBrCode(brCode: brCodeStr ?? "",edit:"1")
        self.removeFromSuperview()
    }
    
}


extension ChangeAddressView : WebServiceDelegate{
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
           // print(getBranchListModel?.payloadJson?.items?[0].cDefaultStatus)
            if boolSuccess {
                for (i,ele) in (getBranchListModel?.payloadJson?.items)!.enumerated(){
                    checkArr.append(0)
                }
                for (inx,ele) in (getBranchListModel?.payloadJson?.items)!.enumerated(){
                    if ele.cDefaultStatus == "Y"{
                        checkArr[inx] = 1
                        brCodeStr = ele.cBrCode
                    }else{
                        checkArr[inx] = 0
                    }
                }
                
           
                addTableView.reloadData()
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
}
