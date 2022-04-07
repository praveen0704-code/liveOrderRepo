//
//  FeedBackVC.swift
//  liveOrder
//
//  Created by Data Prime on 09/09/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift


class FeedBackVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var feedBackLbl: UILabel!
    @IBOutlet weak var valueDesLbl: UILabel!
    @IBOutlet weak var feedBackTpeTxtField: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var sistibutorTxtfield: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var ownerTxtField: DesignableUITextFieldWithoutColor!
    @IBOutlet weak var yourQueryLbl: UILabel!
    @IBOutlet weak var maxiCharLbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var supportLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var uploadFileNameLbl: UILabel!
    var uploadfile : UIImageView?
    var imagePicker = UIImagePickerController()
    var distributerListModel : DistriuterBaseClass?
    var branchListModel:BranchListBaseClass?
    
    var distributerCode:String?
    var branchCodeStr:String?
    
    //MARK: - error msg
    var resDict = NSDictionary()
    var msgArray = NSArray()
    

    
    @IBOutlet weak var senduttonnHeightConstraint: NSLayoutConstraint!
    
    let FeedBackTypeView = UINib(nibName: "FeedBackTypeView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? FeedBackTypeView
    let DistibutorNameView = UINib(nibName: "DistibutorNameView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? DistibutorNameView
    let StoreNameView = UINib(nibName: "StoreNameView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? StoreNameView
    let MobileExistsView = UINib(nibName: "MobileExistsView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? MobileExistsView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        txtView.text = "Write here.."
        txtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
        let feedBackTypeImge = UIImageView(frame: CGRect(x: 0, y: 13, width: 13  , height: 8))
        feedBackTypeImge.image = UIImage(named: "down_arrow")
        feedBackTypeImge.image = feedBackTypeImge.image?.withRenderingMode(.alwaysTemplate)
        feedBackTypeImge.tintColor = UIColor.black
        let typeview = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        typeview.addSubview(feedBackTypeImge)
        typeview.addTarget(self, action: #selector(typeAct), for: .touchUpInside)

        feedBackTpeTxtField.rightViewMode = .always
        feedBackTpeTxtField.rightView = typeview
        
        let sistibutorImge = UIImageView(frame: CGRect(x: 0, y: 13, width: 13  , height: 8))
        sistibutorImge.image = UIImage(named: "down_arrow")
        sistibutorImge.image = sistibutorImge.image?.withRenderingMode(.alwaysTemplate)
        sistibutorImge.tintColor = UIColor.black
        let sistibutorview = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        sistibutorview.addSubview(sistibutorImge)
        
        sistibutorview.addTarget(self, action: #selector(distibutorAct), for: .touchUpInside)
        sistibutorTxtfield.rightViewMode = .always
        sistibutorTxtfield.rightView = sistibutorview
        
        let ownerImge = UIImageView(frame: CGRect(x: 0, y: 13, width: 13  , height: 8))
        ownerImge.image = UIImage(named: "down_arrow")
        ownerImge.image = sistibutorImge.image?.withRenderingMode(.alwaysTemplate)
        ownerImge.tintColor = UIColor.black
        let ownerview = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        ownerview.addSubview(ownerImge)
        ownerview.addTarget(self, action: #selector(ownerAct), for: .touchUpInside)
        ownerTxtField.rightViewMode = .always
        ownerTxtField.rightView = ownerview
        
        
        feedBackTpeTxtField.delegate = self
        sistibutorTxtfield.delegate = self
        ownerTxtField.delegate = self
        txtView.delegate = self
        uploadFileNameLbl.isHidden = true
        self.senduttonnHeightConstraint.constant = 32
        txtView.layer.borderWidth = 1
        txtView.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.8039215686, blue: 0.8941176471, alpha: 1)
        txtView.layer.cornerRadius = 6
        
        let colorString = "1000"
        self.maxiCharLbl.text = "Max " + colorString + " character"
        maxiCharLbl.setSubTextColor(pSubString: colorString, pColor: .init(red: 0, green: 211, blue: 180, alpha: 1))
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#6C19D8")])
    }
    
    @objc func typeAct(){
        feedBackTpeTxtField.resignFirstResponder()
        FeedBackTypeView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        FeedBackTypeView?.delegate = self
        
        self.view.addSubview(FeedBackTypeView!)
        
    }
    @objc func distibutorAct(){
        sistibutorTxtfield.resignFirstResponder()
        DistibutorNameView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        DistibutorNameView?.delegate = self
        
        self.view.addSubview(DistibutorNameView!)
        
    }
    @objc func ownerAct(){
        ownerTxtField.resignFirstResponder()
        StoreNameView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        StoreNameView?.delegate = self
        self.view.addSubview(StoreNameView!)
        
        
    }
    
    @IBAction func sendBtnAct(_ sender: Any) {
        if feedBackTpeTxtField.text == "" || sistibutorTxtfield.text == "" || ownerTxtField.text == "" || txtView.text == "" {
            
            self.sendBtn.isUserInteractionEnabled = false
            
        }else{
            sendFeedack()
            self.sendBtn.isUserInteractionEnabled = true

        }
        
    }
    @IBAction func uploadBtnAct(_ sender: Any) {
       
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")

                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false

                    present(imagePicker, animated: true, completion: nil)
                }
            }

//            func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//                self.dismiss(animated: true, completion: { () -> Void in
//                    self.uploadfile?.image = image
//                    self.uploadFileNameLbl.isHidden = false
//                   // self.uploadFileNameLbl.text = (uploadfile as! String)
//                    self.feedackUpload(fbImgName:image)
//                })

                
           // }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                        self.dismiss(animated: true, completion: { () -> Void in
                            
                            guard let imagee = info[.originalImage] as? UIImage else {
                                       fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                                   }
                           // self.uploadfile?.image = imagee
                            self.uploadFileNameLbl.isHidden = false
                            self.feedackUpload(fbImgName:imagee)

                            
                        })
        
        
        
    }
    
    
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
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
extension FeedBackVC : UITextFieldDelegate,feedType,distributorName,storeName{
    func strName(date: String,storeNameStr:String) {
        print(date)
        ownerTxtField.text = date
        branchCodeStr = storeNameStr
    }
    
    func name(date: String,distributerListIdStr:String) {
        print(date)
        sistibutorTxtfield.text = date
        distributerCode = distributerListIdStr
    }
    
    func share(date: String) {
        print(date)
        feedBackTpeTxtField.text = date
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.feedBackTpeTxtField{
            feedBackTpeTxtField.resignFirstResponder()

            FeedBackTypeView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

            FeedBackTypeView?.delegate = self
            
            self.view.addSubview(FeedBackTypeView!)
            
            
        }else if textField == self.sistibutorTxtfield{
            sistibutorTxtfield.resignFirstResponder()
            distriuterList(moileNo: UserDefaults.standard.value(forKey: usernameConstantStr) as! String)
            
            
        }else if textField == self.ownerTxtField{
            ownerTxtField.resignFirstResponder()
            branchApiCall(completion:getProfile_completion)
            
        }
            
        }
        
        
        
        
        
        
        
    }
extension FeedBackVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
       if txtView.textColor == UIColor(hexString: "5b636a", alpha: 0.50) {
           txtView.text = nil
           txtView.textColor = UIColor(hexString: "5b636a")
       }
   }
   func textViewDidEndEditing(_ textView: UITextView) {
       if txtView.text.isEmpty {
           txtView.text = "Write here.."
           txtView.textColor = UIColor(hexString: "5b636a", alpha: 0.50)
       }
   }
    func textViewDidChange(_ textView: UITextView) {
        let reduceStrInt = 1000 - textView.text.count
        self.maxiCharLbl.text = "Max " + "\(reduceStrInt)" + " character"
        maxiCharLbl.setSubTextColor(pSubString: "\(reduceStrInt)" , pColor: .init(red: 0, green: 211, blue: 180, alpha: 1))
        if reduceStrInt == 0{
            
            textView.isEditable = false
            
        }
    }
}

extension FeedBackVC:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    func feedackUpload(fbImgName:UIImage){
            let uploadImg:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "uploadImg")
        let feedBackHeaders :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-type": "multipart/form-data",
        ]

        uploadImg.uploadImage(imageNmae: fbImgName, imgUrlStr:LIVE_ORDER_HOSTURL+UPLOAD_IMG_URL, apiHeader: feedBackHeaders) { success, message, responseObject in
            print(responseObject)
        } failureBlock: { errorMesssage in
            print(errorMesssage)
        }

        
        }
    
    func distriuterList(moileNo:String){
        showActivityIndicator(self.view)
        let distributerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "distributerList")
        
        let feedBackHeaders :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
        ]
        let distributerParams = ["c_mobile_no": moileNo,
                                 "n_limit": 30 ] as [String : Any]
        distributerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+DISTRIBUTER_LIST_URL, type: .post, userData:distributerParams, apiHeader: feedBackHeaders,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.distributerListModel = DistriuterBaseClass(object:dict)
            if boolSuccess {
               
                DistibutorNameView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                DistibutorNameView?.distributerListModelF = distributerListModel
               DistibutorNameView?.reloadTaleView()

                DistibutorNameView?.delegate = self
                
                self.view.addSubview(DistibutorNameView!)
                hideActivityIndicator(self.view)


            }else{
                let banner = NotificationBanner(title: "Message", subtitle: "No Data Found", style: .info)
                banner.showToast(message:  "No Data Found", view: self.view)
                hideActivityIndicator(self.view)
                


            }
           
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
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
            hideActivityIndicator(self.view)



        })
        
        
    }
    func branchApiCall(completion: @escaping LOHOMELOADAPI){
            showActivityIndicator(self.view)
            let branchList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "BranchList")
            
            //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
            //                                        "X-csquare-api-token":"99355562095561bc",
            //                                        "Content-Type":"application/json",
            //                                            ]
            
            let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
            ]
            print(sHeader)
            let branchListParm = ["n_page":0,
                                  "n_limit":10]
            
            branchList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_BRANCH_LIST_URL, type: .post, userData: branchListParm, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(LIVE_ORDER_HOSTURL+GET_BRANCH_LIST_URL)
                print(dict)
                self.branchListModel = BranchListBaseClass(object:dict)
                if boolSuccess {
                    
                    if self.branchListModel?.appStatusCode == 0{

                        StoreNameView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                        StoreNameView?.delegate = self
                        StoreNameView?.branchListModelF = branchListModel
                        StoreNameView?.reloadStokTableView()
                        self.view.addSubview(StoreNameView!)
                        hideActivityIndicator(self.view)
                        completion()


                        
                    }else{
                        
                        hideActivityIndicator(self.view)
                        let banner = NotificationBanner(title: "Message", subtitle: "No Data Found", style: .info)
                        banner.showToast(message:  "No Data Found", view: self.view)
                        completion()
                    }
                    
                }else{
                    hideActivityIndicator(self.view)
                    let banner = NotificationBanner(title: "Message", subtitle: "No Data Found", style: .info)
                    banner.showToast(message:  "No Data Found", view: self.view)
                    completion()
                }

                
            }, failureBlock: {[unowned self] (errorMesssage) in
                let banner = NotificationBanner(title: "Message", subtitle: "No Data Found", style: .info)
                banner.showToast(message:  "No Data Found", view: self.view)
                hideActivityIndicator(self.view)

                completion()

            })
    }
    
    func sendFeedack(){
            showActivityIndicator(self.view)
            let sendFeedackList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sendFeedackList")
            
            //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
            //                                        "X-csquare-api-token":"99355562095561bc",
            //                                        "Content-Type":"application/json",
            //                                            ]
            
            let sendFeedackListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
            ]
            
            let sendFeedackListParm = ["ax_upload_file":"",
                                       "c_branch_code":"\(branchCodeStr ?? "")",
                                       "c_feedback_type":0,
                                       "c_message": self.txtView.text ?? "",
                                       "c_seller_code":"\(distributerCode ?? "")"
            ] as [String : Any]
        
        print(sendFeedackListParm)
            
        sendFeedackList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SAVE_FEEDBACK_URL, type: .post, userData: sendFeedackListParm, apiHeader: sendFeedackListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
                print(LIVE_ORDER_HOSTURL+GET_BRANCH_LIST_URL)
                print(dict)
             resDict = dict as! NSDictionary
            
                if boolSuccess {
                    
                   
                    if self.branchListModel?.appStatusCode == 0{
                        hideActivityIndicator(self.view)
                      
                        msgArray = resDict.value(forKey: "messages") as! NSArray
                        print(msgArray[0])
                        let banner = NotificationBanner(title: "Message", subtitle: msgArray[0] as? String, style: .info)
                        banner.showToast(message:   msgArray[0] as? String ?? "", view: self.view)
                        
                    }else{

                       
                    }
                    
                }else{
                    
                    hideActivityIndicator(self.view)
                    msgArray = resDict.value(forKey: "messages") as! NSArray
                    print(msgArray[0])
                    let banner = NotificationBanner(title: "Message", subtitle: msgArray[0] as? String, style: .info)
                    banner.showToast(message:   msgArray[0] as? String ?? "", view: self.view)
                }

                
            }, failureBlock: {[unowned self] (errorMesssage) in
                msgArray = resDict.value(forKey: "messages") as! NSArray
                print(msgArray[0])
                let banner = NotificationBanner(title: "Message", subtitle: msgArray[0] as? String, style: .info)
                banner.showToast(message: msgArray[0] as? String ?? "", view: self.view)
                hideActivityIndicator(self.view)


            })
    }
}
extension FeedBackVC : mobilexist{
    func mobileExisits(type: Int) {
        if type == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
          
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
        }
    }
    
    
}
       

