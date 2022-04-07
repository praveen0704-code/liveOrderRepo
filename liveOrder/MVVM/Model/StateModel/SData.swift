//
//  Data.swift
//
//  Created by PraveenMac on 29/09/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cShName = "c_sh_name"
    static let cCode = "c_code"
    static let cName = "c_name"
  }

  // MARK: Properties
  public var cShName: String?
  public var cCode: String?
  public var cName: String?

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
    cShName = json[SerializationKeys.cShName].string
    cCode = json[SerializationKeys.cCode].string
    cName = json[SerializationKeys.cName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cShName { dictionary[SerializationKeys.cShName] = value }
    if let value = cCode { dictionary[SerializationKeys.cCode] = value }
    if let value = cName { dictionary[SerializationKeys.cName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cShName = aDecoder.decodeObject(forKey: SerializationKeys.cShName) as? String
    self.cCode = aDecoder.decodeObject(forKey: SerializationKeys.cCode) as? String
    self.cName = aDecoder.decodeObject(forKey: SerializationKeys.cName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cShName, forKey: SerializationKeys.cShName)
    aCoder.encode(cCode, forKey: SerializationKeys.cCode)
    aCoder.encode(cName, forKey: SerializationKeys.cName)
  }

}
