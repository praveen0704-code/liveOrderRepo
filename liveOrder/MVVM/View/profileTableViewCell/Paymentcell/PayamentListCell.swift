//
//  PayamentListCell.swift
//  liveOrder
//
//  Created by Data Prime on 20/08/21.
//

import UIKit
protocol selectDelegate {
    func didselect(type: String)
    
}

class PayamentListCell: UITableViewCell {
    @IBOutlet weak var overViewP: UIView!
    @IBOutlet weak var paymentsLbl: UILabel!
    @IBOutlet weak var leftimgeView: UIImageView!
    @IBOutlet weak var paymentHeader: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var paymentListTbleView: UITableView!
    
    var delegate:selectDelegate?
    var paymentsList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        paymentsList = ["Preferred Payments","Credit & Debit Cards","LO Wallet","Other Wallet"]
        
        paymentListTbleView.register(UINib(nibName: "innerPaymentCell", bundle: nil), forCellReuseIdentifier: "innerPaymentCell")
        paymentListTbleView.delegate = self
        paymentListTbleView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension PayamentListCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let paymentcell = tableView.dequeueReusableCell(withIdentifier: "innerPaymentCell", for: indexPath)as! innerPaymentCell
        paymentcell.paylistLbl.text = paymentsList[indexPath.row]
        return paymentcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            delegate?.didselect(type: "0")
            
        }else if indexPath.row == 1 {
            delegate?.didselect(type: "1")
            
        }else if indexPath.row == 2 {
            delegate?.didselect(type: "2")
            
        }else if indexPath.row == 3 {
            delegate?.didselect(type: "3")
            
        }
        
    }
}
