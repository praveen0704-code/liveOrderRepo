//
//  ProfileVC.swift
//  liveOrder
//
//  Created by Data Prime on 05/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import NotificationBannerSwift

class ProfileVC: UIViewController ,selectDelegate,proInfoDelegate{
   
    
    // TOP VIEW OUTLETS
    @IBOutlet weak var TopBarView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    // MARK profileImgview is pencil view in vc
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var profilePhotoView: UIView!
    @IBOutlet weak var profileimgeView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var OwnerLbl: UILabel!
    @IBOutlet weak var medicalsName: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var locationImgView: UIImageView!
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var alterproNameLbl: UILabel!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBAction func profileImgButton(_ sender: Any) {
        
    }
    
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
   
    
    var selectedIndexzero : NSInteger! = -1 //Delecre this global
    var selectedindexone : NSInteger = -1
    var selectedIndextwo : NSInteger! = -1 //Delecre this global
    var selectedindexthree : NSInteger = -1
    var selectedindexfour : NSInteger = -1
    var selectedindexfive : NSInteger = -1
    var selectedIndexsis : NSInteger! = -1 //Delecre this global
    var selectedIndexseven : NSInteger! = -1 //Delecre this global
    var arrowimgone = false
    var arrowimgtwo = false
    var arrowimgthree = false
    var arrowimgfour = false
    var arrowimgfive = false
    
    var branchCellHeight : CGFloat?
    
   
    var firmProfileModel : FirmProfileModel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        OwnerLbl.isHidden = true
        
        
      
        getProfile()
    }
    func setup(){
        self.imageButton.setTitle("", for: .normal)
        OwnerLbl.layer.cornerRadius = 4
        OwnerLbl.layer.masksToBounds = true
        
        profilePhotoView.layer.cornerRadius = 15
        profileimgeView.layer.cornerRadius = 10
        TopBarView.clipsToBounds = true
        TopBarView.layer.cornerRadius = 30
        TopBarView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        TopBarView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(UINib(nibName: ProfileTableVCell, bundle: nil), forCellReuseIdentifier: ProfileTableVCell)
        profileTableView.register(UINib(nibName: "ChangeBranchCell", bundle: nil), forCellReuseIdentifier: "ChangeBranchCell")
        profileTableView.register(UINib(nibName: "NotifiSettingCell", bundle: nil), forCellReuseIdentifier: "NotifiSettingCell")
        profileTableView.register(UINib(nibName: "MyorderCell", bundle: nil), forCellReuseIdentifier: "MyorderCell")
        profileTableView.register(UINib(nibName: "PayamentListCell", bundle: nil), forCellReuseIdentifier: "PayamentListCell")
        profileTableView.register(UINib(nibName: "ReturnTableCell", bundle: nil), forCellReuseIdentifier: "ReturnTableCell")
        profileTableView.register(UINib(nibName: "FeedBackTableCell", bundle: nil), forCellReuseIdentifier: "FeedBackTableCell")
        profileTableView.register(UINib(nibName: "LogOutTableCell", bundle: nil), forCellReuseIdentifier: "LogOutTableCell")
        
        
        
        
    }
    //MARK: - Button Action
    
    @IBAction func imageAction(_ sender: Any) {
        
        
        self.showAlert()

        
    }
    
    @IBAction func backbtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func editBtnAct(_ sender: Any) {
        //ProfileInfoVC
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    //MARK: - Custom Delegate
    func prodidselect(type: String) {
        if type == "0"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func didselect(type: String) {
        if type == "0"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrefrdPaymntsVC") as? PrefrdPaymntsVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else  if type == "1"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreditDebitCardsVC") as? CreditDebitCardsVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if type == "2"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoWalletVC") as? LoWalletVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if type == "3"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtherWalletVC") as? OtherWalletVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        print("Pizza ready. The best pizza of all pizzas is... \(type)")
    }
    
}
extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        //        if indexPath.row == 0 || indexPath.row == 4{
        //            return 220
        //
        //        }else
        if indexPath.row == 0
        {
            //return 225
            return 100
        }
        else if indexPath.row == selectedindexone
        {
            return branchCellHeight ?? 53
        }else if indexPath.row == selectedIndextwo
        {
            return 170
        }else if indexPath.row == 3
        {
            //            return 220
            return 53
        }else if indexPath.row == 4
        {
            return 238
        }else if indexPath.row == selectedindexfive
        {
            return 53
        }else if indexPath.row == selectedIndexsis
        {
            return 53
        }else if indexPath.row == 6 //selectedIndexseven
        {
            return 53
        }
        else{
            return 53
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let downimage = UIImage(named: "down")
        let sideimage = UIImage(named: "sideArrow")
        if indexPath.row == 0 {
            
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath)as! ProfileTableViewCell
            listcell.imageViewRight.isHidden = true
            listcell.delegate = self
            return listcell
            
        }
        
        if indexPath.row == 1 {
            
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "ChangeBranchCell", for: indexPath)as! ChangeBranchCell
            listcell.delegate = self
            
            if arrowimgtwo == true{
                
                let tintedImage = downimage?.withRenderingMode(.alwaysTemplate)
                
                listcell.rightImg.image = tintedImage
                listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
                listcell.lineOneHeight.constant = 0.0
                listcell.lineOneLbl.layoutIfNeeded()
            }else{
                let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
                
                listcell.rightImg.image = sideimg
                listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
                listcell.lineOneHeight.constant = 1.0
                listcell.lineOneLbl.layoutIfNeeded()
            }
            return listcell
            
        }
        
        if indexPath.row == 2 {
            
            
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "NotifiSettingCell", for: indexPath)as! NotifiSettingCell
            if arrowimgthree == true{
                let tintedImage = downimage?.withRenderingMode(.alwaysTemplate)
                
                listcell.rightImg.image = tintedImage
                listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
                listcell.lineOneHeight.constant = 0.0
                listcell.lineOneLbl.layoutIfNeeded()
            }else{
                let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
                
                listcell.rightImg.image = sideimg
                listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
                listcell.lineOneHeight.constant = 1.0
                listcell.lineOneLbl.layoutIfNeeded()
            }
            return listcell
            
        }
        if indexPath.row == 3 {
            
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "MyorderCell", for: indexPath)as! MyorderCell
            if arrowimgfour == true{
                // listcell.rightlbl.image = UIImage(named: "down")
            }else{
                let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
                
                listcell.rightlbl.image = sideimg
                listcell.rightlbl.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
            }
            
            return listcell
            
            
        }
        
        if indexPath.row == 4 {
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "PayamentListCell", for: indexPath)as! PayamentListCell
            listcell.rightImage.isHidden = true
            listcell.delegate = self
            return listcell
            
            
        }
        if indexPath.row == 5 {
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "ReturnTableCell", for: indexPath)as! ReturnTableCell
            let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
            
            listcell.rightImg.image = sideimg
            listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
            
            return listcell
            
            
        }
        if indexPath.row == 6 {
            
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "FeedBackTableCell", for: indexPath)as! FeedBackTableCell
            let sideimg = sideimage?.withRenderingMode(.alwaysTemplate)
            
            listcell.rightImg.image = sideimg
            listcell.rightImg.tintColor = UIColor.init(hexString: "5b636a",alpha: 0.80)
            
            return listcell
            
            
        }
        if indexPath.row == 7 {
            
            let listcell = tableView.dequeueReusableCell(withIdentifier: "LogOutTableCell", for: indexPath)as! LogOutTableCell
            listcell.rightimage.isHidden = true
            return listcell
            
            
        }
        
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if indexPath.row == selectedIndexzero{
                selectedIndexzero = -1
                arrowimgone = false
            }else{
                selectedIndexzero = indexPath.row
                arrowimgone = true
            }
            
        }else if indexPath.row == 1 {
            if indexPath.row == selectedindexone{
                selectedindexone = -1
                arrowimgtwo = false
            }else{
                selectedindexone = indexPath.row
                arrowimgtwo = true
            }
            
        }
        else if indexPath.row == 2 {
            if indexPath.row == selectedIndextwo{
                selectedIndextwo = -1
                arrowimgthree = false
            }else{
                selectedIndextwo = indexPath.row
                arrowimgthree = true
            }
            
        }
        else if indexPath.row == 3 {
            if indexPath.row == selectedindexthree{
                selectedindexthree = -1
                arrowimgfour = false
                let orderVc = self.storyboard?.instantiateViewController(withIdentifier: "OrderVC") as! OrderVC
                self.navigationController?.pushViewController(orderVc, animated: true)
            }else{
                selectedindexthree = indexPath.row
                arrowimgfour = true
            }
            
        }
        else if indexPath.row == 4 {
            if indexPath.row == selectedindexfour{
                selectedindexfour = -1
            }else{
                selectedindexfour = indexPath.row
            }
            
        }
        else if indexPath.row == 5 {
            if indexPath.row == selectedindexfive{
                
                selectedindexfive = -1
                arrowimgfive = false
            }else{
                selectedindexfive = indexPath.row
                arrowimgfive = true
            }
            
        }else if indexPath.row == 6 {
           
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeedBackVC") as? FeedBackVC
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
            //                if indexPath.row == selectedIndexsis{
            //
            //                    selectedIndexsis = -1
            //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeedBackVC") as? FeedBackVC
            //                    self.navigationController?.navigationBar.isHidden = true
            //                    self.navigationController?.pushViewController(vc!, animated: true)
            //
            //                   }else{
            //                    selectedIndexsis = indexPath.row
            //                   }
            
        }else {
//            if indexPath.row == selectedIndexseven{
//                selectedIndexseven = -1
//            }else{
//                selectedIndexseven = indexPath.row
//            }
            UserDefaults.resetStandardUserDefaults()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
            
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        tableView.reloadData()
        
        
        
        
    }
    
}
extension ProfileVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
extension ProfileVC : branchCellHeightDelegate{
    func defaultMessage(mage: String) {
        getProfile()
        let banner = NotificationBanner(title: "Message", subtitle: mage, style: .info)
        banner.showToast(message: mage, view: self.view)
    }
    
    func branchHeight(tableCellHeight: CGFloat) {
        print(tableCellHeight)
        branchCellHeight = tableCellHeight + 100
        profileTableView.reloadData()
        
    }
    
    
}

    
    

extension ProfileVC:WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String) {
        print(errorMessage)
    }
    
   
    func getProfile(){
       
            showActivityIndicator(self.view)

        
        let getProfile:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "getProfile")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let proHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]

        getProfile.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+FIRM_PROFILE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.firmProfileModel = FirmProfileModel(object:dict)
            if boolSuccess {
               
                if self.firmProfileModel?.appStatusCode == 0{
                    
                    userNameLbl.text = firmProfileModel?.payloadJson?.data?.cFirmContactPerson
                    self.medicalsName.text = firmProfileModel?.payloadJson?.data?.cName
                    self.locationLbl.text = firmProfileModel?.payloadJson?.data?.cStateName
                    locationLbl.text = "\(firmProfileModel?.payloadJson?.data?.cStateName ?? ""),"+" \(firmProfileModel?.payloadJson?.data?.cCityName ?? "")"
                
                   // profileimgeView.isHidden = true

//                    let stringInput = firmProfileModel?.payloadJson?.data?.cName
//                                     let stringInputArr = stringInput!.components(separatedBy:" ")
//                                     var stringNeed = ""
//
//                                     for string in stringInputArr {
//                                         stringNeed += String(string.first!)
//                                     }
//
//                                     print(stringNeed)
//                 //                    let proLblName = firmProfileModel?.payloadJson?.data?.cName
//                 //                    let name = proLblName?.first(char: 2)
//                                     alterproNameLbl.text = stringNeed.uppercased()
                    let userName = firmProfileModel?.payloadJson?.data?.cName?.getAcronyms().uppercased()
                    
                  
                    alterproNameLbl.text = userName?.maxLength(length: 2)
                    
                }else{
                    
                }
                
                hideActivityIndicator(self.view)
                
            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           
            hideActivityIndicator(self.view)
            self.MobileExistsView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            isLoginInt = 1

            self.MobileExistsView?.Mobdelegate = self
            self.MobileExistsView?.addsellerBtn.setTitle("Login", for: .normal)
            self.MobileExistsView?.loopImage.image = UIImage(named: "exclamation")
            let colorString = "Mobile Number "
            self.MobileExistsView?.txtLbl.text = "Entered " + colorString + " is Already used. Click below to Login"
            self.MobileExistsView?.txtLbl.setSubTextColor(pSubString: colorString, pColor: UIColor.init(hexString: "ff7b20"))
            self.view.addSubview(self.MobileExistsView!)
        })
        
        
        }
    func uploadImg(imageName:UIImage,imageURL:String){
        
        let uploadProfile:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "uploadProfile")


        let uploadHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                         "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                         "Content-type": "multipart/form-data"
                                        ]

        uploadProfile.uploadImage(imageNmae: imageName, imgUrlStr: LIVE_ORDER_HOSTURL+IMG_UPLOAD_URL , apiHeader: uploadHeader) { success, message, responseObject in
            print(success)
        } failureBlock: { errorMesssage in
            print(errorMesssage)
        }

    }

}

        
    
    

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //This is the tap gesture added on my UIImageView.
    @IBAction func didTapOnImageView(sender: UITapGestureRecognizer) {
        //call Alert function
        self.showAlert()
    }

    //Show alert to selected the media source type.
    private func showAlert() {

        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        self.dismiss(animated: true) { [weak self] in

            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            self?.profileimgeView.image = image
            self?.uploadImg(imageName:image,imageURL: LIVE_ORDER_HOSTURL+IMG_UPLOAD_URL)
            self?.alterproNameLbl.isHidden = true
        }
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    

}

