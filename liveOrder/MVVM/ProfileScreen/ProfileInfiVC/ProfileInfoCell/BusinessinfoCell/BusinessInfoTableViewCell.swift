//
//  BusinessInfoTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 31/08/21.
//

import UIKit
import iOSDropDown
class BusinessInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bussinssLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var firmLbl: UILabel!
    @IBOutlet weak var addLicense1Lbl: UILabel!
    @IBOutlet weak var drugTxtField: WhiteUITextField!
    @IBOutlet weak var validTxtField: WhiteUITextField!
    @IBOutlet weak var gstTxtField: WhiteUITextField!
    @IBOutlet weak var gstINNumerTxtField: WhiteUITextField!
    @IBOutlet weak var addLicense2Lbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var drugLicense2TxtField: WhiteUITextField!
    @IBOutlet weak var validTeoTxtField: WhiteUITextField!
    
    @IBOutlet weak var gstDropDownTxtField: DropDown!
    @IBOutlet weak var gstTypeTwoDropdown: DropDown!
    
    @IBOutlet weak var gstinNumberTwoTxtField: WhiteUITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gstINNumerTxtField.autocapitalizationType = .allCharacters
        gstinNumberTwoTxtField.autocapitalizationType = .allCharacters
        
        gstINNumerTxtField.delegate = self
//        let downarrow = UIImageView(frame: CGRect(x: 0, y: 12, width: CGFloat(14), height: CGFloat(10)))
//        downarrow.image = UIImage(named: "down_arrow")
//
//        let gsttype = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
//
//        gsttype.addTarget(self, action: #selector(gstapped), for: .touchUpInside)
//        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//        view3.addSubview(downarrow)
//        view3.addSubview(gsttype)
//        gstDropDownTxtField.rightView = view3
//        gstDropDownTxtField.translatesAutoresizingMaskIntoConstraints = false
//        gstDropDownTxtField.rightViewMode = .always
        
//        let downarrowt = UIImageView(frame: CGRect(x: 0, y: 12, width: CGFloat(14), height: CGFloat(10)))
//        downarrowt.image = UIImage(named: "down_arrow")
//
//        let gsttypet = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
//
//        gsttypet.addTarget(self, action: #selector(gstapped), for: .touchUpInside)
//        let view3t = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//        view3t.addSubview(downarrowt)
//        view3t.addSubview(gsttypet)
//        gstTypeTwoDropdown.rightView = view3t
//        gstTypeTwoDropdown.translatesAutoresizingMaskIntoConstraints = false
//        gstTypeTwoDropdown.rightViewMode = .always
//
        let gstleft = UIImageView(frame: CGRect(x: 20, y: 15, width: CGFloat(18), height: CGFloat(18)))

        gstleft.image = UIImage(named: "stateicon")
        
        let gstview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70  , height: 48))
        let gstView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        gstView.addSubview(gstleft)
        gstview.addSubview(gstView)
        gstTypeTwoDropdown.leftView = gstview
        gstView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        gstview.backgroundColor = .white
        gstView.backgroundColor = .white //hexStringToUIColor(hex: "f6f8fd")
        gstTypeTwoDropdown.translatesAutoresizingMaskIntoConstraints = false
        gstTypeTwoDropdown.leftViewMode = .always
        
        let stateleft = UIImageView(frame: CGRect(x: 20, y: 15, width: CGFloat(18), height: CGFloat(18)))

        stateleft.image = UIImage(named: "stateicon")
        
        let stateview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70  , height: 48))
        let emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView.addSubview(stateleft)
        stateview.addSubview(emptyView)
        gstDropDownTxtField.leftView = stateview
        emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        stateview.backgroundColor = .white
        emptyView.backgroundColor = .white //hexStringToUIColor(hex: "f6f8fd")
        gstDropDownTxtField.translatesAutoresizingMaskIntoConstraints = false
        gstDropDownTxtField.leftViewMode = .always
        
        
        let cameraimgView = UIImageView(frame: CGRect(x: 0, y: 7, width: CGFloat(20), height: CGFloat(20)))
        
        
        cameraimgView.image = UIImage(named: "camera")
        
        let passwordButton = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
        passwordButton.addTarget(self, action: #selector(camerataped1), for: .touchUpInside)
        let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        views.addSubview(passwordButton)
        views.addSubview(cameraimgView)
        drugTxtField.rightView = views
        drugTxtField.translatesAutoresizingMaskIntoConstraints = false
        drugTxtField.rightViewMode = .always
        
        let cameraimgViewtwo = UIImageView(frame: CGRect(x: 0, y: 7, width: CGFloat(20), height: CGFloat(20)))
        cameraimgViewtwo.image = UIImage(named: "camera")
        let cameratwobtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))

        
        cameratwobtn.addTarget(self, action: #selector(camerataped2), for: .touchUpInside)
        let view2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        
        view2.addSubview(cameratwobtn)
        view2.addSubview(cameraimgViewtwo)
        drugLicense2TxtField.rightView = view2
        drugLicense2TxtField.translatesAutoresizingMaskIntoConstraints = false
        drugLicense2TxtField.rightViewMode = .always
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @objc func gstapped(){
//        
//    }
    @objc func camerataped1(){
        
    }
    @objc func camerataped2(){
        
    }
    
    
}
extension BusinessInfoTableViewCell : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == gstINNumerTxtField{
            if string.rangeOfCharacter(from: .alphanumerics) != nil || string == ""{
                if gstINNumerTxtField.text?.count == 14{
                    if ((gstINNumerTxtField.text)! + string).count == 15{
                        gstINNumerTxtField.text = gstINNumerTxtField.text! + string
                        if (gstINNumerTxtField.text)?.gstValid(gstNum: gstINNumerTxtField.text ?? "") == true{
                            gstINNumerTxtField.resignFirstResponder()
                        }else{
                            
                            gstINNumerTxtField.placeholder = "Enter Valid Number"
                            UIView().showToast(message: "Not Valid Number", view: self.contentView)
                        }
                    }
                    
                }
                let maxLength = 15          // set your need
                                          let currentString: NSString = textField.text! as NSString
                                          let newString: NSString =
                                              currentString.replacingCharacters(in: range, with: string) as NSString
                               
                               
                                          return newString.length <= maxLength
                    
                }else {
                    return false
                }
           
        }
        
        return true
    }
}
