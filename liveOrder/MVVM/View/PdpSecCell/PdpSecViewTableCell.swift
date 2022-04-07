//
//  PdpSecViewTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit
import iOSDropDown

class PdpSecViewTableCell: UITableViewCell {
    
    
   
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var sellerLbl: UILabel!
    @IBOutlet weak var numOfSellLbl: UILabel!
    @IBOutlet weak var sponsoredLbl: UILabel!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sellerTableView: UITableView!
    var pSelectedIndexPath = Int()

 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sellerTableView.delegate = self
        sellerTableView.dataSource = self
   
    }

    @IBAction func sortBtnAct(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension PdpSecViewTableCell : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return quantityArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        sellerTableView.register(UINib(nibName: "PdpSecCell", bundle: nil), forCellReuseIdentifier: "PdpSecCell")
        let pdCell = tableView.dequeueReusableCell(withIdentifier: "PdpSecCell", for: indexPath) as! PdpSecCell
        
//        pdCell.quantityDropDown.tag = indexPath.row
        
        
        pdCell.quantityDropDown.text = quantityArray[indexPath.row]

        pdCell.quantityDropDown.didSelect{(selectedText , index ,id) in
            pdCell.quantityDropDown.showList()
            quantityArray[indexPath.row] = selectedText
            
            self.sellerTableView.reloadData()
            self.sellerTableView.layoutIfNeeded()
            
            
            
            
            self.sellerTableView.reloadData()
        }
    
        return pdCell
      
    }
    
    
    

    
    
    
    
}
