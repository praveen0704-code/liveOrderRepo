//
//  StoreNameView.swift
//  liveOrder
//
//  Created by Data Prime on 09/09/21.
//

import UIKit
protocol storeName {
    func strName(date: String,storeNameStr:String)
}
class StoreNameView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var storeTableView: UITableView!
    var delegate : storeName!
    var branchListModelF:BranchListBaseClass?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var list = ["Maruthi Medical, Jayanagar","Maruthi Medical, Hebbal","Maruthi Medical, Tumkur","Maruthi Medical, Whitefield","Maruthi Medical, Bellandur"]
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
        
        self.frame = UIScreen.main.bounds
        storeTableView.dataSource = self
        storeTableView.delegate = self
        storeTableView.register(UINib(nibName: "FbTableCell", bundle: nil), forCellReuseIdentifier: "FbTableCell")
      //  overView.layer.borderWidth = 1
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)

}
    func reloadStokTableView(){
        self.storeTableView.reloadData()
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
}
extension StoreNameView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchListModelF?.payloadJson?.bItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FbTableCell") as! FbTableCell
        
        cell.txtLbl.text = branchListModelF?.payloadJson?.bItems?[indexPath.row].cBrName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.strName(date: branchListModelF?.payloadJson?.bItems?[indexPath.row].cBrName ?? "", storeNameStr: branchListModelF?.payloadJson?.bItems?[indexPath.row].cBrCode ?? "" )
        self.removeFromSuperview()
    }
}

