//
//  JList.swift
//
//  Created by PraveenMac on 09/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SellerDDDataJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cSellerCode = "c_seller_code"
    static let cSellerCity = "c_seller_city"
    static let cSponsored = "c_sponsored"
    static let nSchemes = "n_schemes"
    static let cSellerName = "c_seller_name"
  }

  // MARK: Properties
  public var cSellerCode: String?
  public var cSellerCity: String?
  public var cSponsored: String?
  public var nSchemes: Int?
  public var cSellerName: String?

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
    cSellerCity = json[SerializationKeys.cSellerCity].string
    cSponsored = json[SerializationKeys.cSponsored].string
    nSchemes = json[SerializationKeys.nSchemes].int
    cSellerName = json[SerializationKeys.cSellerName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cSellerCity { dictionary[SerializationKeys.cSellerCity] = value }
    if let value = cSponsored { dictionary[SerializationKeys.cSponsored] = value }
    if let value = nSchemes { dictionary[SerializationKeys.nSchemes] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cSellerCity = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCity) as? String
    self.cSponsored = aDecoder.decodeObject(forKey: SerializationKeys.cSponsored) as? String
    self.nSchemes = aDecoder.decodeObject(forKey: SerializationKeys.nSchemes) as? Int
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cSellerCity, forKey: SerializationKeys.cSellerCity)
    aCoder.encode(cSponsored, forKey: SerializationKeys.cSponsored)
    aCoder.encode(nSchemes, forKey: SerializationKeys.nSchemes)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
  }

}
