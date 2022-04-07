//
//  JRegister.swift
//
//  Created by PraveenMac on 19/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ComJRegister: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tokenExpiry = "tokenExpiry"
    static let key = "key"
    static let cType = "cType"
    static let token = "token"
  }

  // MARK: Properties
  public var tokenExpiry: String?
  public var key: String?
  public var cType: String?
  public var token: String?

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
    cType = json[SerializationKeys.cType].string
    token = json[SerializationKeys.token].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tokenExpiry { dictionary[SerializationKeys.tokenExpiry] = value }
    if let value = key { dictionary[SerializationKeys.key] = value }
    if let value = cType { dictionary[SerializationKeys.cType] = value }
    if let value = token { dictionary[SerializationKeys.token] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tokenExpiry = aDecoder.decodeObject(forKey: SerializationKeys.tokenExpiry) as? String
    self.key = aDecoder.decodeObject(forKey: SerializationKeys.key) as? String
    self.cType = aDecoder.decodeObject(forKey: SerializationKeys.cType) as? String
    self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tokenExpiry, forKey: SerializationKeys.tokenExpiry)
    aCoder.encode(key, forKey: SerializationKeys.key)
    aCoder.encode(cType, forKey: SerializationKeys.cType)
    aCoder.encode(token, forKey: SerializationKeys.token)
  }

}
