//
//  ChangeBranchView.swift
//  liveOrder
//
//  Created by Data Prime on 14/09/21.
//
protocol changeBranchapplyBtnDelegate{
    func applyBrCode(brCode : String)
}
import UIKit
import Alamofire


class ChangeBranchView: UIView {
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var innerImgView: UIImageView!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var branchTableview: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var applybtn: UIButton!
    @IBOutlet weak var topView: UIView!
    var delegate : changeBranchapplyBtnDelegate?
    var selectBtnArrInt = [Int]()
    var getBranchListModel : GetBrListModel?
    var brName : String?
    var brCode : String?
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
       
       
        branchView.clipsToBounds = true
        branchView.layer.cornerRadius = 30
        branchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.frame = UIScreen.main.bounds
        branchTableview.dataSource = self
        branchTableview.delegate = self
        branchTableview.register(UINib(nibName: "ChangeInnerCell", bundle: nil), forCellReuseIdentifier: "ChangeInnerCell")
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.branchView.addGestureRecognizer(swipeDown)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.topView.addGestureRecognizer(gesture)
       

}
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        self.removeFromSuperview()
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

    @IBAction func applyBtnAct(_ sender: Any) {
        print(brCode)
        delegate?.applyBrCode(brCode: brCode ?? "")
        self.removeFromSuperview()
        
    }
}
extension ChangeBranchView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBranchListModel?.payloadJson?.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInnerCell") as! ChangeInnerCell
        cell.branchLbl.text = getBranchListModel?.payloadJson?.items?[indexPath.row].cBrName
        cell.checkBtn.tag = indexPath.row
        cell.checkBtn.addTarget(self, action: #selector(brCheckAction), for: .touchUpInside)
        if [indexPath.row] == selectBtnArrInt{
            cell.checkBtn.borderColor = UIColor.clear
            cell.checkBtn.backgroundColor = UIColor(hexString: "674CF3")
            cell.checkBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
        }else{
            cell.checkBtn.borderColor = UIColor(hexString: "C3CDE4")
            cell.checkBtn.borderWidth = 1.0
            cell.checkBtn.clipsToBounds = true
            cell.checkBtn.backgroundColor = .white
            cell.checkBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        }
        return cell
    }
    
  
    //MARK: - Button Action
    @objc func brCheckAction(sender:UIButton){
      
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            selectBtnArrInt = [sender.tag]
            print(getBranchListModel?.payloadJson?.items![sender.tag].cBrCode)
            brCode = getBranchListModel?.payloadJson?.items![sender.tag].cBrCode
           
        }else{
            selectBtnArrInt = [sender.tag]
            
        }
        
        self.branchTableview.reloadData()

        
    }
}


extension ChangeBranchView : WebServiceDelegate{
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
          //  print(getBranchListModel?.payloadJson?.items?[0].cDefaultStatus)
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
                         
                        selectBtnArrInt = [indx]
                       
                        selectLbl.text = "Select a \(elem.cBrName ?? "") for order"
                        brCode = elem.cBrCode
                        branchTableview.reloadData()

                    }
                }
            }else{
                
                
            }
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
    }
}
