//
//  OrderTableCell.swift
//  liveOrder
//
//  Created by Data Prime on 02/12/21.
//

import UIKit
import StepIndicator


class OrderTableCell: UITableViewCell {
    
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var outerImgView: UIView!
    @IBOutlet weak var MfgImgView: UIImageView!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var medicalNameLbl: UILabel!
    @IBOutlet weak var topAmountlbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var orderDataLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var outStandingLbl: UILabel!
    @IBOutlet weak var botomAmountLbl: UILabel!
    @IBOutlet weak var shipingView: UIView!
    @IBOutlet weak var fromToLbl: UILabel!
    @IBOutlet weak var downLoadBtn: UIButton!
    @IBOutlet weak var downloadImge: UIImageView!
    @IBOutlet weak var stepperView: StepIndicatorView!
    @IBOutlet weak var orderConfirmLbl: UILabel!
    @IBOutlet weak var processLbl: UILabel!
    @IBOutlet weak var orderDispatchlbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    
    @IBOutlet weak var orderInvoiceLbl: UILabel!
    @IBOutlet weak var payOutStandBtn: UIButton!
    @IBOutlet weak var reOrderBtn: UIButton!
 
    @IBOutlet weak var bottomLineView: UIView!
    
    @IBOutlet weak var docView: UIView!
    @IBOutlet weak var excelImgView: UIImageView!
    
    @IBOutlet weak var excelLbl: UILabel!
    @IBOutlet weak var excelBtn: UIButton!
    @IBOutlet weak var lineOneLbl: UILabel!
    
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var pdfImgeView: UIImageView!
    @IBOutlet weak var pdfLbl: UILabel!
    @IBOutlet weak var lineTwolbl: UILabel!
    @IBOutlet weak var csvBtn: UIButton!
    @IBOutlet weak var csvImgView: UIImageView!
    @IBOutlet weak var csvLbl: UILabel!
    @IBOutlet weak var alterNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       

        excelBtn.backgroundColor = .white
        pdfBtn.backgroundColor = .white
        csvBtn.backgroundColor = .white
        docView.layer.borderWidth = 0.5
        docView.layer.borderColor = UIColor(hexString: "c3cde4").cgColor
        docView.layer.cornerRadius = 8
        docView.clipsToBounds = true
        
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
