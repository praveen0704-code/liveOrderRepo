//
//  Data.swift
//
//  Created by Data Prime on 27/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SBListData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cItemCode = "c_item_code"
    static let cPack = "c_pack"
      static let cPacktypeName = "c_pack_type_name"
    static let cScheme = "c_scheme"
    static let nGst = "n_gst"
    static let cMfgName = "c_mfg_name"
    static let cItemName = "c_item_name"
    static let cRate = "c_rate"
    static let nMrp = "n_mrp"
    static let cMfgCode = "c_mfg_code"
    static let cSellerName = "c_seller_name"
    static let cSellerCode = "c_seller_code"
    static let cWatchlistStatus = "c_watchlist_status"
    static let cContains = "c_contains"
    static let cImageUrL = "c_image_urL"
    static let cShortbookStatus = "c_shortbook_status"
  }

  // MARK: Properties
  public var cItemCode: String?
  public var cPack: Int?
  public var cPacktypeName :String?
  public var cScheme: String?
  public var nGst: String?
  public var cMfgName: String?
  public var cItemName: String?
  public var cRate: String?
  public var nMrp: Int?
  public var cMfgCode: String?
  public var cSellerName: String?
  public var cSellerCode: String?
  public var cWatchlistStatus: String?
  public var cContains: String?
  public var cImageUrL: String?
  public var cShortbookStatus: String?
    

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
    cPack = json[SerializationKeys.cPack].int
    cPacktypeName = json[SerializationKeys.cPacktypeName].string
    cScheme = json[SerializationKeys.cScheme].string
    nGst = json[SerializationKeys.nGst].string
    cMfgName = json[SerializationKeys.cMfgName].string
    cItemName = json[SerializationKeys.cItemName].string
    cRate = json[SerializationKeys.cRate].string
    nMrp = json[SerializationKeys.nMrp].int
    cMfgCode = json[SerializationKeys.cMfgCode].string
    cSellerName = json[SerializationKeys.cSellerName].string
    cSellerCode = json[SerializationKeys.cSellerCode].string
    cWatchlistStatus = json[SerializationKeys.cWatchlistStatus].string
    cContains = json[SerializationKeys.cContains].string
    cImageUrL = json[SerializationKeys.cImageUrL].string
    cShortbookStatus = json[SerializationKeys.cShortbookStatus].string
      
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = cPack { dictionary[SerializationKeys.cPack] = value }
      if let value = cPacktypeName { dictionary[SerializationKeys.cPacktypeName] = value }
    if let value = cScheme { dictionary[SerializationKeys.cScheme] = value }
    if let value = nGst { dictionary[SerializationKeys.nGst] = value }
    if let value = cMfgName { dictionary[SerializationKeys.cMfgName] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cRate { dictionary[SerializationKeys.cRate] = value }
    if let value = nMrp { dictionary[SerializationKeys.nMrp] = value }
    if let value = cMfgCode { dictionary[SerializationKeys.cMfgCode] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cWatchlistStatus { dictionary[SerializationKeys.cWatchlistStatus] = value }
    if let value = cContains { dictionary[SerializationKeys.cContains] = value }
    if let value = cImageUrL { dictionary[SerializationKeys.cImageUrL] = value }
    if let value = cShortbookStatus { dictionary[SerializationKeys.cShortbookStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.cPack = aDecoder.decodeObject(forKey: SerializationKeys.cPack) as? Int
    self.cPacktypeName = aDecoder.decodeObject(forKey: SerializationKeys.cPacktypeName) as? String
    self.cScheme = aDecoder.decodeObject(forKey: SerializationKeys.cScheme) as? String
    self.nGst = aDecoder.decodeObject(forKey: SerializationKeys.nGst) as? String
    self.cMfgName = aDecoder.decodeObject(forKey: SerializationKeys.cMfgName) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cRate = aDecoder.decodeObject(forKey: SerializationKeys.cRate) as? String
    self.nMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMrp) as? Int
    self.cMfgCode = aDecoder.decodeObject(forKey: SerializationKeys.cMfgCode) as? String
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cWatchlistStatus = aDecoder.decodeObject(forKey: SerializationKeys.cWatchlistStatus) as? String
    self.cContains = aDecoder.decodeObject(forKey: SerializationKeys.cContains) as? String
    self.cImageUrL = aDecoder.decodeObject(forKey: SerializationKeys.cImageUrL) as? String
    self.cShortbookStatus = aDecoder.decodeObject(forKey: SerializationKeys.cShortbookStatus) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(cPack, forKey: SerializationKeys.cPack)
    aCoder.encode(cPacktypeName, forKey: SerializationKeys.cPacktypeName)
    aCoder.encode(cScheme, forKey: SerializationKeys.cScheme)
    aCoder.encode(nGst, forKey: SerializationKeys.nGst)
    aCoder.encode(cMfgName, forKey: SerializationKeys.cMfgName)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cRate, forKey: SerializationKeys.cRate)
    aCoder.encode(nMrp, forKey: SerializationKeys.nMrp)
    aCoder.encode(cMfgCode, forKey: SerializationKeys.cMfgCode)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cWatchlistStatus, forKey: SerializationKeys.cWatchlistStatus)
    aCoder.encode(cContains, forKey: SerializationKeys.cContains)
    aCoder.encode(cImageUrL, forKey: SerializationKeys.cImageUrL)
    aCoder.encode(cShortbookStatus, forKey: SerializationKeys.cShortbookStatus)
  }

}
