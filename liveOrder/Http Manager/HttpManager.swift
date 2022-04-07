//
//  HttpManager.swift

//
//  Created by Andal Priyadharshini K on 22/10/18.
//  Copyright © 2018 Andal Priyadharshini K. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift
import NotificationBannerSwift



/// HTTP Manager used to Call Webservice
public typealias kModelSuccessBlock = (_ success : Bool, _ message : String, _ responseObject:AnyObject) ->()
public typealias kModelErrorBlock = (_ errorMesssage: String) -> ()
typealias imageUploadHttpCompletionHandler = (Bool, [String:Any], Error?) -> Void



// Webservice type
public enum STWebServiceType {
    case put
    case get
    case delete
    case post
    case patch
}
/// NectoWebSerivceDelegate
public protocol WebServiceDelegate{
    func webServiceGotExpiryMessage(errorMessage: String)
}



public class HttpManager{
    var delegate:WebServiceDelegate?
    var sessionExpiryMessage: String = ""
    var sessionManager: Session!
    /// initing the AUWebService class
    ///
    /// - Parameters:
    ///   - delegate: mandatory delegate to be assigned
    ///   - sessionExpiryMessage: session expiry message/code which server is sending. Leave it empty if there is no session expiry to be handled
    public init(delegate: WebServiceDelegate, sessionExpiryMessage: String = ""){
        self.delegate = delegate
        self.sessionExpiryMessage = sessionExpiryMessage
    }
    /// Call this method to get data/ error message in web service. Need not print anything, method prints all params in debug mode. Failure block will be called if Rechability fails
    ///
    /// - Parameters:
    ///   - url: String Url. In case of get|put|delete full url with params
    ///   - type: AUWebServiceType(get|post|delete|put)
    ///   - userData: in case of post send [String:any], others nil should be suffice
    ///   - headers: accessToken - default header details and other headers
    ///   - successBlock: success block
    ///   - failureBlock: failure block
    /// - Returns: Success/Failure block. If session expiry message is set, and if service get the message, delegate will be called to handle the session expiry
    public func callServiceAndGetData(url: String,
                                      type: STWebServiceType,
                                      userData: [String: Any]?,
                                      arrayUserData: [Any]? = nil,
                                      approveJobBool:Bool? = nil,
                                      apiHeader: HTTPHeaders?,
                                      successBlock: @escaping kModelSuccessBlock,
                                      failureBlock : @escaping kModelErrorBlock)
    
    {
        
        var httpMethod: HTTPMethod?
        
        // type
        
        switch type {
        
        case .put:
            
            httpMethod = .put
            
        case .get:
            
            httpMethod = .get
            
        case .delete:
            
            httpMethod = .delete
            
        case .post:
            
            httpMethod = .post
            
        case .patch:
            
            httpMethod = .patch
            
        }
        print(url)
        debugPrint(url )
        debugPrint(userData ?? "")
        debugPrint(apiHeader ?? "")
        debugPrint(arrayUserData ?? "")
        if Reachability.isConnectedToNetwork() == true
        
        {
            if arrayUserData != nil {
                print(arrayUserData?.asParameters())
                AF.request(url, method: httpMethod!, parameters: arrayUserData?.asParameters(), encoding: ArrayEncoding(), headers:apiHeader).responseJSON { response in
                    let objectKeys = (response.value as AnyObject).allKeys
                    guard objectKeys != nil || (response.value != nil) else {
                        let dictionarys:NSDictionary = ["data" : "", "statusCode":202, "message":"response error" as Any]
                        self.getWedData(response: response.value as! AFDataResponse<Data> , organisedObject: dictionarys,successBlock: successBlock, failureBlock: failureBlock)
                        return
                    }
                    print(response.value ?? "no value")
                    let array = NSArray()
                    if  ((objectKeys as NSArray?) ?? array).contains("error") {
                        let dictionary:NSDictionary = ["data" : response.value!, "statusCode":202,"message":(response.value as AnyObject).value(forKey: "error") as Any]
                        self.getWedData(response: response.value as! AFDataResponse<Data>, organisedObject: dictionary,successBlock: successBlock, failureBlock: failureBlock)
                        
                    }
                    
                    else if (response.value != nil) {
                        if let dictArray = response.value as? NSArray {
                            
                            if dictArray.count > 0 {
                                
                                let dictionary:NSDictionary = ["data" : dictArray, "statusCode":200,"message":"success"]
                                
                                self.getWedData(response: response.value as! AFDataResponse<Data>, organisedObject: dictionary,successBlock: successBlock, failureBlock: failureBlock)
                            }
                            
                            else{
                                
                                failureBlock("No data found" as String)
                            }
                        }
                        else {
                            let dictionary:NSDictionary = ["data" : response.value!, "statusCode":200,"message":"success"]
                            self.getWedData(response: response.value as! AFDataResponse<Data>, organisedObject: dictionary,successBlock: successBlock, failureBlock: failureBlock)
                        }
                    }
                }
            } else {
                
                if approveJobBool == true{
                    AF.request(url, method: httpMethod!, parameters: userData , encoding: JSONEncoding.default, headers: apiHeader).responseJSON { response in
                        let objectKeys = response.response?.statusCode
                        if objectKeys == 200 {
                            let dictionarys:NSDictionary = ["data" : "", "statusCode":200, "message":"response error" as Any]
                            print(response.value ?? "no value")
                            successBlock(true, "\(objectKeys)", dictionarys)
                        }else{
                            
                            failureBlock("Approve job failure")
                        }
                    }
                }else{
                    AF.request(url, method: httpMethod!, parameters: userData , encoding: JSONEncoding.default, headers: apiHeader).responseJSON { response  in
                        let objectKeys = (response.value as AnyObject).allKeys
                        guard objectKeys != nil || (response.value != nil) else {
                            if response.response?.statusCode == 200
                            {
                                let dic = ["status" : "Approved", "isFrom" : "material"
                                ]
                                let dictionary:NSDictionary = ["data":dic , "statusCode":202,"message": "success"]
                                print(dictionary)
                                successBlock(true, "Success",dictionary)
                                return
                            }
                            else{
                            let dictionarys:NSDictionary = ["data" : "", "statusCode":202, "message":"response error" as Any]
                            print(response.value ?? "no value")
                                failureBlock("response error")
                                //successBlock(true, "Success",response.value as! NSDictionary)

//                                self.getWedData(response:response.value as! AFDataResponse<Data>, organisedObject: dictionarys,successBlock: successBlock, failureBlock: failureBlock)
                            return
                            }
                        }
        
                        let array = NSArray()
                        
                        if  ((objectKeys as NSArray?) ?? array).contains("error") {
                            
                            let dictionary:NSDictionary = ["data" : response.value!, "statusCode":202,"message":(response.value as AnyObject).value(forKey: "error") as Any]
                            
                            print(dictionary)
                            
                            successBlock(true, "Success",response.value as! NSDictionary)

//                            self.getWedData(response: response.value as! AFDataResponse<Data>, organisedObject: dictionary,successBlock: successBlock, failureBlock: failureBlock)
                            
                        }
                        
                        else if (response.value != nil) {
                            
                            if let dictArray = response.value as? NSArray {
                                
                                if dictArray.count > 0 {
                                    
                                    let dictionary:NSDictionary = ["data" : dictArray, "statusCode":200,"message":"success"]
                                    

                                    
                                }
                                
                                else{
                                    
                                    failureBlock("No data found" as String)
                                    
                                }
                                
                            }
                            
                            else {
                                
                                let dictionary:NSDictionary = ["data" : response.value!, "statusCode":200,"message":"success"]
                                
                                successBlock(true, "Success",response.value as! NSDictionary)

                                print(response.value!)
                                
                              
                                
                            }
                            
                        }
                    }
                }
            }
        } else {
            
            failureBlock("Please check your internet connection" as String)
           
        }
        
    }
    func getWedData(response:AFDataResponse<Data>,organisedObject:NSDictionary, successBlock: @escaping kModelSuccessBlock,
                    failureBlock : @escaping kModelErrorBlock) {
        switch(response.result) {
        case .success(_):
            if response.value != nil{
                debugPrint(response.value ?? "")

                if response.value != nil{
                    // successBlock(true, "Success",response.result.value as AnyObject)
                    successBlock(true, "Success",organisedObject)
                }
            }
            break
            
        case .failure(let error):
            failureBlock(error.localizedDescription as String)
            break
        }
    }
    /// check for session and move to login page
    /// - Parameter result: check token
    
    /// Request to
    /// - Parameters:
    ///   - serviceURL: Service url
    ///   - headers: Authorization Headers
    ///   - chosenImage: Image description

    ///   - completionHandler: 
    
        
    // Sent Request in header itself
    func uploadImage(imageNmae:UIImage,imgUrlStr:String,apiHeader: HTTPHeaders?,successBlock: @escaping kModelSuccessBlock,
                     failureBlock : @escaping kModelErrorBlock){
     
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageNmae.jpegData(
                    compressionQuality: 0.5)!,
                    withName: "img",
                    fileName: "profile.jpeg", mimeType: "image/jpeg"
                )
//                for param in params {
//                    let value = param.value.data(using: String.Encoding.utf8)!
//                    multipartFormData.append(value, withName: param.key)
//                }
            },
            to:LIVE_ORDER_HOSTURL+IMG_UPLOAD_URL,
            method: .post ,
            headers: apiHeader
        )
        .responseJSON { responseRes in
            print(responseRes)
            let objectKeys = responseRes.response?.statusCode
            print(objectKeys)
            if objectKeys == 200 {
                let dictionarys:NSDictionary = ["data" : "", "statusCode":200, "message":"response error" as Any]
                print(responseRes.value ?? "no value")
                successBlock(true, "\(objectKeys)", dictionarys)
            }else{
                
                failureBlock("img not uploaded")
            }
        }
        
    }

    
    
}

//MARK: - Optional parameter array function
private let arrayParametersKey = "arrayParametersKey"
/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}


/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
public struct ArrayEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    
    /// Creates a new instance of the encoding using the given options
    ///
    /// - parameter options: The options used to encode the json. Default is `[]`
    ///
    /// - returns: The new instance
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
              let array = parameters[arrayParametersKey] else {
            return urlRequest
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
//FIXME: - refer upload img
//func uploadPhoto(media: UIImage, params: [String:String], fileName: String){
//    let headers: HTTPHeaders = [
//        "X-csquare-api-key":UserDefaults.standard.value(forKey:ketConstantStr) as! String,
//        "X-csquare-api-token":UserDefaults.standard.value(forKey:tokenConstantStr) as! String,
//        "Content-type": "multipart/form-data"
//    ]
//    AF.upload(
//        multipartFormData: { multipartFormData in
//            multipartFormData.append(media.jpegData(
//                compressionQuality: 0.5)!,
//                withName: "img",
//                fileName: "\(fileName).jpeg", mimeType: "image/jpeg"
//            )
////                for param in params {
////                    let value = param.value.data(using: String.Encoding.utf8)!
////                    multipartFormData.append(value, withName: param.key)
////                }
//        },
//        to:LIVE_ORDER_HOSTURL+IMG_UPLOAD_URL,
//        method: .post ,
//        headers: headers
//    )
//    .responseJSON { responseRes in
//        print(responseRes)
//    }
//}
