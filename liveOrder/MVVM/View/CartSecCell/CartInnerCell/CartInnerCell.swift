//
//  CartInnerCell.swift
//  liveOrder
//
//  Created by Data Prime on 13/09/21.
//

import UIKit
import  iOSDropDown

class CartInnerCell: UITableViewCell {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var packSizeLbl: UILabel!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var ptrLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var paracetamalLbl: UILabel!
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var totalMrpLbl: UILabel!
    @IBOutlet weak var dropDownTxtField: DropDown!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var innerCellSelectQtyArr = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        imgeView.layer.cornerRadius = 8
        let state = UIImage(named: "down_arrow")
        let statebtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        statebtn.setImage(state, for: .normal)
        statebtn.addTarget(self, action: #selector(droDownTapped), for: .touchUpInside)
        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view3.addSubview(statebtn)
        dropDownTxtField.rightView = view3
        dropDownTxtField.translatesAutoresizingMaskIntoConstraints = false
        dropDownTxtField.rightViewMode = .always
        
       
        dropDownTxtField.optionArray = ["1", "2", "3","4"]
        dropDownTxtField.optionIds = [1,23,54,22]
        dropDownTxtField.isSearchEnable = false
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func droDownTapped(){
        dropDownTxtField.didSelect{(selectedText , index ,id) in
            
        self.dropDownTxtField.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }
    @IBAction func sortBookbtnAct(_ sender: Any) {
    }
}

