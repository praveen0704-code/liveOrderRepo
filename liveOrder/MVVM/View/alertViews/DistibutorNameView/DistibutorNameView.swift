//
//  DistibutorNameView.swift
//  liveOrder
//
//  Created by Data Prime on 09/09/21.
//

import UIKit
protocol distributorName {
    func name(date: String,distributerListIdStr:String)
}
class DistibutorNameView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var selectlbl: UILabel!
    @IBOutlet weak var dotview: UIView!
    @IBOutlet weak var disTableView: UITableView!
    var delegate : distributorName!
    var distributerListModelF : DistriuterBaseClass?

   // var list = ["Mahaveer Madi-Sales","Raj Sons Pharma","Vardhman Pharma","Varun Pharma ","Yash Pharma"]
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
        disTableView.dataSource = self
        disTableView.delegate = self
        disTableView.register(UINib(nibName: "FbTableCell", bundle: nil), forCellReuseIdentifier: "FbTableCell")
      //  overView.layer.borderWidth = 1
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            dotview.drawDottedLine(start: CGPoint(x: dotview.bounds.minX, y: dotview.bounds.minY), end: CGPoint(x: dotview.bounds.maxX, y: dotview.bounds.minY), view: dotview)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)

}
    
    func reloadTaleView(){
        self.disTableView.reloadData()
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
extension DistibutorNameView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return distributerListModelF?.payloadJson?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FbTableCell") as! FbTableCell
        
        cell.txtLbl.text = distributerListModelF?.payloadJson?.data?[indexPath.row].cDistributorName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate.name(date: distributerListModelF?.payloadJson?.data?[indexPath.row].cDistributorName ?? "", distributerListIdStr: distributerListModelF?.payloadJson?.data?[indexPath.row].cDistributorId ?? "" )
        self.removeFromSuperview()

      
    }
}

