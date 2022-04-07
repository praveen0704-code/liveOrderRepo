//
//  WatchListOptionView.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit

protocol moreBtnDelegate {
    func morebtnact(type: String,senderCode: String,senderName:String)
}

class WatchListOptionView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var watchOptionTableView: UITableView!
    
    @IBOutlet weak var removeView: UIView!
    
    var listoption = ["View On Product","Remove From Watchlist"]
    var logoImage: [UIImage] = [
        UIImage(named: "eye-1")!,
        UIImage(named: "delete")!]
    var delegate : moreBtnDelegate?
    var senderItemcode : String?
    var senderItemName: String?
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
        watchOptionTableView.dataSource = self
        watchOptionTableView.delegate = self
        watchOptionTableView.register(UINib(nibName: "watchOptionTableViewTableViewCell", bundle: nil), forCellReuseIdentifier: "watchOptionTableViewTableViewCell")
//        overView.layer.borderWidth = 1
        overView.clipsToBounds = true
//        overView.layer.cornerRadius = 30
//        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
                removeView.addGestureRecognizer(tapGesture)
        
        
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
}

extension WatchListOptionView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listoption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchOptionTableViewTableViewCell") as! watchOptionTableViewTableViewCell
        cell.leftImageView.image = logoImage[indexPath.row]
        cell.listLbl.text = listoption[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            delegate?.morebtnact(type: "1",senderCode: senderItemcode ?? "", senderName: senderItemName ?? "")
            self.removeFromSuperview()
        }else{
            delegate?.morebtnact(type: "0",senderCode: senderItemcode ?? "", senderName: senderItemName ?? "")
            self.removeFromSuperview()
            }
    }
    
}

