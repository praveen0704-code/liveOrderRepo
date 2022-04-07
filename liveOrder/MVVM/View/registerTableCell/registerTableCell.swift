//
//  registerTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 16/09/21.
//

import UIKit

class registerTableCell: UITableViewCell{
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var giveLbl: UILabel!
    
    @IBOutlet weak var sellerNameTxtField: WhiteUITextField!
    @IBOutlet weak var licenseTxtField: WhiteUITextField!
    @IBOutlet weak var gstinTxtField: WhiteUITextField!
    @IBOutlet weak var mobileTxtField: WhiteUITextField!
    @IBOutlet weak var stateTxtField: WhiteUITextField!
    @IBOutlet weak var cityTxtField: WhiteUITextField!
    
    
    
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var maxiLbl: UILabel!
    @IBOutlet weak var desTxtView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    // ERROR LABEL OUT LETS
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var licenseErrorLbl: UILabel!
    @IBOutlet weak var gstinErrorLbl: UILabel!
    @IBOutlet weak var mobileErorLbl: UILabel!
    @IBOutlet weak var stateErorLbl: UILabel!
    @IBOutlet weak var cityErrorLbl: UILabel!
    
    // HEIGHT OUT LET FOR ERROR
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var licenseHeight: NSLayoutConstraint!
    @IBOutlet weak var gstinHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileHeight: NSLayoutConstraint!
    @IBOutlet weak var stateHeight: NSLayoutConstraint!
    @IBOutlet weak var cityHeight: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        desTxtView.text = "  Write here.."
        desTxtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        sellerNameTxtField.delegate = self
        licenseTxtField.delegate = self
        gstinTxtField.delegate = self
        mobileTxtField.delegate = self
        stateTxtField.delegate = self
        cityTxtField.delegate = self
        
        desTxtView.delegate = self
        nameHeight.constant = 0.0
        nameErrorLbl.layoutIfNeeded()
        licenseHeight.constant = 0.0
        licenseErrorLbl.layoutIfNeeded()
        gstinHeight.constant = 0.0
        gstinErrorLbl.layoutIfNeeded()
        mobileHeight.constant = 0.0
        mobileErorLbl.layoutIfNeeded()
        stateHeight.constant = 0.0
        stateErorLbl.layoutIfNeeded()
        cityHeight.constant = 0.0
        cityErrorLbl.layoutIfNeeded()
        let starTxt = "*"
        self.desLbl.text = "Description " + starTxt
        desLbl.setSubTextColor(pSubString: starTxt, pColor: .red)
        
        let colorString = "500"
                self.maxiLbl.text = "Max " + colorString + " character"
        maxiLbl.setSubTextColor(pSubString: colorString, pColor: .init(red: 0, green: 211, blue: 180, alpha: 1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension registerTableCell : UITextViewDelegate {
     func textViewDidBeginEditing(_ textView: UITextView) {
        if desTxtView.textColor == UIColor(hexString: "5b636a", alpha: 0.50) {
            desTxtView.text = nil
            desTxtView.textColor = UIColor(hexString: "5b636a")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if desTxtView.text.isEmpty {
            desTxtView.text = "  Write here.."
            desTxtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        }
    }
}
extension registerTableCell : UITextFieldDelegate{
    
}
