//
//  FeedBackTypeView.swift
//  liveOrder
//
//  Created by Data Prime on 09/09/21.
//

import UIKit
import SwiftyJSON
import Alamofire
import NotificationBannerSwift

protocol feedType {
    func share(date: String)
}
class FeedBackTypeView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var feedbacklbl: UILabel!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var typeTableView: UITableView!

   var  delegate: feedType!
    
    var list = ["Seller Registration","Payments","Ordering","Schemes & Offers ","Suggestions/Others"]
    
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
        typeTableView.dataSource = self
        typeTableView.delegate = self
        typeTableView.register(UINib(nibName: "FbTableCell", bundle: nil), forCellReuseIdentifier: "FbTableCell")
       // overView.layer.borderWidth = 1
        overView.clipsToBounds = true
        overView.layer.cornerRadius = 30
        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
        
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
}
extension FeedBackTypeView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FbTableCell") as! FbTableCell
        
        cell.txtLbl.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            delegate.share(date: "Seller Registration")
            self.removeFromSuperview()
        } else if indexPath.row == 1{
            delegate.share(date: "Payments")
            self.removeFromSuperview()
        }else if indexPath.row == 2{
            delegate.share(date: "Ordering")
            self.removeFromSuperview()
        }else if indexPath.row == 3{
            delegate.share(date: "Schemes & Offers")
            self.removeFromSuperview()
        }else if indexPath.row == 4{
            delegate.share(date: "Suggestions/Others")
            self.removeFromSuperview()
        }
    }
}
