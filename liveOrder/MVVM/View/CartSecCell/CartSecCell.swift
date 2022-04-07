//
//  CartSecCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit

class CartSecCell: UITableViewCell {
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var mfgLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var arrowImge: UIImageView!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var amountGstLbl: UILabel!
    @IBOutlet weak var totalAmountRupeeLbl: UILabel!
    @IBOutlet weak var gstRupeLbl: UILabel!
    @IBOutlet weak var amountGstRupeeLbl: UILabel!
    
    var cartlistModel : CartListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(UINib(nibName: "CartInnerCell", bundle: nil), forCellReuseIdentifier: "CartInnerCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
extension CartSecCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartlistModel?.payloadJson?.data?.jSupplier?[0].jItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            
            
            let innerCell = tableView.dequeueReusableCell(withIdentifier: "CartInnerCell", for: indexPath)as! CartInnerCell
            
            return innerCell
   
    }
    
    
}
