//
//  SetPriorityFiltterView.swift
//  liveOrder
//
//  Created by Data Prime on 23/11/21.
//

import UIKit

class SetPriorityFiltterView: UIView {
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filtterLbl: UILabel!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var filterTableView: UITableView!
    
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
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.register(UINib(nibName: "PriorityFilterCell", bundle: nil), forCellReuseIdentifier: "PriorityFilterCell")
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 30
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        dotView.drawDottedLine(start: CGPoint(x: dotView.bounds.minX, y: dotView.bounds.minY), end: CGPoint(x: dotView.bounds.maxX, y: dotView.bounds.minY), view: dotView)
       

}
}
extension SetPriorityFiltterView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityFilterCell") as! PriorityFilterCell
        cell.roundLbl.layer.masksToBounds = true
        cell.roundLbl.layer.cornerRadius = cell.roundLbl.frame.width / 2
        
        return cell
    }
    
    
}
