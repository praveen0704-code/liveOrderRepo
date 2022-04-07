//
//  PlpExtension.swift
//  liveOrder
//
//  Created by PraveenMac on 25/01/22.
//

import Foundation
import UIKit
import Alamofire

extension PlpVC{
    //MARK: - new launch Completion Shotbook Wish List
        func nshotBookAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (self.arrayJItems)!.enumerated(){
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
        func nwishListAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (self.arrayJItems)!.enumerated(){
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
    
    //MARK: - Top Order Completion Shotbook Wish List
        func shotBookAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (self.topmostModel?.payloadJson?.data?.jList)!.enumerated(){
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
            for (inx,ele) in (self.topmostModel?.payloadJson?.data?.jList)!.enumerated(){
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

        }
    
    //MARK: - shopByManifacture Completion Shotbook Wish List
        func shopBySBAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (itemBySellerCodeModel?.payloadJson?.data?.jList)!.enumerated(){
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
        func shopByWLAddRemove(completion: @escaping SWCOMPLETION) {
            
            for (inx,ele) in (itemBySellerCodeModel?.payloadJson?.data?.jList)!.enumerated(){
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
    
    //MARK: - sellerInspiredManifacture Completion Shotbook Wish List
        func sellerInspiredSBAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (itemByMfcCodeModel?.payloadJson?.data?.jList)!.enumerated(){
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
        func sellerInspiredWLAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (itemByMfcCodeModel?.payloadJson?.data?.jList)!.enumerated(){
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

        }
    
    //MARK: - categories Completion Shotbook Wish List
        func calteoriesAddRemove(completion: @escaping SWCOMPLETION){
            
            for (inx,ele) in (itemByCatMOdel?.payloadJson?.data?.jList)!.enumerated(){
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
        func cateoriesWLAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (itemByCatMOdel?.payloadJson?.data?.jList)!.enumerated(){
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
    //MARK: - allProducts Completion Shotbook Wish List
        func allProductsAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (allProductModel?.payloadJson?.data?.jList)!.enumerated(){
                self.shotBookIntArray.append(0)
                
                if self.sbItemCodeModel?.payloadJson?.data != nil{
                    for (_,sele) in (self.sbItemCodeModel?.payloadJson?.data)!.enumerated(){
                        if ele.cItemCode == sele.cItemCode{
                            print(inx)
                            shotBookIntArray[inx] = 1
                        }else{
                          //  shotBookIntArray[inx] = 0
                        }
                    }

                }
            }
            
            
            
        }
        func allProductsWLAddRemove(completion: @escaping SWCOMPLETION){
            for (inx,ele) in (allProductModel?.payloadJson?.data?.jList)!.enumerated(){
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
            print("wish list\(wishListIntArray)")
            completion()

        }
    
    //MARK: - Counts
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
                        self.shortbookBtn.badgeButtonProperty()
                        self.shortbookBtn.badgeLabel.isHidden = true
                        
                   // self.shortbookBtn.badge = "\(shortBookCountModel?.payloadJson?.data?.count ?? 0)"
                        
                        
                    }else{
                        
                        self.shortbookBtn.badgeLabel.isHidden = true
                        
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
                        
                        //self.wishListBtn.badge = "\(watchlistCountModel?.payloadJson?.data?.count ?? 0)"
                        
                        
                    }else{
                        self.wishListBtn.badgeLabel.isHidden = true
                        hideActivityIndicator(self.view)

                    }
                    
                    
                    
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    
    //MARK: - GET COUNT
    func sellerInspiredByCount(urStr:String,sellerCode:String){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let totalCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "totalCount")
        
       
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        let plpCount = ["c_availability": availability,
                        "c_brands":brands,
                        "c_manufacturers": manufacturers,
                        "c_sellers": sellers,
                        "c_sort": sort,
                        "c_product_search": "",
                        "c_search_term":sellerCode,
                             "n_limit": 20,
                             "n_page": nextPageInt] as [String : Any]
        
        
        print(plpCount)
        totalCount.callServiceAndGetData(url: urStr, type: .post, userData: plpCount, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.totalCountModl = TotalCountBaseClass(object:dict)
            if boolSuccess {
                
                if self.totalCountModl?.appStatusCode == 0{
                    
                    self.itemLbl.text = "\(totalCountModl?.payloadJson?.data?.nTotal ?? 0)"
                    hideActivityIndicator(self.view)

                 
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    //MARK: - GET COUNT
    func topMostOrderCount(urStr:String,pincode:String){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let totalTopCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "totalTopCount")
        
       
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        let topOrderCount = ["c_availability": availability,
                        "c_brands":brands,
                        "c_manufacturers":manufacturers,
                        "c_pincode":pincode,
                        "c_sellers": sellers,
                        "c_sort": sort,
                         "n_limit": 20,
                         "n_page": nextPageInt] as [String : Any]
        
        
        print(topOrderCount)
        totalTopCount.callServiceAndGetData(url: urStr, type: .post, userData: topOrderCount, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.totalCountModl = TotalCountBaseClass(object:dict)
            if boolSuccess {
                
                if self.totalCountModl?.appStatusCode == 0{
                    
                    self.itemLbl.text = "\(totalCountModl?.payloadJson?.data?.nTotal ?? 0)"
                    hideActivityIndicator(self.view)

                 
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    
    func shopByMfcCount(urStr:String,searchStr:String){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let totalMFCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "totalMFCount")
        
       
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        let topOrderCount = ["c_availability": availability,
                        "c_brands":brands,
                        "c_manufacturers":manufacturers,
                        "c_search_term":searchStr,
                        "c_sellers": sellers,
                        "c_sort": sort,
                         "n_limit": 20,
                         "n_page": nextPageInt] as [String : Any]
        
        
        print(topOrderCount)
        totalMFCount.callServiceAndGetData(url: urStr, type: .post, userData: topOrderCount, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.totalCountModl = TotalCountBaseClass(object:dict)
            if boolSuccess {
                
                if self.totalCountModl?.appStatusCode == 0{
                    
                    self.itemLbl.text = "\(totalCountModl?.payloadJson?.data?.nTotal ?? 0)"
                    hideActivityIndicator(self.view)

                 
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    func categoriesListCount(urStr:String,searchStr:String){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let  categoriesListCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "categoriesListCount")
        
       
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        let categoriesListCParm = ["c_availability": availability,
                        "c_brands":brands,
                        "c_manufacturers":manufacturers,
                        "c_search_term":searchStr,
                        "c_sellers": sellers,
                        "c_sort": sort,
                         "n_limit": 20,
                         "n_page": nextPageInt] as [String : Any]
        
        
        print(categoriesListCParm)
        categoriesListCount.callServiceAndGetData(url: urStr, type: .post, userData: categoriesListCParm, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.totalCountModl = TotalCountBaseClass(object:dict)
            if boolSuccess {
                
                if self.totalCountModl?.appStatusCode == 0{
                    
                    self.itemLbl.text = "\(totalCountModl?.payloadJson?.data?.nTotal ?? 0)"
                    hideActivityIndicator(self.view)

                 
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    func allProductsCount(urStr:String){
        self.showActivityIndicator(self.view)
        apiQueue.enter()
        let  allProductsCount:HttpManager = HttpManager.init(delegate: self, sessionExpiryMessage: "allProductsCount")
        
       
        
        let wlbHeader :HTTPHeaders = ["X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
                                      "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
                                      "Content-Type":"application/json",
        ]
        let allProductsCParm = ["c_availability": availability,
                                   "c_brands": brands,
                                   "c_manufacturers": manufacturers,
                                   "c_mobile_no": UserDefaults.standard.value(forKey: usernameConstantStr) ?? "",
                                   "c_sellers": sellers,
                                   "c_sort": sort,
                                   "n_page": nextPageInt,
                                   "n_limit": 20] as [String : Any]
        
        
        print(allProductsCParm)
        allProductsCount.callServiceAndGetData(url: urStr, type: .post, userData: allProductsCParm, apiHeader: wlbHeader,  successBlock: { [self] (boolSuccess, stringMessage, dict) in
            print(dict)
            self.totalCountModl = TotalCountBaseClass(object:dict)
            if boolSuccess {
                
                if self.totalCountModl?.appStatusCode == 0{
                    
                    self.itemLbl.text = "\(totalCountModl?.payloadJson?.data?.nTotal ?? 0)"
                    hideActivityIndicator(self.view)

                 
                }else{
                    hideActivityIndicator(self.view)

                }
                
                hideActivityIndicator(self.view)
                
            }else{
                
                hideActivityIndicator(self.view)

            }
            apiQueue.leave()
            
            
        }, failureBlock: {[unowned self] (errorMesssage) in
            apiQueue.leave()
            hideActivityIndicator(self.view)

        })
    }
    
}
