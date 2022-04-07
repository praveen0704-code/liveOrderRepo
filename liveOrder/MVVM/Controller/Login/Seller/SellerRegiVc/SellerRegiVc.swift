//
//  SellerRegiVc.swift
//  liveOrder
//
//  Created by Data Prime on 08/11/21.
//

import UIKit
import Alamofire

class SellerRegiVc: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sellerTableView: UITableView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var nextbtn = 0
    var legalitenti = 0
    var firmupdateModel : FirmUpdateModel?
    
    var personName : String?
    var mobileNum: String?
    var email : String?
    var addOne : String?
    var addTwo : String?
    var pincode : String?
    var state : String?
    var city : String?
    var area : String?
    var stateCode : String?
    var cityCode : String?
    var areaCode : String?
    
    
    var licenseOne : String?
    var licenseTwo : String?
    var valid : String?
    var gstType : String?
    var gstinNum : String?
    var narotic : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        //        doneBtn.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        sellerTableView.delegate = self
        sellerTableView.dataSource = self
        sellerTableView.register(UINib(nibName: "BuyerRegistrationCell", bundle: nil), forCellReuseIdentifier: "BuyerRegistrationCell")
        sellerTableView.register(UINib(nibName: "sellerRegistrationCell", bundle: nil), forCellReuseIdentifier: "sellerRegistrationCell")
    }
    
    @IBAction func backBtnAct(_ sender: Any) {
    }
    @IBAction func nextBtnAct(_ sender: Any) {
        if nextbtn == 0 {
            nextbtn = 1
            sellerTableView.reloadData()
        }else {
            legalitenti = 1
            sellerTableView.reloadData()
        }
        
        
        
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
extension SellerRegiVc: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if nextbtn == 1 {
            let sellerDetailCell = tableView.dequeueReusableCell(withIdentifier: "BuyerRegistrationCell", for: indexPath)as! BuyerRegistrationCell
            sellerDetailCell.skipBtn.addTarget(self, action: #selector(skipBtnAct), for: .touchUpInside)
            
            if sellerDetailCell.personNameTxtFiled.text!.count > 3 && sellerDetailCell.personNameTxtFiled.text!.count <= 16 && sellerDetailCell.emailTxtFIeld.text?.isValidEmail(testStr: sellerDetailCell.emailTxtFIeld.text!) == true && sellerDetailCell.addOneTxtFiled.text?.count != 0 && sellerDetailCell.addOneTxtFiled.text!.count <= 20 && sellerDetailCell.addTwoTxtFiled.text?.count != 0 && sellerDetailCell.addTwoTxtFiled.text!.count <= 20 &&  sellerDetailCell.pinCodeTxtField.text?.count != 0 && sellerDetailCell.pinCodeTxtField.text!.count == 6 && sellerDetailCell.stateDropDown.text?.count != 0 && sellerDetailCell.cityDropDown.text?.count != 0 && sellerDetailCell.areaDropDown.text?.count != 0{
                
                personName = sellerDetailCell.personNameTxtFiled.text
                email = sellerDetailCell.emailTxtFIeld.text
                addOne = sellerDetailCell.addOneTxtFiled.text
                addTwo = sellerDetailCell.addTwoTxtFiled.text
                state = sellerDetailCell.stateDropDown.text
                
                city = sellerDetailCell.cityDropDown.text
                
                area = sellerDetailCell.areaDropDown.text
                pincode = sellerDetailCell.pinCodeTxtField.text
                print(personName,email,addTwo,addOne,stateCode,state,city,cityCode,area,areaCode)
                nextbtn = 2
                sellerTableView.reloadData()
                
                
                
            }else if sellerDetailCell.personNameTxtFiled.text!.count < 3 || sellerDetailCell.personNameTxtFiled.text!.count >= 16 {
                sellerDetailCell.personNameTxtFiled.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.personNameTxtFiled.placeholder = "    Please enter the valid Name"
                sellerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
                
            }else if sellerDetailCell.emailTxtFIeld.text!.count == 0 {
                sellerDetailCell.emailTxtFIeld.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.emailTxtFIeld.placeholder = "    Please enter the valid Mail"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            }else if sellerDetailCell.addOneTxtFiled.text?.count == 0  {
                sellerDetailCell.addOneTxtFiled.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.addOneTxtFiled.placeholder = "Enter the address - 1"
                sellerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }
            else if sellerDetailCell.addTwoTxtFiled.text?.count == 0  {
                sellerDetailCell.addTwoTxtFiled.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.addTwoTxtFiled.placeholder = "Enter the address - 2"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if sellerDetailCell.pinCodeTxtField.text?.count == 0  {
                sellerDetailCell.pinCodeTxtField.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.pinCodeTxtField.placeholder = "PinCode"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if sellerDetailCell.stateDropDown.text?.count == 0  {
                sellerDetailCell.stateDropDown.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.stateDropDown.placeholder = "Select the state"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.emailTxtFIeld.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
            }else if sellerDetailCell.cityDropDown.text?.count == 0  {
                sellerDetailCell.cityDropDown.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.cityDropDown.placeholder = "Select the city"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.emailTxtFIeld.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.areaDropDown.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            }else if sellerDetailCell.areaDropDown.text?.count == 0  {
                sellerDetailCell.areaDropDown.layer.borderColor = UIColor.red.cgColor
                sellerDetailCell.areaDropDown.placeholder = "Select the area"
                sellerDetailCell.personNameTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.emailTxtFIeld.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addOneTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.addTwoTxtFiled.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.pinCodeTxtField.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.stateDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                sellerDetailCell.cityDropDown.layer.borderColor =  #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                
            } else {
                print("check")
                UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
            }
            return sellerDetailCell
            
            
        }else if nextbtn == 2{
            if legalitenti == 1{
                let sellerDetailCell = tableView.dequeueReusableCell(withIdentifier: "sellerRegistrationCell", for: indexPath)as! sellerRegistrationCell
                sellerDetailCell.skipBtn.addTarget(self, action: #selector(skipBtnAct), for: .touchUpInside)
                if  sellerDetailCell.LicenseOneTxtField.text!.count > 3 && sellerDetailCell.LicenseOneTxtField.text!.count <= 16 && sellerDetailCell.licenseTwoTxtField.text!.count > 3 && sellerDetailCell.licenseTwoTxtField.text!.count <= 16 && sellerDetailCell.validTxtField.text?.count != 0 && sellerDetailCell.validTxtField.text!.count <= 20 &&  sellerDetailCell.gstTypeTxtField.text?.count != 0 && sellerDetailCell.gstInNumTxtField.text!.count <= 10 && sellerDetailCell.naroticNumTxtField.text?.count != 0 && sellerDetailCell.naroticNumTxtField.text!.count <= 10{
                    
                    licenseOne = sellerDetailCell.LicenseOneTxtField.text
                    licenseTwo = sellerDetailCell.licenseTwoTxtField.text
                    valid = sellerDetailCell.validTxtField.text
                    gstType = sellerDetailCell.gstTypeTxtField.text
                    gstinNum = sellerDetailCell.gstInNumTxtField.text
                    narotic = sellerDetailCell.naroticNumTxtField.text
                    print(licenseOne,licenseTwo,valid,gstType,gstinNum,narotic)
                    registerApi()
                    
                    
                    
                }else if sellerDetailCell.LicenseOneTxtField.text!.count < 3  {
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.LicenseOneTxtField.placeholder = "    Please enter the valid Name"
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                    
                    
                }else if sellerDetailCell.licenseTwoTxtField.text!.count < 3  {
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.licenseTwoTxtField.placeholder = "    Please enter the valid Name"
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                    
                    
                }else if sellerDetailCell.validTxtField.text!.count == 0 {
                    sellerDetailCell.validTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.validTxtField.placeholder = "    Please enter the valid Mail"
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                    
                }else if sellerDetailCell.gstTypeTxtField.text?.count == 0  {
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.gstTypeTxtField.placeholder = "Enter the address - 1"
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                    
                }
                else if sellerDetailCell.gstInNumTxtField.text?.count == 0 && sellerDetailCell.gstInNumTxtField.text!.count >= 10 {
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.gstInNumTxtField.placeholder = "Enter the address - 2"
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                }else if sellerDetailCell.naroticNumTxtField.text?.count == 0 && sellerDetailCell.naroticNumTxtField.text!.count >= 10 {
                    sellerDetailCell.naroticNumTxtField.layer.borderColor = UIColor.red.cgColor
                    sellerDetailCell.naroticNumTxtField.placeholder = "PinCode"
                    sellerDetailCell.LicenseOneTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.licenseTwoTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.validTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstTypeTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    sellerDetailCell.gstInNumTxtField.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
                    
                    
                }
                
                
                else {
                    print("check")
                    UIView().showToast(message: "Something went wrong recheck the details", view: self.view)
                }
                return sellerDetailCell
            }else{
                let sellerDetailCell = tableView.dequeueReusableCell(withIdentifier: "sellerRegistrationCell", for: indexPath)as! sellerRegistrationCell
                sellerDetailCell.skipBtn.addTarget(self, action: #selector(skipBtnAct), for: .touchUpInside)
                return sellerDetailCell
            }
            
        }else{
            let sellerDetailCell = tableView.dequeueReusableCell(withIdentifier: "BuyerRegistrationCell", for: indexPath)as! BuyerRegistrationCell
            sellerDetailCell.skipBtn.addTarget(self, action: #selector(skipBtnAct), for: .touchUpInside)
            return sellerDetailCell
        }
        
    }
    @objc func skipBtnAct(){
        if #available(iOS 13.0, *) {
            let landingVc = self.storyboard?.instantiateViewController(identifier: "LoHomeViewController") as! LoHomeViewController
            self.navigationController?.pushViewController(landingVc, animated: true)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}
extension SellerRegiVc : WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        
    }
    
    func registerApi(){
        
        let registerApi:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "RegisterApi")
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"JFItIDifO7G4i9jAPAAFpw==",
        //                                    "X-csquare-api-token":"1371757505f37f2c",
        //                                    "Content-Type":"application/json",
        //                                        ]
        //
        
        let registParams: [String: Any] = ["c_firm_name":personName,
                                           "c_mobile_no":mobileNum,
                                           "c_pincode":pincode,
                                           "c_firm_img":"",
                                           "c_email_id":email,
                                           "c_drug_license_no1":licenseOne,
                                           "c_drug_license_no1_img":"yyyyyyy",
                                           "c_drug_license_no1_expiry_date":"2021-09-30",
                                           "c_drug_license_no2":licenseTwo,
                                           "c_drug_license_no2_img":"",
                                           "c_drug_license_no2_expiry_date":"2021-09-30",
                                           "c_gst_type":gstType,
                                           "c_gst_number":gstinNum,
                                           "c_narcotic_no":narotic,
                                           "c_contact_person_name":personName,
                                           "c_address_no1":addOne,
                                           "c_address_no2":addTwo,
                                           "c_state_code":stateCode,
                                           "c_state_name":state,
                                           "c_city_code":cityCode,
                                           "c_city_name":city,
                                           "c_area_code":areaCode,
                                           "c_area_name":area
        ]
        
        
        
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        registerApi.callServiceAndGetData(url: LIVE_ORDER_HOSTURL + FIRM_FOR_URL, type: .post, userData: registParams, apiHeader: sHeader, successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            if boolSuccess {
                
                
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
        
        
    }
    
    
    
    
}
