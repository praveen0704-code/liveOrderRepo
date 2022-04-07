//
//  LoHomeExension.swift
//  liveOrder
//
//  Created by PraveenMac on 12/11/21.
//

import Foundation
import UIKit
import FSPagerView
import Alamofire
import NotificationBannerSwift

typealias SWCOMPLETION = () -> ()
let getProfile_completion = {
    print("functionTwo COMPLETED")
}

let shotBook_completion = {
    print("functionOne COMPLETED")
}

let wishList_completion = {
    print("functionTwo COMPLETED")
}


typealias LOHOMELOADAPI = () -> ()

let topMost_completion = {
    print("functionOne COMPLETED")
}

let banner_completion = {
    print("functionTwo COMPLETED")
}
let sellerInnspiredy_completion = {
    print("functionOne COMPLETED")
}

let NewLanchItem_completion = {
    print("functionTwo COMPLETED")
}
let shopMfg_completion = {
    print("functionOne COMPLETED")
}

let limitedOffer_completion = {
    print("functionTwo COMPLETED")
}
let sbItemCode_completion = {
    print("functionOne COMPLETED")
}

let wlItemCode_completion = {
    print("functionTwo COMPLETED")
}
let notificationCount_completion = {
    print("functionOne COMPLETED")
}


let branchApiCal_completion = {
    print("functionOne COMPLETED")
}

let getUse_completion = {
    print("functionTwo COMPLETED")
}
let cartCount_completion = {
    print("functionTwo COMPLETED")
}
let shotbookList_completion = {
    print("shotbook list completion")
}






extension LoHomeVC:FSPagerViewDataSource,FSPagerViewDelegate{
    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerListModel?.payloadJson?.data?.jList?.count ?? 5
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        bannerlazyImage.showWithSpinner(imageView:cell.imageView!, url: bannerListModel?.payloadJson?.data?.jList?[index].cBannerImageUrl, defaultImage:"")
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
//        cell.layer.borderWidth = 0.5
        cell.backgroundColor = .white
//        cell.layer.borderColor = UIColor(hexString: "c3cde4", alpha: 80).cgColor
        //cell.imageView?.downloaded(from:self.bannerListModel?.payloadJson?.data?.jList?[index].cBannerImageUrl ?? "")
        cell.imageView?.contentMode = .scaleAspectFill
        // cell.imageView?.frame = CGRect(x: 0, y: 0, width: self.bannererView.frame.width, height: 210)
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        print(bannerListModel?.payloadJson?.data?.jList?[index].cBannerImageUrl)
        
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    
    
}
extension LoHomeVC:WebServiceDelegate{
    
    func webServiceGotExpiryMessage(errorMessage: String) {
        
        
    }
    
    func bannerApiCall(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
        showActivityIndicator(self.view)
        
        
        let bannerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "BannerList")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        print(sHeader)
        bannerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+BANNER_URL, type: .get, userData: nil, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.bannerListModel = BannerModel(object:dict)
            if boolSuccess {
                if self.bannerListModel?.appStatusCode == 0{
                    self.bannererView.reloadData()
                  completion()
                }else{
                    hideActivityIndicator(self.view)
                    apiQueue.leave()
                    completion()
                }
            }else{

                hideActivityIndicator(self.view)
                apiQueue.leave()
                completion()
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            apiQueue.leave()
            completion()
            
        })
        
        
    }
    func sellerInnspiredyApi(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
        showActivityIndicator(self.view)
        
        
        let selleerInspiredBy:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sellerInspired")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let sellerInnspiredyParms = ["n_page":0,
                                     "n_limit":15]
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        
        print(sHeader)
        
        selleerInspiredBy.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SELLER_INNSPIRED_BY_URL, type: .post, userData: sellerInnspiredyParms, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            
            self.sellerInnspiredyModel = SInspiredBaseClass(object:dict)
            if boolSuccess {
                
                if self.sellerInnspiredyModel?.appStatusCode == 0{
                   
                    if self.sellerInnspiredyModel?.payloadJson?.data?.jList != nil{
                        
                        if self.sellerInnspiredyModel?.payloadJson?.data?.jList?.count == 0{
                            self.sellerInspiredHeightConstraint.constant = 0.0
                            self.sellerInspireVerticalHeightConstraint.constant = 0.5
                            completion()
                        }else{
                            self.sellerInspiredHeightConstraint.constant = 168.0
                            self.sellerInspireVerticalHeightConstraint.constant = 16
                            completion()
                        }
                    }else{
                        self.sellerInspiredHeightConstraint.constant = 0.0
                        self.sellerInspireVerticalHeightConstraint.constant = 0.5
                        completion()

                        
                    }
                                
                    self.sellerInspiredCollView.reloadData()
                    
                    //
                }else{
                    self.sellerInspiredHeightConstraint.constant = 0.0
                    self.sellerInspireVerticalHeightConstraint.constant = 0.5
                    completion()

                    
                }
                hideActivityIndicator(self.view)
                apiQueue.leave()
            }else{
                self.sellerInspiredHeightConstraint.constant = 0.0
                self.sellerInspireVerticalHeightConstraint.constant = 0.5
                hideActivityIndicator(self.view)
                completion()

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print("ScNo value")
            self.sellerInspiredHeightConstraint.constant = 0.0
            self.sellerInspireVerticalHeightConstraint.constant = 0.5
            hideActivityIndicator(self.view)
            apiQueue.leave()
            completion()

        })
        
        
    }
    
    func topmostApi(completion: @escaping LOHOMELOADAPI){

        apiQueue.enter()
        showActivityIndicator(self.view)


        self.shotBookIntArray.removeAll()
        self.wishListIntArray.removeAll()
       
        let topmost:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "TopMostApi")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
      //  let topmostParams = ["n_limit": 10,"n_page":0] as [String : Any]
        let topmostParams = ["c_availability": availability,"c_brands":brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_pincode": pincode ?? "",
                             "n_limit": 20,
                             "n_page": nextPageInt] as [String : Any]
        print(topmostParams)
       // print(topmostParams)

            let nHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        topmost.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+TOPMOST_ORDER_URL, type: .post, userData: topmostParams, apiHeader: nHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.tPCollectionView.bottomRefreshControl?.endRefreshing()
            self.topMostModel = TopMostOrderModel(object:dict)

            if boolSuccess {

                if self.topMostModel?.payloadJson?.data?.jList != nil{

                    if self.topMostModel?.payloadJson?.data?.jList?.count == 0{
                        self.topViewHeightConstraint.constant = 50.0
                        self.tpViewAllButton.isHidden = true
                        hideActivityIndicator(self.view)
                        completion()


                    }else{
                       
                        let queue = DispatchQueue(label: "com.myApp.myQueu")

                            queue.sync {

                                shotBookAddRemove(completion: shotBook_completion )

                                wishListAddRemove(completion: wishList_completion)

                            }
                            
                        
                        
                        print(wishListIntArray)
                        print(shotBookIntArray)
                        self.topViewHeightConstraint.constant = 334.0
                        self.tpViewAllButton.isHidden = false
                        if loadfirstInt == 1{
                             tPCollectionView.reloadData()

                        }
                        hideActivityIndicator(self.view)
                        apiQueue.leave()
                        completion()

                        
                    }

                    
                }else{
                    self.topViewHeightConstraint.constant = 50.0
                    self.tpViewAllButton.isHidden = true
                    hideActivityIndicator(self.view)
                    completion()

                }
                

            }else{
                hideActivityIndicator(self.view)
                completion()


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
            completion()
            apiQueue.leave()

        })
        
        
        }
   //
//MARK: - Completion Shotbook Wish List
    func shotBookAddRemove(completion: @escaping SWCOMPLETION){
        for (inx,ele) in (self.topMostModel?.payloadJson?.data?.jList)!.enumerated(){
            self.shotBookIntArray.append(0)
            if self.sbItemCodeModel?.payloadJson?.data != nil{
                for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
                    if ele.cItemCode == sele.cItemCode{
                        shotBookIntArray[inx] = 1
                    }else{
                      //  shotBookIntArray[inx] = 0
                    }
                }

            }
        }
        completion()
    }
    func wishListAddRemove(completion: @escaping SWCOMPLETION){
        for (inx,ele) in (self.topMostModel?.payloadJson?.data?.jList)!.enumerated(){
            self.wishListIntArray.append(0)
            if self.wlItemCodeModel?.payloadJson?.data != nil{
                for (_,wEle) in (self.wlItemCodeModel?.payloadJson?.data)!.enumerated(){
                    if ele.cItemCode == wEle.cItemCode{
                        wishListIntArray[inx] = 1
                    }else{
                      //  shotBookIntArray[inx] = 0
                    }
                }

            }
        }
completion()
    }
    //MARK: - Completion Shotbook Wish List
        func nshotBookAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (self.newLanchModel?.payloadJson?.data?.jList)!.enumerated(){
                self.nShotBookIntArray.append(0)
                if self.sbItemCodeModel?.payloadJson?.data != nil{
                    for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
                        if ele.cItemCode == sele.cItemCode{
                            nShotBookIntArray[inx] = 1
                        }else{
                          //  shotBookIntArray[inx] = 0
                        }
                    }

                }
            }
            completion()
        }
        func nwishListAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (self.newLanchModel?.payloadJson?.data?.jList)!.enumerated(){
                self.nWishListIntArray.append(0)
                if self.wlItemCodeModel?.payloadJson?.data != nil{
                    for (_,wEle) in (self.wlItemCodeModel?.payloadJson?.data)!.enumerated(){
                        if ele.cItemCode == wEle.cItemCode{
                            nWishListIntArray[inx] = 1
                        }else{
                          //  shotBookIntArray[inx] = 0
                        }
                    }

                }
            }
            completion()

        }
    func NewLanchItemApi(pin:String,completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
       showActivityIndicator(self.view)
        self.nShotBookIntArray.removeAll()
        self.nWishListIntArray.removeAll()
        
        let newLanchItems:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "NewlanchList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
//                                    "X-csquare-api-token":"-448945721a86225",
//                                    "Content-Type":"application/json",
//                                        ]
    
        let NewLaunchParams = ["c_availability": availability,"c_brands": brands,"c_manufacturers": manufacturers,"c_sellers": sellers,"c_sort": sort,"c_pincode": pin,
                               "n_limit": 20,
                               "n_page": nextPageInt] as [String : Any]
            let nHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]

        newLanchItems.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ITEM_BY_NEW_LAUNCH_FILTTER_URL, type: .post, userData: NewLaunchParams, apiHeader: nHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.newLanchModel = NewLaunchModel(object:dict)
            if boolSuccess {
                if self.newLanchModel?.appStatusCode == 0{
                    
                    if self.newLanchModel?.payloadJson?.data?.jList != nil{
                        if self.newLanchModel?.payloadJson?.data?.jList?.count == 0{
                            self.newLaunchHeightConnstraint.constant = 50.0
                            self.newLaunchViewAllButton.isHidden = true
                            newLaunchCollectionView.bottomRefreshControl?.endRefreshing()

                            completion()
                        }else{
                            self.newLaunchHeightConnstraint.constant = 334.0
                            self.newLaunchViewAllButton.isHidden = false
                            let queue = DispatchQueue(label: "com.myApp.myQueu")

                                queue.sync {

                                    nshotBookAddRemove(completion: shotBook_completion)
                                    nwishListAddRemove(completion: wishList_completion)

                                }
                                print(nShotBookIntArray)
                            print(nWishListIntArray)

                            if loadfirstInt == 1{
                                newLaunchCollectionView.reloadData()

                            }
                            newLaunchCollectionView.bottomRefreshControl?.endRefreshing()

                            apiQueue.leave()
                            completion()

                        }
                        
                        
                        
                    }else{
                        hideActivityIndicator(self.view)

                        self.newLaunchHeightConnstraint.constant = 50.0
                        self.newLaunchViewAllButton.isHidden = true
                        newLaunchCollectionView.bottomRefreshControl?.endRefreshing()

                        completion()
                    }
               
                }else{
                    hideActivityIndicator(self.view)

                    self.newLaunchHeightConnstraint.constant = 50.0
                    self.newLaunchViewAllButton.isHidden = true
                    newLaunchCollectionView.bottomRefreshControl?.endRefreshing()

                    apiQueue.leave()
                    completion()


                }
                
                
                

            }else{
                hideActivityIndicator(self.view)

                self.newLaunchHeightConnstraint.constant = 50.0
                self.newLaunchViewAllButton.isHidden = true
                newLaunchCollectionView.bottomRefreshControl?.endRefreshing()

                apiQueue.leave()
                completion()



            }
            

            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            newLaunchCollectionView.bottomRefreshControl?.endRefreshing()
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
            apiQueue.leave()
            completion()


        })
        
}
    func shopMfgApi(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
        showActivityIndicator(self.view)
        
        let shopMfg:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "shopMfg")
        let shopByMfgParams = ["n_page":0,
                               "n_limit":15]
        //        let sHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
        //                                    "X-csquare-api-token":"-448945721a86225",
        //                                    "Content-Type":"application/json",
        //                                        ]
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
        print(sHeader)
        shopMfg.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHOP_MFG_URL, type: .post, userData: shopByMfgParams, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.shopMfgModel = ShopBymfgModel(object:dict)
            print("shopMfgApi")
            print(LIVE_ORDER_HOSTURL+SHOP_MFG_URL)
            print(dict)
            if boolSuccess {
                
                if self.shopMfgModel?.appStatusCode == 0{
                    
                    
                    if self.shopMfgModel?.payloadJson?.data?.jList != nil{
                        
                        if self.shopMfgModel?.payloadJson?.data?.jList?.count == 0{
                            self.shopByMafHeightConstraint.constant = 50.0
                           // self.smViewAllButton.isHidden = true
                        }else{
                            self.shopByMafHeightConstraint.constant = 155.5
                           // self.smViewAllButton.isHidden = false
                        }
                        smManifactureButton.reloadData()
                        hideActivityIndicator(self.view)
                        completion()

                        
                    }else{
                        self.shopByMafHeightConstraint.constant = 50.0
                        //self.smViewAllButton.isHidden = true
                        hideActivityIndicator(self.view)
                        completion()

                        
                    }
                    
                }else{
                    self.shopByMafHeightConstraint.constant = 50.0
                    hideActivityIndicator(self.view)
                    completion()

                }
                
                
            }else{
                self.shopByMafHeightConstraint.constant = 50.0
                hideActivityIndicator(self.view)
                completion()

            }
        
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            self.shopByMafHeightConstraint.constant = 50.0
            hideActivityIndicator(self.view)
            apiQueue.leave()
            completion()

        })
}
func limitedOfferApi(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
        showActivityIndicator(self.view)
        let limitedoff:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "LimitedOffer")
        let limitedoffParams = ["n_page":0,
                                "n_limit":15]
        //    let sHeader :HTTPHeaders = ["X-csquare-api-key":"Os/fWz15Z0XH7WvKPAZXug==",
        //                                "X-csquare-api-token":"-448945721a86225",
        //                                "Content-Type":"application/json",
        //                                    ]
        
        let sHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
        ]
             print(sHeader)
        //    print(LIVE_ORDER_HOSTURL+LIMITED_OFFERS_URL)
        
        limitedoff.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+LIMITED_OFFERS_URL, type: .post, userData: limitedoffParams, apiHeader: sHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.limitedoffModel = LimitedOffersModel(object:dict)
            print(dict)
            if boolSuccess {
                
                if self.limitedoffModel?.appStatusCode == 0{
                    print(self.limitedoffModel?.payloadJson?.data?.jList?.count)
                    
                    if self.limitedoffModel?.payloadJson?.data?.jList != nil {
                        
                        if self.limitedoffModel?.payloadJson?.data?.jList?.count == 0{
                            self.limitedPeriodHeightConstraint.constant = 00.0
                         //   self.limitedViewBtn.isHidden = true
                        }else{
                            self.limitedPeriodHeightConstraint.constant = 242.0
                          //  self.limitedViewBtn.isHidden = false
                        }
                        hideActivityIndicator(self.view)
                        completion()

                        
                    }else {
                        self.limitedPeriodHeightConstraint.constant = 50.0
                      //  self.limitedViewBtn.isHidden = true
                        hideActivityIndicator(self.view)
                        completion()

                    }
                    
                    limitedPeriodCollView.reloadData()
                }else{
                    self.limitedPeriodHeightConstraint.constant = 50.0
                    self.limitedViewBtn.isHidden = true
                    hideActivityIndicator(self.view)
                    completion()

                }
                
                
            }else{
                self.limitedPeriodHeightConstraint.constant = 50.0
                self.limitedViewBtn.isHidden = true
                hideActivityIndicator(self.view)
                completion()
                
            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)
            completion()

        })
}

func branchApiCall(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
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

                    for(inx,Ele) in (self.branchListModel?.payloadJson?.bItems)!.enumerated(){
                        
                        if Ele.cDefaultStatus == "Y"{
                            UserDefaults.standard.setValue(Ele.cBrCode, forKey:defaultBranchCodeConStr)
                            cartCount(completion: cartCount_completion)
                        }else{


                        }
                        
                    }
                    
                    
                   // self.bannerIDsStr = "\(self.branchListModel?.payloadJson?.list?[0].nBranchId ?? 0)"
                    print(self.bannerIDsStr)
                    UserDefaults.standard.set(self.bannerIDsStr, forKey: branchConstantStr)

                    
                }else{
                    hideActivityIndicator(self.view)
                    cartCount(completion: cartCount_completion)

                    completion()
                }
                
            }else{
                hideActivityIndicator(self.view)
                cartCount(completion: cartCount_completion)

                completion()
            }

            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)
            cartCount(completion: cartCount_completion)

            completion()

        })
}
func shortBookCount(){
        apiQueue.enter()
        let shortBook:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "BannerList")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let sbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                     "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                     "Content-Type":"application/json",
        ]
        print(sbHeader)
        shortBook.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHORT_BOOK_COUNT_URL, type: .get, userData: nil, apiHeader: sbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.shortBookCountModel = SBCountModel(object:dict)
            if boolSuccess {
                
                if self.shortBookCountModel?.appStatusCode == 0{
                    if shortBookCountModel?.payloadJson?.data?.count != 0{
                        self.shortBookBtn.badgeButtonProperty()
                        self.shortBookBtn.badgeLabel.isHidden = true
                        self.shortBookBtn.badge = "\(shortBookCountModel?.payloadJson?.data?.count ?? 0)"
                    }else{
                        self.shortBookBtn.badgeLabel.isHidden = true
                    }
                }else{
                    
                }
                
                
                
            }else{
                
                
            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
        })
    }
    func watchlistCount(){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let wishlist:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "wishlist")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        print(wlbHeader)
        wishlist.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+WATCH_LIST_COUNT_URL, type: .get, userData: nil, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.watchlistCountModel = WLCountModel(object:dict)
            if boolSuccess {
                
                if self.watchlistCountModel?.appStatusCode == 0{
                    
                    
                    if watchlistCountModel?.payloadJson?.data?.count != 0{
                        
                        self.wishListBtn.badgeButtonProperty()
                        self.wishListBtn.badgeLabel.isHidden = true
                        
                        self.wishListBtn.badge = "\(watchlistCountModel?.payloadJson?.data?.count ?? 0)"
                        
                        
                    }else{
                        self.wishListBtn.badgeLabel.isHidden = true
                        //hideActivityIndicator(self.view)

                    }
                    
                    
                    
                }else{
                    //hideActivityIndicator(self.view)

                }
                
                //hideActivityIndicator(self.view)
                
            }else{
                
                //hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            //hideActivityIndicator(self.view)

        })
    }
    func notificationCount(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
        let wishlist:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "wishlist")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        print(wlbHeader)
        wishlist.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+NOTIFICATION_COUNT_URL, type: .get, userData: nil, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.watchlistCountModel = WLCountModel(object:dict)
            if boolSuccess {
                
                if self.watchlistCountModel?.appStatusCode == 0{
                    
                    
                    if watchlistCountModel?.payloadJson?.data?.count != 0{
                        
                        self.notificationButton.badge = "\(watchlistCountModel?.payloadJson?.data?.count ?? 0)"
                        completion()

                    }else{
                        self.notificationButton.badgeLabel.isHidden = true
                        completion()

                    }
                    
                    
                    
                }else{
                    completion()

                }
                
                
                
            }else{
                completion()

                
            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            completion()

        })
    }
    func cartCount(completion: @escaping LOHOMELOADAPI){
        showActivityIndicator(self.view)
        apiQueue.enter()
        let cartCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "cartCount")
        
        //            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                        "X-csquare-api-token":"99355562095561bc",
        //                                        "Content-Type":"application/json",
        //                                            ]
        
        let cartCountHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        print(cartCountHeader)
        let cartParams = ["n_branch_id": UserDefaults.standard.value(forKey:defaultBranchCodeConStr) as! String]
        print(cartParams)
        cartCount.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+CART_COUNT_MODEL_URL, type: .post, userData: cartParams, apiHeader: cartCountHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.cartCountModel = CartCountModel(object:dict)
            if boolSuccess {
                showActivityIndicator(self.view)

                if self.cartCountModel?.appStatusCode == 0{
                    
                    if cartCountModel?.payloadJson?.data?.count != 0{
                        self.cartBtn.badge = "\(cartCountModel?.payloadJson?.data?.count ?? 0)"
                        hideActivityIndicator(self.view)
                        
                        completion()
                    }else{
                        self.cartBtn.badgeLabel.isHidden = true
                        hideActivityIndicator(self.view)
                        completion()
                    }
                }else{
                    hideActivityIndicator(self.view)

                    completion()
                }
            }else{
                hideActivityIndicator(self.view)

                completion()
            }
            apiQueue.leave()
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            completion()

        })
    }
    func getProfile(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
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
        print(proHeader)
        getProfile.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+FIRM_PROFILE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            self.firmProfileModel = FirmProfileModel(object:dict)
            print(dict)
            if boolSuccess {
               
                if self.firmProfileModel?.appStatusCode == 0{
                    UserDefaults.standard.setValue(self.firmProfileModel?.payloadJson?.data?.cStateCode, forKey: DefaultstateCodeStr)
//                    let proLblName = firmProfileModel?.payloadJson?.data?.cName
//
//                    profilePlaceHolderLbl.text = proLblName?.first(char: 1)
                    tpAreaLbl.text = "In \(firmProfileModel?.payloadJson?.data?.cCityName ?? "") "
                    nlAreaLbl.text = "All Over \(firmProfileModel?.payloadJson?.data?.cStateName ?? "") "
                    emailAdd = firmProfileModel?.payloadJson?.data?.cEmail ?? ""
                    pincode = firmProfileModel?.payloadJson?.data?.cPincode ?? ""
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
//                                     profilePlaceHolderLbl.text = stringNeed.uppercased()
                   
                    let userName = firmProfileModel?.payloadJson?.data?.cName?.getAcronyms().uppercased()
                    
                  
                    profilePlaceHolderLbl.text = userName?.maxLength(length: 2)
                    hideActivityIndicator(self.view)
                    self.topmostApi(completion: topMost_completion)
                    completion()


                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                

            }else{
                hideActivityIndicator(self.view)

                apiQueue.leave()
                completion()

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
            //hideActivityIndicator(self.view)
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
            completion()



        })
        
        
        }
    //MARK: - get user
    func getUser(mobileNoStr:String,completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
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
        
        let getUserParms = ["c_mobile_no":mobileNoStr ?? "",] as [String : Any]
        print(proHeader)
        getProfile.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+GET_USER_URL, type: .post, userData: getUserParms, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            
            if boolSuccess {
               
                if self.getUserModel?.appStatusCode == 0{
                    completion()

                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                

            }else{
                hideActivityIndicator(self.view)

                apiQueue.leave()
                completion()

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
            //hideActivityIndicator(self.view)
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
            completion()


        })
        
        
        }

    
    //MARK: - shotBookCount
    func sbItemCode(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
            showActivityIndicator(self.view)

        let sbItemCode:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sbItemCode")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let proHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(proHeader)
        sbItemCode.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+SHORTBOOK_ITEM_CODE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.sbItemCodeModel = SBItemCodeModel(object:dict)
            
            if boolSuccess {
               
                if self.sbItemCodeModel?.appStatusCode == 0{
                    

                    hideActivityIndicator(self.view)
                    completion()

                    
                   
                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                

            }else{
                        
                hideActivityIndicator(self.view)
                completion()


            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            print(errorMesssage)
            //hideActivityIndicator(self.view)
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

            completion()


        })
        apiQueue.leave()
        
        }
    //MARK: - Wish ListItem Code
    func wlItemCode(completion: @escaping LOHOMELOADAPI){
        apiQueue.enter()
            showActivityIndicator(self.view)

        
        let sbItemCode:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sbItemCode")
        
//            let sHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                        "X-csquare-api-token":"99355562095561bc",
//                                        "Content-Type":"application/json",
//                                            ]

        let proHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
        print(proHeader)
        sbItemCode.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+WISHLIST_ITEM_CODE_URL, type: .get, userData: nil, apiHeader: proHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.wlItemCodeModel = WLItemCodeModel(object:dict)
            
            if boolSuccess {
               
                if self.wlItemCodeModel?.appStatusCode == 0{

                    hideActivityIndicator(self.view)

                    completion()
                }else{
                    hideActivityIndicator(self.view)
                    completion()

                }
                
               hideActivityIndicator(self.view)
                
            }else{
                        
                hideActivityIndicator(self.view)
                completion()

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

            completion()


        })
        apiQueue.leave()
        
        }
    func removeWishList(itemCodeStr:String,itemNameStr:String){

        showActivityIndicator(self.view)
        let WishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let WishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        let WishListHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                           "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                           "Content-Type":"application/json",
        ]
        
        WishList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REMOVE_FROM_WISHLIST_URL, type: .post, userData: WishListParams, apiHeader: WishListHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.removeFromWLModel = RemoveFromWLModel(object:dict)
            
            if boolSuccess {
                //hideActivityIndicator(self.view)
                if self.removeFromWLModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromWLModel?.messages?[0] ?? "", view: self.view)

                    if isNewLaunchInt == 1{
                        self.nWishListIntArray[nwishListIndexInt] = 0

                        let wbIndexPath = IndexPath(item:nwishListIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [wbIndexPath])
                    }else{
                        self.wishListIntArray[wishListIndexInt] = 0

                        let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [wbIndexPath])

                    }

                    
                    wlItemCode(completion: wlItemCode_completion)
                  //  watchlistCount()
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removeFromWLModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removeFromWLModel?.messages?[0] ?? "", view: self.view)

                    if isNewLaunchInt == 1{
                        self.nWishListIntArray[nwishListIndexInt] = 0

                        let wbIndexPath = IndexPath(item:nwishListIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [wbIndexPath])
                    }else{
                        self.wishListIntArray[wishListIndexInt] = 0

                        let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [wbIndexPath])

                    }

                    wlItemCode(completion: wlItemCode_completion)
                   // watchlistCount()
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            hideActivityIndicator(self.view)
            
        })
        
        
    }
    func addToWishList(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let addToWishList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToWishList")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let addToWishListParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        
        let WlHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                     "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                     "Content-Type":"application/json",
        ]
        
        addToWishList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_WISHLIST_URL, type: .post, userData: addToWishListParams, apiHeader: WlHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addtoWLmodel = AWBaseClass(object:dict)
            
            if boolSuccess {
                //hideActivityIndicator(self.view)
                if self.addtoWLmodel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    if isNewLaunchInt == 1{
                        self.nWishListIntArray[nwishListIndexInt] = 1

                        let wbIndexPath = IndexPath(item:nwishListIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [wbIndexPath])
                    }else{
                        self.wishListIntArray[wishListIndexInt] = 1

                        let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [wbIndexPath])

                    }
                    wlItemCode(completion: wlItemCode_completion)
                    
                    
                    
                }else {
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoWLmodel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoWLmodel?.messages?[0] ?? "", view: self.view)
                    if isNewLaunchInt == 1{
                        self.nWishListIntArray[nwishListIndexInt] = 1

                        let wbIndexPath = IndexPath(item:nwishListIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [wbIndexPath])
                    }else{
                        self.wishListIntArray[wishListIndexInt] = 1

                        let wbIndexPath = IndexPath(item:wishListIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [wbIndexPath])

                    }
                    wlItemCode(completion: wlItemCode_completion)

                    
                }
                
                
                
            }else{
                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            hideActivityIndicator(self.view)

        })
        
        
    }
    func addToShotook(itemCodeStr:String,itemNameStr:String){

        showActivityIndicator(self.view)
        
        
        let topmost:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToShortook")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let itemCodeParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        
        let shHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                     "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                     "Content-Type":"application/json",
        ]
        
        topmost.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ADD_TO_SHOTBOOK_URL, type: .post, userData: itemCodeParams, apiHeader: shHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addtoSBModel = AddToSBModel(object:dict)
            
            if boolSuccess {
                
                //hideActivityIndicator(self.view)
                if self.addtoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    
                    if isNewLaunchInt == 1{
                        self.nShotBookIntArray[nshotBookIndexInt] = 1
                        let sbIndexPath = IndexPath(item:nshotBookIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [sbIndexPath])
                    }else{
                        self.shotBookIntArray[shotBookIndexInt] = 1
                        let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [sbIndexPath])
                    }
                   
                    sbItemCode(completion: sbItemCode_completion)
    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addtoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addtoSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    UIView.performWithoutAnimation {
                        if isNewLaunchInt == 1{
                            self.nShotBookIntArray[nshotBookIndexInt] = 1
                            let sbIndexPath = IndexPath(item:nshotBookIndexInt, section: 0)
                            self.newLaunchCollectionView.reloadItems(at: [sbIndexPath])
                        }else{
                            self.shotBookIntArray[shotBookIndexInt] = 1
                            let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                            self.tPCollectionView.reloadItems(at: [sbIndexPath])

                        }
                        
                    }
                    sbItemCode(completion: sbItemCode_completion)


                    
                    
                }
                
                
                
            }else{
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
        })
        
        
    }
    func removeShotbook(itemCodeStr:String,itemNameStr:String){
        showActivityIndicator(self.view)
        let remove:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "removeShotook")
        
        //        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
        //                                    "X-csquare-api-token":"99355562095561bc",
        //                                    "Content-Type":"application/json",
        //                                        ]
        let removeParams = ["c_item_code":itemCodeStr,"c_item_name": itemNameStr,"c_mobile":UserDefaults.standard.value(forKey: usernameConstantStr)]
        
        let removeHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                         "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                         "Content-Type":"application/json",
        ]
        
        remove.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+REMOVE_FROM_SHORTBOOK_URL, type: .post, userData: removeParams, apiHeader: removeHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.removetoSBModel = RemoveFromSBModel(object:dict)
            
            if boolSuccess {
                //hideActivityIndicator(self.view)
                
                if self.removetoSBModel?.messages?.isEmpty == true{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    if isNewLaunchInt == 1{
                        self.nShotBookIntArray[nshotBookIndexInt] = 0
                        let sbIndexPath = IndexPath(item:nshotBookIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [sbIndexPath])
                    }else{
                        self.shotBookIntArray[shotBookIndexInt] = 0
                        let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [sbIndexPath])

                    }
                    sbItemCode(completion: sbItemCode_completion)
                  // shortBookCount()
                    
                    
                    
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.removetoSBModel?.messages?[0], style: .info)
                    banner.showToast(message: self.removetoSBModel?.messages?[0] ?? "", view: self.view)
                    let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                    if isNewLaunchInt == 1{
                        self.nShotBookIntArray[nshotBookIndexInt] = 0
                        let sbIndexPath = IndexPath(item:nshotBookIndexInt, section: 0)
                        self.newLaunchCollectionView.reloadItems(at: [sbIndexPath])
                    }else{
                        self.shotBookIntArray[shotBookIndexInt] = 0
                        let sbIndexPath = IndexPath(item:shotBookIndexInt, section: 0)
                        self.tPCollectionView.reloadItems(at: [sbIndexPath])

                    }
                    sbItemCode(completion: sbItemCode_completion)
                   // shortBookCount()
                    
                    
                    
                }
                
                
                
            }else{
                //hideActivityIndicator(self.view)
                
                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            //hideActivityIndicator(self.view)
        })
    }
    func productWiseSellerDetails(wishItemCodeStr:String,itemName:String){
        
        showActivityIndicator(self.view)
        print(wishItemCodeStr)
        let productWiseSeller:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "proSeller")
        let productWiseSellerParams = ["c_search_term": wishItemCodeStr,
                                       "n_limit": 10,
                                       "n_page": 0] as [String : Any]
        print(productWiseSellerParams)
    
        
        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                                    "Content-Type":"application/json",
        ]
        print(productWiseSellerHeader)
        
        productWiseSeller.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+PRODUCT_WISE_SELLER_DETAILS_URL, type: .post, userData: productWiseSellerParams, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
        
            self.productWiseSellerModel = ProductVsSellerDetailsModel(object:dict)
            
            if boolSuccess {
                
             if self.productWiseSellerModel?.appStatusCode == 0{
                 hideActivityIndicator(self.view)
                    for (_,ele) in (productWiseSellerModel?.payloadJson?.data?.jList)!.enumerated() {
                        self.selectQty.append("1")
                    }
                    
                    print(self.selectQty)
                    

                 
                 if productWiseSellerModel?.payloadJson?.data?.jList?.count == 0{
                     productWiseSellerModel?.payloadJson?.data?.jList?.removeAll()
                     unSellerList(searcTermStr: wishItemCodeStr,sitemName:itemName)

                 }else{
                     self.osSellerModel?.payloadJson?.data?.removeAll()
                     addToCartView?.delegate = self
                     addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                     addToCartView?.productwiseSellerModel = productWiseSellerModel
                     addToCartView?.selectQtyS = selectQty
                     addToCartView?.productName = itemName
                     print(addToCartView?.bestSchemesTableView.contentSize.height)
                     
                     self.view.addSubview(addToCartView!)

                 }
                   
                }else{
                    print(addToCartView?.cartBtnIndex ?? 0)

                    hideActivityIndicator(self.view)

                    
                }
                
                
                
            }else{
                print(addToCartView?.cartBtnIndex ?? 0)

                hideActivityIndicator(self.view)

                
            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            
            hideActivityIndicator(self.view)

        })
        
        
    }
    
    func addToCart(item_codeStr:String,mobile_noStr:String,seller_codeStr:String,seller_item_codeStr:String,seller_nameStr:String,n_mrpStr:Float,n_qtyStr:String,n_seller_rateStr:Float){
        let addToCart:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "AddToCart")
        let addToCartParms = ["c_item_code":item_codeStr,
                              "c_mobile_no":mobile_noStr ?? "",
                              "c_seller_code":seller_codeStr,
                              "c_seller_item_code":seller_item_codeStr,
                              "c_seller_name":seller_nameStr,
                              "n_mrp":n_mrpStr,
                              "n_qty":n_qtyStr,
                              "n_seller_rate":n_seller_rateStr
        ] as [String : Any]
        
        print(addToCartParms)
        
//        let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":"TihpuDEJ0nq2LuqL1e0CuA==",
//                                    "X-csquare-api-token":"-20736993905466b",
//                                    "Content-Type":"application/json",
//                                        ]

                let productWiseSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                            "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                            "Content-Type":"application/json",
                                                ]

        addToCart.callServiceAndGetData(url:LIVE_ORDER_HOSTURL+ADD_TO_CART_URL, type: .post, userData: addToCartParms, apiHeader: productWiseSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.addItemModel = AddItemModel(object: dict)
            
            print(dict)
            if boolSuccess {
                if addItemModel?.appStatusCode == 0{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addItemModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addItemModel?.messages?[0] ?? "", view: self.view)
                    self.cartCount(completion:cartCount_completion)
                }else{
                    let banner = NotificationBanner(title: "Message", subtitle: self.addItemModel?.messages?[0], style: .info)
                    banner.showToast(message: self.addItemModel?.messages?[0] ?? "", view: self.view)
                    print(addToCartView?.cartBtnIndex)
                    addToCartView?.addInt[addToCartView?.cartBtnIndex ?? 0] = 0

                }
                
            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           

        })
        
        
        }

   

    func sendEmailForDemo(storeName:String,mobile_noStr:String,owner:String,pincode:String,des:String,email:String){
        let sendEmailForDemo:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "sendEmailForDemo")
        let demoParms = [
            "to":
               [ "c_to": [
                    email
                ]],
            "c_to_cc": [],
                "c_to_bcc": []
            ,
            "c_subject": "C-Square - Demo Request",
            "c_content": "<h1>New Enquiry from Liveorder</h1><h5>You have received an enquiry from {\(owner)}, with the following information</h5>Store: <b>{\(storeName)}</b><br>Owner: <b>{\(owner)}</b><br>Phone: <b>{\(mobile_noStr)}</b><br>Pincode: <b>{\(pincode)}</b><br>Product Interested: <b>{product interested}</b><br><br>Description: <b>{\(des)}</b>",
            "attachMents": []
        
        ] as [String : Any]
        
        print(demoParms)
        
 

              

        sendEmailForDemo.callServiceAndGetData(url:CSQUARE_DEMO_URL, type: .post, userData: demoParms, apiHeader: nil,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
           
            
          
            if boolSuccess {
               
            }else{
               

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           

        })
        
        
}
    func demoDemo(storeName:String,mobile_noStr:String,owner:String,pincode:String,des:String,cPro:String){
        let Demo:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "Demo")
        let demoParms = [
            "c_description": des,
            "c_existing_customer": "N",
            "c_mobile_no": mobile_noStr,
            "c_owner_name": owner,
            "c_pincode": pincode,
            "c_product": cPro,
            "c_store_name": storeName
        
        ] as [String : Any]
        
        print(demoParms)
        
 
        let demoHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                    "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                    "Content-Type":"application/json",
                                        ]
              

        Demo.callServiceAndGetData(url:DEMO_URL, type: .post, userData: demoParms, apiHeader: demoHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
           
            sendDonePopView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 50)
            sendDonePopView?.delegate = self
            print(dict)
            if boolSuccess {
                let resDict = dict as! NSDictionary
           let result = resDict.value(forKey: "appStatusCode") as! Int
           let resMess = resDict.value(forKey: "messages") as! NSArray
           if result == 0 {
               //Add the view
               self.sendDonePopView?.imgView.image = UIImage(named: "icon for success ")
               self.sendDonePopView?.thankyouLbl.text = "\(resMess[0]) " + "Team C-Square will get in touch with you Shortly."
               
               self.askForDemoView?.addSubview(sendDonePopView!)
        
           }else{
               //Add the view
               self.sendDonePopView?.imgView.image = UIImage(named: "exclamation")
               self.sendDonePopView?.thankyouLbl.text = "\(resMess[0]) "
               self.askForDemoView?.addSubview(sendDonePopView!)

           }

            }else{
                        

            }
            
        }, failureBlock: {[unowned self] (errorMesssage) in
           

        })
        
        
        }
    
    func unSellerList(searcTermStr:String,sitemName:String){
        showActivityIndicator(self.view)
        
        let orderSellerList:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "OrderSellerList")
        
//        let nHeader :HTTPHeaders = ["X-csquare-api-key":"JfnAD5VBioeNf+mixZU0Rw==",
//                                    "X-csquare-api-token":"99355562095561bc",
//                                    "Content-Type":"application/json",
//                                        ]
        let orderSellerParams = ["c_search_term":searcTermStr,
                                "n_page":0,
                                 "n_limit":20] as [String : Any]

            let orderSellerHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                        "Content-Type":"application/json",
                                            ]
        
        print(orderSellerHeader)

        orderSellerList.callServiceAndGetData(url: LIVE_ORDER_HOSTURL+ORDER_TO_SELLER_LIST_URL, type: .post, userData: orderSellerParams, apiHeader: orderSellerHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.osSellerModel = OrderSellerList(object:dict)
            if boolSuccess {
                hideActivityIndicator(self.view)
                if self.osSellerModel?.payloadJson?.data?.count == 0{
                    hideActivityIndicator(self.view)

                }else{
                    hideActivityIndicator(self.view)
                    addToCartView?.delegate = self
                    addToCartView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    addToCartView?.osSellerModel = osSellerModel

                    addToCartView?.selectQtyS = selectQty
                    addToCartView?.productName = sitemName
                    print(addToCartView?.bestSchemesTableView.contentSize.height)
                    self.view.addSubview(addToCartView!)                }

               
            }else{
                hideActivityIndicator(self.view)

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
}




