//
//  PayloadJson.swift
//
//  Created by Data Prime on 24/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RequestOtpPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tokenExpiry = "tokenExpiry"
    static let key = "key"
    static let token = "token"
    static let cUpdateStatus = "c_update_status"
    static let cLcUserStatus = "c_lc_user_status"
    static let cStoreCombineStatus = "c_store_combine_status"
    static let cLcUserActiveStatus = "c_lc_user_active_status"
  }

  // MARK: Properties
  public var tokenExpiry: String?
  public var key: String?
  public var token: String?
  public var cUpdateStatus: String?
  public var cLcUserStatus: String?
  public var cStoreCombineStatus: String?
  public var cLcUserActiveStatus: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    tokenExpiry = json[SerializationKeys.tokenExpiry].string
    key = json[SerializationKeys.key].string
    token = json[SerializationKeys.token].string
    cUpdateStatus = json[SerializationKeys.cUpdateStatus].string
    cLcUserStatus = json[SerializationKeys.cLcUserStatus].string
    cStoreCombineStatus = json[SerializationKeys.cStoreCombineStatus].string
    cLcUserActiveStatus = json[SerializationKeys.cLcUserActiveStatus].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tokenExpiry { dictionary[SerializationKeys.tokenExpiry] = value }
    if let value = key { dictionary[SerializationKeys.key] = value }
    if let value = token { dictionary[SerializationKeys.token] = value }
    if let value = cUpdateStatus { dictionary[SerializationKeys.cUpdateStatus] = value }
    if let value = cLcUserStatus { dictionary[SerializationKeys.cLcUserStatus] = value }
    if let value = cStoreCombineStatus { dictionary[SerializationKeys.cStoreCombineStatus] = value }
    if let value = cLcUserActiveStatus { dictionary[SerializationKeys.cLcUserActiveStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tokenExpiry = aDecoder.decodeObject(forKey: SerializationKeys.tokenExpiry) as? String
    self.key = aDecoder.decodeObject(forKey: SerializationKeys.key) as? String
    self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
    self.cUpdateStatus = aDecoder.decodeObject(forKey: SerializationKeys.cUpdateStatus) as? String
    self.cLcUserStatus = aDecoder.decodeObject(forKey: SerializationKeys.cLcUserStatus) as? String
    self.cStoreCombineStatus = aDecoder.decodeObject(forKey: SerializationKeys.cStoreCombineStatus) as? String
    self.cLcUserActiveStatus = aDecoder.decodeObject(forKey: SerializationKeys.cLcUserActiveStatus) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tokenExpiry, forKey: SerializationKeys.tokenExpiry)
    aCoder.encode(key, forKey: SerializationKeys.key)
    aCoder.encode(token, forKey: SerializationKeys.token)
    aCoder.encode(cUpdateStatus, forKey: SerializationKeys.cUpdateStatus)
    aCoder.encode(cLcUserStatus, forKey: SerializationKeys.cLcUserStatus)
    aCoder.encode(cStoreCombineStatus, forKey: SerializationKeys.cStoreCombineStatus)
    aCoder.encode(cLcUserActiveStatus, forKey: SerializationKeys.cLcUserActiveStatus)
  }

}
