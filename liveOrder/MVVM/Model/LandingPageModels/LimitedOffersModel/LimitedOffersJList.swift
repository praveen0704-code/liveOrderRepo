//
//  JList.swift
//
//  Created by Data Prime on 01/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LimitedOffersJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cItemCode = "c_item_code"
    static let cSellerC2code = "c_seller_c2code"
    static let cOfferImage = "c_offer_image"
    static let cOfferCode = "c_offer_code"
  }

  // MARK: Properties
  public var cItemCode: String?
  public var cSellerC2code: String?
  public var cOfferImage: String?
  public var cOfferCode: String?

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
    cItemCode = json[SerializationKeys.cItemCode].string
    cSellerC2code = json[SerializationKeys.cSellerC2code].string
    cOfferImage = json[SerializationKeys.cOfferImage].string
    cOfferCode = json[SerializationKeys.cOfferCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = cSellerC2code { dictionary[SerializationKeys.cSellerC2code] = value }
    if let value = cOfferImage { dictionary[SerializationKeys.cOfferImage] = value }
    if let value = cOfferCode { dictionary[SerializationKeys.cOfferCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.cSellerC2code = aDecoder.decodeObject(forKey: SerializationKeys.cSellerC2code) as? String
    self.cOfferImage = aDecoder.decodeObject(forKey: SerializationKeys.cOfferImage) as? String
    self.cOfferCode = aDecoder.decodeObject(forKey: SerializationKeys.cOfferCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(cSellerC2code, forKey: SerializationKeys.cSellerC2code)
    aCoder.encode(cOfferImage, forKey: SerializationKeys.cOfferImage)
    aCoder.encode(cOfferCode, forKey: SerializationKeys.cOfferCode)
  }

}
