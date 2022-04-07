//
//  Data.swift
//
//  Created by Data Prime on 04/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PDPData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let nMaxMrp = "n_mrp"
    static let cItemCode = "c_item_code"
    static let nPackSize = "n_pack_size"
    static let cGst = "c_gst"
    static let cMfgName = "c_mfg_name"
    static let jItemThumbnailImages = "j_item_thumbnail_images"
    static let jMolecules = "j_molecules"
    static let cPackName = "c_pack_name"
    static let cItemName = "c_item_name"
    static let cMfgCode = "c_mfg_code"
    static let cContentName = "c_content_name"
    static let jAlternatives = "j_alternatives"
    static let cWatchlistStatus = "c_watchlist_status"
    static let cHsnCode = "c_hsn_code"
    static let cBarcode = "c_barcode"
    static let cShortbookStatus = "c_shortbook_status"
    static let cDiscountStatus = "c_discount_status"
    static let jItemImages = "j_item_images"
  }

  // MARK: Properties
  public var nMaxMrp: Int?
  public var cItemCode: String?
  public var nPackSize: Int?
  public var cGst: String?
  public var cMfgName: String?
  public var jItemThumbnailImages: [Any]?
  public var jMolecules: [PDPJMolecules]?
  public var cPackName: String?
  public var cItemName: String?
  public var cMfgCode: String?
  public var cContentName: String?
  public var jAlternatives: [Any]?
  public var cWatchlistStatus: String?
  public var cHsnCode: String?
  public var cBarcode: String?
  public var cShortbookStatus: String?
  public var cDiscountStatus: String?
  public var jItemImages: [Any]?

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
    nMaxMrp = json[SerializationKeys.nMaxMrp].int
    cItemCode = json[SerializationKeys.cItemCode].string
    nPackSize = json[SerializationKeys.nPackSize].int
    cGst = json[SerializationKeys.cGst].string
    cMfgName = json[SerializationKeys.cMfgName].string
    if let items = json[SerializationKeys.jItemThumbnailImages].array { jItemThumbnailImages = items.map { $0.object} }
    if let items = json[SerializationKeys.jMolecules].array { jMolecules = items.map { PDPJMolecules(json: $0) } }
    cPackName = json[SerializationKeys.cPackName].string
    cItemName = json[SerializationKeys.cItemName].string
    cMfgCode = json[SerializationKeys.cMfgCode].string
    cContentName = json[SerializationKeys.cContentName].string
    if let items = json[SerializationKeys.jAlternatives].array { jAlternatives = items.map { $0.object} }
    cWatchlistStatus = json[SerializationKeys.cWatchlistStatus].string
    cHsnCode = json[SerializationKeys.cHsnCode].string
    cBarcode = json[SerializationKeys.cBarcode].string
    cShortbookStatus = json[SerializationKeys.cShortbookStatus].string
    cDiscountStatus = json[SerializationKeys.cDiscountStatus].string
    if let items = json[SerializationKeys.jItemImages].array { jItemImages = items.map { $0.object} }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = nMaxMrp { dictionary[SerializationKeys.nMaxMrp] = value }
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = nPackSize { dictionary[SerializationKeys.nPackSize] = value }
    if let value = cGst { dictionary[SerializationKeys.cGst] = value }
    if let value = cMfgName { dictionary[SerializationKeys.cMfgName] = value }
    if let value = jItemThumbnailImages { dictionary[SerializationKeys.jItemThumbnailImages] = value }
    if let value = jMolecules { dictionary[SerializationKeys.jMolecules] = value.map { $0.dictionaryRepresentation() } }
    if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cMfgCode { dictionary[SerializationKeys.cMfgCode] = value }
    if let value = cContentName { dictionary[SerializationKeys.cContentName] = value }
    if let value = jAlternatives { dictionary[SerializationKeys.jAlternatives] = value }
    if let value = cWatchlistStatus { dictionary[SerializationKeys.cWatchlistStatus] = value }
    if let value = cHsnCode { dictionary[SerializationKeys.cHsnCode] = value }
    if let value = cBarcode { dictionary[SerializationKeys.cBarcode] = value }
    if let value = cShortbookStatus { dictionary[SerializationKeys.cShortbookStatus] = value }
    if let value = cDiscountStatus { dictionary[SerializationKeys.cDiscountStatus] = value }
    if let value = jItemImages { dictionary[SerializationKeys.jItemImages] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.nMaxMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMaxMrp) as? Int
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.nPackSize = aDecoder.decodeObject(forKey: SerializationKeys.nPackSize) as? Int
    self.cGst = aDecoder.decodeObject(forKey: SerializationKeys.cGst) as? String
    self.cMfgName = aDecoder.decodeObject(forKey: SerializationKeys.cMfgName) as? String
    self.jItemThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.jItemThumbnailImages) as? [Any]
    self.jMolecules = aDecoder.decodeObject(forKey: SerializationKeys.jMolecules) as? [PDPJMolecules]
    self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cMfgCode = aDecoder.decodeObject(forKey: SerializationKeys.cMfgCode) as? String
    self.cContentName = aDecoder.decodeObject(forKey: SerializationKeys.cContentName) as? String
    self.jAlternatives = aDecoder.decodeObject(forKey: SerializationKeys.jAlternatives) as? [Any]
    self.cWatchlistStatus = aDecoder.decodeObject(forKey: SerializationKeys.cWatchlistStatus) as? String
    self.cHsnCode = aDecoder.decodeObject(forKey: SerializationKeys.cHsnCode) as? String
    self.cBarcode = aDecoder.decodeObject(forKey: SerializationKeys.cBarcode) as? String
    self.cShortbookStatus = aDecoder.decodeObject(forKey: SerializationKeys.cShortbookStatus) as? String
    self.cDiscountStatus = aDecoder.decodeObject(forKey: SerializationKeys.cDiscountStatus) as? String
    self.jItemImages = aDecoder.decodeObject(forKey: SerializationKeys.jItemImages) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(nMaxMrp, forKey: SerializationKeys.nMaxMrp)
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(nPackSize, forKey: SerializationKeys.nPackSize)
    aCoder.encode(cGst, forKey: SerializationKeys.cGst)
    aCoder.encode(cMfgName, forKey: SerializationKeys.cMfgName)
    aCoder.encode(jItemThumbnailImages, forKey: SerializationKeys.jItemThumbnailImages)
    aCoder.encode(jMolecules, forKey: SerializationKeys.jMolecules)
    aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cMfgCode, forKey: SerializationKeys.cMfgCode)
    aCoder.encode(cContentName, forKey: SerializationKeys.cContentName)
    aCoder.encode(jAlternatives, forKey: SerializationKeys.jAlternatives)
    aCoder.encode(cWatchlistStatus, forKey: SerializationKeys.cWatchlistStatus)
    aCoder.encode(cHsnCode, forKey: SerializationKeys.cHsnCode)
    aCoder.encode(cBarcode, forKey: SerializationKeys.cBarcode)
    aCoder.encode(cShortbookStatus, forKey: SerializationKeys.cShortbookStatus)
    aCoder.encode(cDiscountStatus, forKey: SerializationKeys.cDiscountStatus)
    aCoder.encode(jItemImages, forKey: SerializationKeys.jItemImages)
  }

}
