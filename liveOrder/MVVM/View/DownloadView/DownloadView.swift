//
//  DownloadView.swift
//  liveOrder
//
//  Created by Data Prime on 03/12/21.
//

import UIKit

class DownloadView: UIView {
    @IBOutlet weak var removeView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var excelBtn: UIButton!
    @IBOutlet weak var excelImgView: UIImageView!
    @IBOutlet weak var excelLbl: UILabel!
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var pdfImgView: UIImageView!
    @IBOutlet weak var pdfLbl: UILabel!
    @IBOutlet weak var csvBtn: UIButton!
    @IBOutlet weak var csvImgView: UIImageView!
    @IBOutlet weak var csvLbl: UILabel!
    @IBOutlet weak var lineOneLbl: UILabel!
    @IBOutlet weak var lineTwoLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        
        excelBtn.backgroundColor = .white
        pdfBtn.backgroundColor = .white
        csvBtn.backgroundColor = .white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(hexString: "c3cde4").cgColor
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
             
        // 2. add the gesture recognizer to a view
        removeView.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
       }
   
}
