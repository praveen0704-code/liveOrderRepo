//
//  AddSellerVC.swift
//  liveOrder
//
//  Created by Data Prime on 16/09/21.
//

import UIKit

class AddSellerVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sendReqLbl: UILabel!
    @IBOutlet weak var retrivalLbl: UILabel!
    @IBOutlet weak var lineView: DashedLineView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var storeInfoLbl: UILabel!
    @IBOutlet weak var storeNameTxtField: WhiteUITextField!
    @IBOutlet weak var personNameTxtField: WhiteUITextField!
    @IBOutlet weak var mobileNumTxtField: WhiteUITextField!
    @IBOutlet weak var firmLegalLbl: UILabel!
    @IBOutlet weak var zipCodeTxtField: WhiteUITextField!
    @IBOutlet weak var cameraImgView: UIImageView!
    @IBOutlet weak var drugLicenseTxtField: WhiteUITextField!
    @IBOutlet weak var datetxtField: WhiteUITextField!
    @IBOutlet weak var gdtTypeTxtField: WhiteUITextField!
    @IBOutlet weak var arraowImgView: UIImageView!
    @IBOutlet weak var gstInNumTxtField: WhiteUITextField!
    @IBOutlet weak var firmLegalTwoLbl: UILabel!
    @IBOutlet weak var addressIneTxtField: WhiteUITextField!
    @IBOutlet weak var addressTwoTxtField: WhiteUITextField!
    @IBOutlet weak var pincodeTxtField: WhiteUITextField!
    @IBOutlet weak var stateTxtField: WhiteUITextField!
    @IBOutlet weak var cityTxtField: WhiteUITextField!
    @IBOutlet weak var areaTxtField: WhiteUITextField!
    @IBOutlet weak var landMarkTxtField: WhiteUITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendBtnAct(_ sender: Any) {
    }
    @IBAction func cancelBtnAct(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
