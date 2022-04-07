//
//  LcMainSearchFilterView.swift
//  liveOrder
//
//  Created by Data Prime on 22/07/21.
//

import UIKit
protocol passIndexDelegate {
    func selectedIndex(indexInt:Int)
}


class LcMainSearchFilterView: UIView, CustomCellDelegate {
   

    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var selectSortingLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var contentTableview: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    
    var contentNames = ["Products","Sellers","Manufacturer","Molecule/ Generic"]
    var checked = [Bool]()
    var selectstring = 0 
    
    var passValDelegate:passIndexDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        checked = Array(repeating: false, count: contentNames.count)
       
        overAllView.clipsToBounds = true
        overAllView.layer.cornerRadius = 30
        overAllView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.frame = UIScreen.main.bounds
        contentTableview.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        contentTableview.dataSource = self
        contentTableview.delegate = self
        
//        self.applyBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
    }
    @IBAction func backBtnAct(_ sender: Any) {
        self.removeFromSuperview()
    }
    //MARK: - Delegate Meathods
    func animationStarted(index : Int) {
       selectstring = index

        contentTableview.reloadData()
    }
    
    func animationFinished() {
        print("Success1")
    }
    
    @IBAction func applyAction(_ sender: Any) {
        passValDelegate?.selectedIndex(indexInt: selectstring ?? 0)
        self.removeFromSuperview()

    }
}
extension LcMainSearchFilterView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
        
       
        cell.ContentLbl.text = contentNames[indexPath.row]
        cell.selectedBtn.tag = indexPath.row
 
        cell.delegate = self
        cell.selectedBtn.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        cell.index = indexPath.row
        if selectstring == indexPath.row{
            cell.selectedBtn.borderColor = UIColor.clear
            cell.selectedBtn.backgroundColor = UIColor(hexString: "674CF3")
            cell.selectedBtn.setBackgroundImage(UIImage(named: "tickWhite"), for: UIControl.State.normal)
            

        }else{

            cell.selectedBtn.borderColor = UIColor(hexString: "C3CDE4")
            cell.selectedBtn.borderWidth = 1.0
            cell.selectedBtn.clipsToBounds = true
            cell.selectedBtn.backgroundColor = .white
            cell.selectedBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        }
       
        
        
               return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectstring = indexPath.row
        contentTableview.reloadData()
        
    }
    
    //MARK: - Button Action
    @objc func checkAction(sender:UIButton){
        selectstring = sender.tag

        
    }
}
