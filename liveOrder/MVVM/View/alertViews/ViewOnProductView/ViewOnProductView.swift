//
//  ViewOnProductView.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//

import UIKit

class ViewOnProductView: UIView {
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var headLbl: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var prolistTableView: UITableView!
    var listlblcell = ["Complete Up & Down Visibility","View On Rate","View On Scheme/Discount","Availability In Stock"]
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
        prolistTableView.dataSource = self
        prolistTableView.delegate = self
        prolistTableView.register(UINib(nibName: "onProdctTableCell", bundle: nil), forCellReuseIdentifier: "onProdctTableCell")
        overview.layer.borderWidth = 1
        overview.clipsToBounds = true
        overview.layer.cornerRadius = 30
        overview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overview.addGestureRecognizer(swipeDown)
        
        
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

extension ViewOnProductView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onProdctTableCell") as! onProdctTableCell
        cell.listLbl.text = listlblcell[indexPath.row]
        
        return cell
    }
    
    
}

