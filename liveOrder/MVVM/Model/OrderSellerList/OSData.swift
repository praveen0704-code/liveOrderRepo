//
//  Data.swift
//
//  Created by PraveenMac on 29/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class OSData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cSellerCode = "c_seller_code"
    static let cAreaCode = "c_area_code"
    static let cCityName = "c_city_name"
    static let cStateName = "c_state_name"
    static let cSellerName = "c_seller_name"
    static let cAreaName = "c_area_name"
    static let nSellerRate = "n_seller_rate"
      static let nSellerStock = "n_seller_stock"
  }

  // MARK: Properties
  public var cSellerCode: String?
  public var cAreaCode: String?
  public var cCityName: String?
  public var cStateName: String?
  public var cSellerName: String?
  public var cAreaName: String?
  public var nSellerRate: Float?
  public var nSellerStock: Int?

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
    cSellerCode = json[SerializationKeys.cSellerCode].string
    cAreaCode = json[SerializationKeys.cAreaCode].string
    cCityName = json[SerializationKeys.cCityName].string
    cStateName = json[SerializationKeys.cStateName].string
    cSellerName = json[SerializationKeys.cSellerName].string
    cAreaName = json[SerializationKeys.cAreaName].string
      nSellerRate = json[SerializationKeys.nSellerRate].float
      nSellerStock = json[SerializationKeys.nSellerStock].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cAreaCode { dictionary[SerializationKeys.cAreaCode] = value }
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
      if let value = nSellerRate { dictionary[SerializationKeys.nSellerRate] = value }
      if let value = nSellerStock { dictionary[SerializationKeys.nSellerStock] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cAreaCode = aDecoder.decodeObject(forKey: SerializationKeys.cAreaCode) as? String
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
      self.nSellerRate = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? Float
      self.nSellerStock = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cAreaCode, forKey: SerializationKeys.cAreaCode)
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
      aCoder.encode(nSellerRate, forKey: SerializationKeys.nSellerRate)
      aCoder.encode(nSellerStock, forKey: SerializationKeys.nSellerStock)
  }

}
