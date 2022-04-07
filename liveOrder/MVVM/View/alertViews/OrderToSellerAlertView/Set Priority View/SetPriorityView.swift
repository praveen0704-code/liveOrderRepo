//
//  SetPriorityView.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import UIKit
protocol orderToSellerDelegate {
    func orderToSellerPassVal(type: Int)
}

class SetPriorityView: UIView {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var setPriorityLbl: UILabel!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var priorityTableView: UITableView!
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var dotView: UIView!
    
    var numArr = [Int]()
    var prioritySelectedInx = Int()
    var oToSdelegate: orderToSellerDelegate?

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
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.frame.maxX, y: dotView.bounds.minY), view: dotView)
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 30
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.frame = UIScreen.main.bounds
        priorityTableView.dataSource = self
        priorityTableView.delegate = self
        priorityTableView.register(UINib(nibName: "PriorityTableCell", bundle: nil), forCellReuseIdentifier: "PriorityTableCell")
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.mainView.addGestureRecognizer(swipeDown)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
        removeView.addGestureRecognizer(tapGesture)
       

}
    override func layoutSubviews() {
        print(numArr)
        print(prioritySelectedInx)
        if let removeIndex = numArr.firstIndex(of: prioritySelectedInx) {
            print("Index of '\(prioritySelectedInx)' is \(index).")
            numArr.remove(at:removeIndex)
            print(numArr)
            priorityTableView.reloadData()
        } else {
            print("Element is not present in the array.")
            priorityTableView.reloadData()

        }
    }
     
    @objc func handleTap(sender: UITapGestureRecognizer) {
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
        
        
    }
}
extension SetPriorityView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityTableCell") as! PriorityTableCell
        cell.txtlbl.text = "\(numArr[indexPath.row])"
        cell.priorityButton.tag = indexPath.row
        cell.priorityButton.setTitle("", for: .normal)
        cell.priorityButton.addTarget(self, action: #selector(priorityAction), for: UIControl.Event.touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        oToSdelegate?.orderToSellerPassVal(type: numArr[indexPath.row])
    }
    
    //MARK: - priority ButtonAction
    @objc func priorityAction(sender:UIButton){
        oToSdelegate?.orderToSellerPassVal(type: numArr[sender.tag])

    }
    
  
    
}


