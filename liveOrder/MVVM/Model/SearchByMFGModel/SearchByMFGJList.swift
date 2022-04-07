//
//  JList.swift
//
//  Created by Data Prime on 09/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SearchByMFGJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cManufactureCode = "c_manufacture_code"
    static let cManufactureName = "c_manufacture_name"
    static let nOffers = "n_offers"
    static let cSponsored = "c_sponsored"
  }

  // MARK: Properties
  public var cManufactureCode: String?
  public var cManufactureName: String?
  public var nOffers: Int?
  public var cSponsored: String?

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
    cManufactureCode = json[SerializationKeys.cManufactureCode].string
    cManufactureName = json[SerializationKeys.cManufactureName].string
    nOffers = json[SerializationKeys.nOffers].int
    cSponsored = json[SerializationKeys.cSponsored].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cManufactureCode { dictionary[SerializationKeys.cManufactureCode] = value }
    if let value = cManufactureName { dictionary[SerializationKeys.cManufactureName] = value }
    if let value = nOffers { dictionary[SerializationKeys.nOffers] = value }
    if let value = cSponsored { dictionary[SerializationKeys.cSponsored] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cManufactureCode = aDecoder.decodeObject(forKey: SerializationKeys.cManufactureCode) as? String
    self.cManufactureName = aDecoder.decodeObject(forKey: SerializationKeys.cManufactureName) as? String
    self.nOffers = aDecoder.decodeObject(forKey: SerializationKeys.nOffers) as? Int
    self.cSponsored = aDecoder.decodeObject(forKey: SerializationKeys.cSponsored) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cManufactureCode, forKey: SerializationKeys.cManufactureCode)
    aCoder.encode(cManufactureName, forKey: SerializationKeys.cManufactureName)
    aCoder.encode(nOffers, forKey: SerializationKeys.nOffers)
    aCoder.encode(cSponsored, forKey: SerializationKeys.cSponsored)
  }

}
