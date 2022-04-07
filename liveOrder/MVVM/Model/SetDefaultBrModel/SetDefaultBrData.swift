//
//  Data.swift
//
//  Created by Data Prime on 23/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SetDefaultBrData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let key = "key"
    static let token = "token"
    static let tokenExpiry = "tokenExpiry"
  }

  // MARK: Properties
  public var key: String?
  public var token: String?
  public var tokenExpiry: String?

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
    key = json[SerializationKeys.key].string
    token = json[SerializationKeys.token].string
    tokenExpiry = json[SerializationKeys.tokenExpiry].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = key { dictionary[SerializationKeys.key] = value }
    if let value = token { dictionary[SerializationKeys.token] = value }
    if let value = tokenExpiry { dictionary[SerializationKeys.tokenExpiry] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.key = aDecoder.decodeObject(forKey: SerializationKeys.key) as? String
    self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
    self.tokenExpiry = aDecoder.decodeObject(forKey: SerializationKeys.tokenExpiry) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(key, forKey: SerializationKeys.key)
    aCoder.encode(token, forKey: SerializationKeys.token)
    aCoder.encode(tokenExpiry, forKey: SerializationKeys.tokenExpiry)
  }

}
