//
//  SortOptionView.swift
//  liveOrder
//
//  Created by Data Prime on 30/08/21.
//
protocol sortDelegate{
    func shortBy(txt:String)
}
import UIKit

class SortOptionView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var sortByLbl: UILabel!
    @IBOutlet weak var selectFromLbl: UILabel!
    @IBOutlet weak var dashView: DashedLineView!
    @IBOutlet weak var sortTableView: UITableView!
    @IBOutlet weak var emtView: UIView!
    
    var delegate : sortDelegate?
    var list = ["Relevance","Newest First","Scheme","Discount"]
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
        sortTableView.dataSource = self
        sortTableView.delegate = self
        sortTableView.register(UINib(nibName: "SortOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "SortOptionTableViewCell")
       
        popUpView.clipsToBounds = true
        popUpView.layer.cornerRadius = 30
        popUpView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            dashView.drawDottedLine(start: CGPoint(x: dashView.bounds.minX, y: dashView.bounds.minY), end: CGPoint(x: dashView.bounds.maxX, y: dashView.bounds.minY), view: dashView)

        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.popUpView.addGestureRecognizer(swipeDown)
        
        
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

extension SortOptionView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOptionTableViewCell") as! SortOptionTableViewCell
        cell.txtLbl.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            delegate?.shortBy(txt: list[indexPath.row])
            self.removeFromSuperview()
        }else if indexPath.row == 1{
            delegate?.shortBy(txt: list[indexPath.row])
            self.removeFromSuperview()
        }else if indexPath.row == 2{
            delegate?.shortBy(txt: list[indexPath.row])
            self.removeFromSuperview()
        }else {
            delegate?.shortBy(txt: list[indexPath.row])
            self.removeFromSuperview()
        }
    }
}

