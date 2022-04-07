//
//  FirmInfoTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 01/09/21.
//

import UIKit
import iOSDropDown

protocol changePinDelegate{
    func pinchange(pinNum : String)
    func name(person : String)
    func addressOne(addone:String)
    func addreddtwo(addtwo:String)
    
    
    
}

class FirmInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var firmInfoLbl: UILabel!
    @IBOutlet weak var contactTxtField: WhiteUITextField!
    @IBOutlet weak var addOneTxtField: WhiteUITextField!
    @IBOutlet weak var addTwoTxtField: WhiteUITextField!
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var areaDropDown: DropDown!
    @IBOutlet weak var pinTxtField: WhiteUITextField!
    var delegate : changePinDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pinTxtField.delegate = self
        self.contactTxtField.delegate = self
        self.addOneTxtField.delegate = self
        self.addTwoTxtField.delegate = self
//        let cityimg = UIImage(named: "down_arrow")
//        let citybtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
//
//        citybtn.setImage(cityimg, for: .normal)
//        citybtn.addTarget(self, action: #selector(citytaped), for: .touchUpInside)
//        let view4 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//
//        view4.addSubview(citybtn)
//        cityDropDown.rightView = view4
//        cityDropDown.translatesAutoresizingMaskIntoConstraints = false
//        cityDropDown.rightViewMode = .always
//
//        let areaimg = UIImage(named: "down_arrow")
//        let areabtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
//
//        areabtn.setImage(areaimg, for: .normal)
//        areabtn.addTarget(self, action: #selector(areataped), for: .touchUpInside)
//        let view1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//        
//        view1.addSubview(areabtn)
//        areaDropDown.rightView = view1
//        areaDropDown.translatesAutoresizingMaskIntoConstraints = false
//        areaDropDown.rightViewMode = .always
        
//
//        let state = UIImage(named: "down_arrow")
//        let statebtn = UIButton(frame: CGRect(x: 0, y: 10, width: CGFloat(15), height: CGFloat(15)))
//
//        statebtn.setImage(state, for: .normal)
//        statebtn.addTarget(self, action: #selector(statetapped), for: .touchUpInside)
//        let view3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
//
//        view3.addSubview(statebtn)
//        stateDropDown.rightView = view3
//        stateDropDown.translatesAutoresizingMaskIntoConstraints = false
//        stateDropDown.rightViewMode = .always
        let stateleft = UIImageView(frame: CGRect(x: 19, y: 15, width: CGFloat(20), height: CGFloat(20)))
        
        stateleft.image = UIImage(named: "stateicon")
        let stateview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView.addSubview(stateleft)
        stateview.addSubview(emptyView)
        stateDropDown.leftView = stateview
        emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        stateview.backgroundColor = .white
        emptyView.backgroundColor = .white//hexStringToUIColor(hex: "f6f8fd")
        stateDropDown.translatesAutoresizingMaskIntoConstraints = false
        stateDropDown.leftViewMode = .always
        
        let cityleft = UIImageView(frame: CGRect(x: 19, y: 15, width: CGFloat(20), height: CGFloat(20)))
        cityleft.contentMode = .scaleAspectFit
        cityleft.image = UIImage(named: "cityicon")
        let city = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70  , height: 48))
        let emptyView2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView2.addSubview(cityleft)
        city.addSubview(emptyView2)
        cityDropDown.leftView = city
        emptyView2.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        city.backgroundColor = .white
        emptyView2.backgroundColor = .white//hexStringToUIColor(hex: "f6f8fd")
        cityDropDown.translatesAutoresizingMaskIntoConstraints = false
        cityDropDown.leftViewMode = .always
        
        let arealeft = UIImageView(frame: CGRect(x: 19, y: 15, width: CGFloat(20), height: CGFloat(20)))
        
        arealeft.image = UIImage(named: "areaicon")
        let areaa = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70 , height: 48))
        let emptyView3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))
        emptyView3.addSubview(arealeft)
        areaa.addSubview(emptyView3)
        areaDropDown.leftView = areaa
        emptyView3.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
        areaa.backgroundColor = .white
        emptyView3.backgroundColor = .white//hexStringToUIColor(hex: "f6f8fd")
        areaDropDown.translatesAutoresizingMaskIntoConstraints = false
        areaDropDown.leftViewMode = .always
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc  func statetapped(sender: UIButton) {
        
        
        
    }
    @objc  func areataped(sender: UIButton) {
        
    }
    @objc  func citytaped(sender: UIButton) {
        
        
        
    }
}
extension FirmInfoTableViewCell: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == contactTxtField{
            delegate?.name(person: contactTxtField.text!)
        }
        else if textField == addOneTxtField{
            delegate?.addressOne(addone: addOneTxtField.text!)
        }
        else if textField == addTwoTxtField{
            delegate?.addreddtwo(addtwo: addTwoTxtField.text!)
        }else if textField == pinTxtField{
            delegate?.pinchange(pinNum: pinTxtField.text ?? "")

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == pinTxtField{
            if pinTxtField.text?.count == 5{
                if (pinTxtField.text! + string).count == 6{
                    pinTxtField.text = pinTxtField.text! + string
                    print(pinTxtField.text)
                    delegate?.pinchange(pinNum: pinTxtField.text ?? "")
                    
                    
                }else{
                    stateDropDown.text?.removeAll()
                    cityDropDown.text?.removeAll()
                    areaDropDown.text?.removeAll()
                   
                }
                print(pinTxtField.text! + string)
                
               
            }
            let maxLength = 6          // set your need
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
      
        
        
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       return true
    
}
}



