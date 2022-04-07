//
//  Items.swift
//
//  Created by PraveenMac on 27/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BranchListItems: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cCityName = "c_city_name"
    static let cBrName = "c_br_name"
    static let cBrCode = "c_br_code"
    static let cDefaultStatus = "c_default_status"
    static let cPincode = "c_pincode"
  }

  // MARK: Properties
  public var cCityName: String?
  public var cBrName: String?
  public var cBrCode: String?
  public var cDefaultStatus: String?
  public var cPincode: String?

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
    cCityName = json[SerializationKeys.cCityName].string
    cBrName = json[SerializationKeys.cBrName].string
    cBrCode = json[SerializationKeys.cBrCode].string
    cDefaultStatus = json[SerializationKeys.cDefaultStatus].string
    cPincode = json[SerializationKeys.cPincode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cBrName { dictionary[SerializationKeys.cBrName] = value }
    if let value = cBrCode { dictionary[SerializationKeys.cBrCode] = value }
    if let value = cDefaultStatus { dictionary[SerializationKeys.cDefaultStatus] = value }
    if let value = cPincode { dictionary[SerializationKeys.cPincode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cBrName = aDecoder.decodeObject(forKey: SerializationKeys.cBrName) as? String
    self.cBrCode = aDecoder.decodeObject(forKey: SerializationKeys.cBrCode) as? String
    self.cDefaultStatus = aDecoder.decodeObject(forKey: SerializationKeys.cDefaultStatus) as? String
    self.cPincode = aDecoder.decodeObject(forKey: SerializationKeys.cPincode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cBrName, forKey: SerializationKeys.cBrName)
    aCoder.encode(cBrCode, forKey: SerializationKeys.cBrCode)
    aCoder.encode(cDefaultStatus, forKey: SerializationKeys.cDefaultStatus)
    aCoder.encode(cPincode, forKey: SerializationKeys.cPincode)
  }

}
