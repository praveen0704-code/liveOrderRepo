//
//  ApiServices.swift
//  liveOrder
//
//  Created by Data Prime on 30/07/21.
//

import Foundation
import Alamofire



public let baseURL = "https://dev-lc.livc.in"

class ApiService
{
   // static let shared = APIManager()   https://www.datasense.in/c2/lc/ms/web/getPreferredSellerInspired
 
    static var getloginDetails = "/c2/lc/ms/cust/na/login"
    static var postregisterDetails = "/c2/lc/ms/cust/na/register"
    static var checkMobileUrlStr = "/c2/lc/ms/cust/na/check"
    static var areaUrlStr = "/c2/lc/ms/mst/g/area/TN1804"
    static var cityUrlStr = "/c2/lc/ms/mst/g/city/IND033"
    static var stateUrlStr = "/c2/lc/ms/mst/g/state"
    static var otpSendUrlStr = "/c2/otp/send/"
    static var otpVerifyUrlStr = "/lc/ms/c2/otp/verify"
    static var updateUrlStr = "/c2/changepassword"
    static var nameCheck = "/c2/firm/Usernamecheck"
    static var firminfoUrl = "/c2/lc/ms/cust/firm/detail"
    static var bannerUrlStr = "/c2/lc/ms/mst/g/banner"
    static var SellerInspiredUrlStr = "/c2/lc/ms/mst/seller/preferred"
    static var topMostItemStr = "/c2/lc/ms/mst/item/top"
    static var NewLanchedStr = "/c2/lc/ms/mst/item/new"
    static var ShopFromManifacture = "/c2/lc/ms/mst/head/mfg"
    static var LimitedPeriodStr = "/c2/lc/ms/mst/head/offers"
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

//    static func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
//    {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let postString = self.getPostString(params: params)
//        request.httpBody = postString.data(using: .utf8)
//
//        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if(error != nil)
//            {
//                result.message = "Fail Error not null : \(error.debugDescription)"
//            }
//            else
//            {
//                result.message = "Success"
//                result.data = data
//            }
//
//            finish(result)
//        }
//        task.resume()
//    }
//    
//    
//    static func callPostH(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
//    {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let postString = self.getPostString(params: params)
//        request.httpBody = postString.data(using: .utf8)
//        
//        let loginDict = UserDefaults.standard.value(forKey: "LoginKeypayloadJson") as! NSDictionary
//        
//        
//        if let apikey = loginDict.value(forKey: "X-csquare-api-key ") as? String , let token = loginDict.value(forKey: "X-csquare-api-token ") as? String{
//            request.setValue(apikey, forHTTPHeaderField: "X-csquare-api-key" )
//            request.setValue(token, forHTTPHeaderField: "X-csquare-api-token" )
//            
//        }
//        
//        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if(error != nil)
//            {
//                result.message = "Fail Error not null : \(error.debugDescription)"
//            }
//            else
//            {
//                result.message = "Success"
//                result.data = data
//            }
//
//            finish(result)
//        }
//        task.resume()
//    }
}
