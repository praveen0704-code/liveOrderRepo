//
//  JList.swift
//
//  Created by Data Prime on 14/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ItemByMolCodeJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cItemCode = "c_item_code"
    static let cBarCode = "c_bar_code"
    static let nPackSize = "n_pack_size"
    static let molecules = "molecules"
    static let cMfgName = "c_mfg_name"
    static let cItemName = "c_item_name"
    static let cPackName = "c_pack_name"
    static let nMrp = "n_mrp"
    static let cMfgCode = "c_mfg_code"
    static let cContains = "c_contains"
    static let cHsnCode = "c_hsn_code"
    static let cGstCode = "c_gst_code"
    static let cWebImgLink = "c_web_img_link"
  }

  // MARK: Properties
  public var cItemCode: String?
  public var cBarCode: String?
  public var nPackSize: Int?
  public var molecules: [ItemByMolCodeMolecules]?
  public var cMfgName: String?
  public var cItemName: String?
  public var cPackName: String?
  public var nMrp: Int?
  public var cMfgCode: String?
  public var cContains: String?
  public var cHsnCode: String?
  public var cGstCode: String?
  public var cWebImgLink: String?

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
    cBarCode = json[SerializationKeys.cBarCode].string
    nPackSize = json[SerializationKeys.nPackSize].int
    if let items = json[SerializationKeys.molecules].array { molecules = items.map { ItemByMolCodeMolecules(json: $0) } }
    cMfgName = json[SerializationKeys.cMfgName].string
    cItemName = json[SerializationKeys.cItemName].string
    cPackName = json[SerializationKeys.cPackName].string
    nMrp = json[SerializationKeys.nMrp].int
    cMfgCode = json[SerializationKeys.cMfgCode].string
    cContains = json[SerializationKeys.cContains].string
    cHsnCode = json[SerializationKeys.cHsnCode].string
    cGstCode = json[SerializationKeys.cGstCode].string
    cWebImgLink = json[SerializationKeys.cWebImgLink].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = cBarCode { dictionary[SerializationKeys.cBarCode] = value }
    if let value = nPackSize { dictionary[SerializationKeys.nPackSize] = value }
    if let value = molecules { dictionary[SerializationKeys.molecules] = value.map { $0.dictionaryRepresentation() } }
    if let value = cMfgName { dictionary[SerializationKeys.cMfgName] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
    if let value = nMrp { dictionary[SerializationKeys.nMrp] = value }
    if let value = cMfgCode { dictionary[SerializationKeys.cMfgCode] = value }
    if let value = cContains { dictionary[SerializationKeys.cContains] = value }
    if let value = cHsnCode { dictionary[SerializationKeys.cHsnCode] = value }
    if let value = cGstCode { dictionary[SerializationKeys.cGstCode] = value }
    if let value = cWebImgLink { dictionary[SerializationKeys.cWebImgLink] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.cBarCode = aDecoder.decodeObject(forKey: SerializationKeys.cBarCode) as? String
    self.nPackSize = aDecoder.decodeObject(forKey: SerializationKeys.nPackSize) as? Int
    self.molecules = aDecoder.decodeObject(forKey: SerializationKeys.molecules) as? [ItemByMolCodeMolecules]
    self.cMfgName = aDecoder.decodeObject(forKey: SerializationKeys.cMfgName) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
    self.nMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMrp) as? Int
    self.cMfgCode = aDecoder.decodeObject(forKey: SerializationKeys.cMfgCode) as? String
    self.cContains = aDecoder.decodeObject(forKey: SerializationKeys.cContains) as? String
    self.cHsnCode = aDecoder.decodeObject(forKey: SerializationKeys.cHsnCode) as? String
    self.cGstCode = aDecoder.decodeObject(forKey: SerializationKeys.cGstCode) as? String
    self.cWebImgLink = aDecoder.decodeObject(forKey: SerializationKeys.cWebImgLink) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(cBarCode, forKey: SerializationKeys.cBarCode)
    aCoder.encode(nPackSize, forKey: SerializationKeys.nPackSize)
    aCoder.encode(molecules, forKey: SerializationKeys.molecules)
    aCoder.encode(cMfgName, forKey: SerializationKeys.cMfgName)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
    aCoder.encode(nMrp, forKey: SerializationKeys.nMrp)
    aCoder.encode(cMfgCode, forKey: SerializationKeys.cMfgCode)
    aCoder.encode(cContains, forKey: SerializationKeys.cContains)
    aCoder.encode(cHsnCode, forKey: SerializationKeys.cHsnCode)
    aCoder.encode(cGstCode, forKey: SerializationKeys.cGstCode)
    aCoder.encode(cWebImgLink, forKey: SerializationKeys.cWebImgLink)
  }

}
