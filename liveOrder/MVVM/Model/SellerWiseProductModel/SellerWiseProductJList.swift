//
//  JList.swift
//
//  Created by Data Prime on 22/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SellerWiseProductJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let acThumbnailImages = "ac_thumbnail_images"
    static let nMaxMrp = "n_mrp"
    static let cItemCode = "c_item_code"
    static let cItemMfgName = "c_item_mfg_name"
    static let cShortBookStatus = "c_short_book_status"
    static let cItemName = "c_item_name"
    static let cPackName = "c_pack_name"
    static let cWatchlistStatus = "c_watchlist_status"
    static let cItemMfgCode = "c_item_mfg_code"
    static let cSponsored = "c_sponsored"
    static let cCartStatus = "c_cart_status"
    static let cDiscountStatus = "c_discount_status"
    static let cContainName = "c_contain_name"
    static let cVariantCount = "c_variant_count"
  }

  // MARK: Properties
  public var acThumbnailImages: String?
  public var nMaxMrp: String?
  public var cItemCode: String?
  public var cItemMfgName: String?
  public var cShortBookStatus: String?
  public var cItemName: String?
  public var cPackName: String?
  public var cWatchlistStatus: String?
  public var cItemMfgCode: String?
  public var cSponsored: String?
  public var cCartStatus: String?
  public var cDiscountStatus: String?
  public var cContainName: String?
  public var cVariantCount: String?

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
    acThumbnailImages = json[SerializationKeys.acThumbnailImages].string
    nMaxMrp = json[SerializationKeys.nMaxMrp].string
    cItemCode = json[SerializationKeys.cItemCode].string
    cItemMfgName = json[SerializationKeys.cItemMfgName].string
    cShortBookStatus = json[SerializationKeys.cShortBookStatus].string
    cItemName = json[SerializationKeys.cItemName].string
    cPackName = json[SerializationKeys.cPackName].string
    cWatchlistStatus = json[SerializationKeys.cWatchlistStatus].string
    cItemMfgCode = json[SerializationKeys.cItemMfgCode].string
    cSponsored = json[SerializationKeys.cSponsored].string
    cCartStatus = json[SerializationKeys.cCartStatus].string
    cDiscountStatus = json[SerializationKeys.cDiscountStatus].string
    cContainName = json[SerializationKeys.cContainName].string
    cVariantCount = json[SerializationKeys.cVariantCount].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value }
    if let value = nMaxMrp { dictionary[SerializationKeys.nMaxMrp] = value }
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = cItemMfgName { dictionary[SerializationKeys.cItemMfgName] = value }
    if let value = cShortBookStatus { dictionary[SerializationKeys.cShortBookStatus] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
    if let value = cWatchlistStatus { dictionary[SerializationKeys.cWatchlistStatus] = value }
    if let value = cItemMfgCode { dictionary[SerializationKeys.cItemMfgCode] = value }
    if let value = cSponsored { dictionary[SerializationKeys.cSponsored] = value }
    if let value = cCartStatus { dictionary[SerializationKeys.cCartStatus] = value }
    if let value = cDiscountStatus { dictionary[SerializationKeys.cDiscountStatus] = value }
    if let value = cContainName { dictionary[SerializationKeys.cContainName] = value }
    if let value = cVariantCount { dictionary[SerializationKeys.cVariantCount] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? String
    self.nMaxMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMaxMrp) as? String
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.cItemMfgName = aDecoder.decodeObject(forKey: SerializationKeys.cItemMfgName) as? String
    self.cShortBookStatus = aDecoder.decodeObject(forKey: SerializationKeys.cShortBookStatus) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
    self.cWatchlistStatus = aDecoder.decodeObject(forKey: SerializationKeys.cWatchlistStatus) as? String
    self.cItemMfgCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemMfgCode) as? String
    self.cSponsored = aDecoder.decodeObject(forKey: SerializationKeys.cSponsored) as? String
    self.cCartStatus = aDecoder.decodeObject(forKey: SerializationKeys.cCartStatus) as? String
    self.cDiscountStatus = aDecoder.decodeObject(forKey: SerializationKeys.cDiscountStatus) as? String
    self.cContainName = aDecoder.decodeObject(forKey: SerializationKeys.cContainName) as? String
    self.cVariantCount = aDecoder.decodeObject(forKey: SerializationKeys.cVariantCount) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
    aCoder.encode(nMaxMrp, forKey: SerializationKeys.nMaxMrp)
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(cItemMfgName, forKey: SerializationKeys.cItemMfgName)
    aCoder.encode(cShortBookStatus, forKey: SerializationKeys.cShortBookStatus)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
    aCoder.encode(cWatchlistStatus, forKey: SerializationKeys.cWatchlistStatus)
    aCoder.encode(cItemMfgCode, forKey: SerializationKeys.cItemMfgCode)
    aCoder.encode(cSponsored, forKey: SerializationKeys.cSponsored)
    aCoder.encode(cCartStatus, forKey: SerializationKeys.cCartStatus)
    aCoder.encode(cDiscountStatus, forKey: SerializationKeys.cDiscountStatus)
    aCoder.encode(cContainName, forKey: SerializationKeys.cContainName)
    aCoder.encode(cVariantCount, forKey: SerializationKeys.cVariantCount)
  }

}
