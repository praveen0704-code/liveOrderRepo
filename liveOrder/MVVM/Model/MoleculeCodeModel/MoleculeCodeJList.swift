//
//  JList.swift
//
//  Created by Data Prime on 12/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MoleculeCodeJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let acThumbnailImages = "ac_thumbnail_images"
    static let cItemCode = "c_item_code"
    static let nPackSize = "n_pack_size"
    static let molecules = "molecules"
    static let cHsnCode = "c_hsn_code"
    static let cMfgName = "c_mfg_name"
    static let cGstCode = "c_gst_code"
    static let cItemName = "c_item_name"
    static let cPackName = "c_pack_name"
    static let nMrp = "n_mrp"
    static let cMfgCode = "c_mfg_code"
    static let cContainName = "c_contain_name"
  }

  // MARK: Properties
  public var acThumbnailImages: [MoleculeCodeAcThumbnailImages]?
  public var cItemCode: String?
  public var nPackSize: Int?
  public var molecules: [MoleculeCodeMolecules]?
  public var cHsnCode: String?
  public var cMfgName: String?
  public var cGstCode: String?
  public var cItemName: String?
  public var cPackName: String?
  public var nMrp: Float?
  public var cMfgCode: String?
  public var cContainName: String?

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
    if let items = json[SerializationKeys.acThumbnailImages].array { acThumbnailImages = items.map { MoleculeCodeAcThumbnailImages(json: $0) } }
    cItemCode = json[SerializationKeys.cItemCode].string
    nPackSize = json[SerializationKeys.nPackSize].int
    if let items = json[SerializationKeys.molecules].array { molecules = items.map { MoleculeCodeMolecules(json: $0) } }
    cHsnCode = json[SerializationKeys.cHsnCode].string
    cMfgName = json[SerializationKeys.cMfgName].string
    cGstCode = json[SerializationKeys.cGstCode].string
    cItemName = json[SerializationKeys.cItemName].string
    cPackName = json[SerializationKeys.cPackName].string
    nMrp = json[SerializationKeys.nMrp].float
    cMfgCode = json[SerializationKeys.cMfgCode].string
    cContainName = json[SerializationKeys.cContainName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value.map { $0.dictionaryRepresentation() } }
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = nPackSize { dictionary[SerializationKeys.nPackSize] = value }
    if let value = molecules { dictionary[SerializationKeys.molecules] = value.map { $0.dictionaryRepresentation() } }
    if let value = cHsnCode { dictionary[SerializationKeys.cHsnCode] = value }
    if let value = cMfgName { dictionary[SerializationKeys.cMfgName] = value }
    if let value = cGstCode { dictionary[SerializationKeys.cGstCode] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
    if let value = nMrp { dictionary[SerializationKeys.nMrp] = value }
    if let value = cMfgCode { dictionary[SerializationKeys.cMfgCode] = value }
    if let value = cContainName { dictionary[SerializationKeys.cContainName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? [MoleculeCodeAcThumbnailImages]
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.nPackSize = aDecoder.decodeObject(forKey: SerializationKeys.nPackSize) as? Int
    self.molecules = aDecoder.decodeObject(forKey: SerializationKeys.molecules) as? [MoleculeCodeMolecules]
    self.cHsnCode = aDecoder.decodeObject(forKey: SerializationKeys.cHsnCode) as? String
    self.cMfgName = aDecoder.decodeObject(forKey: SerializationKeys.cMfgName) as? String
    self.cGstCode = aDecoder.decodeObject(forKey: SerializationKeys.cGstCode) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
    self.nMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMrp) as? Float
    self.cMfgCode = aDecoder.decodeObject(forKey: SerializationKeys.cMfgCode) as? String
    self.cContainName = aDecoder.decodeObject(forKey: SerializationKeys.cContainName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(nPackSize, forKey: SerializationKeys.nPackSize)
    aCoder.encode(molecules, forKey: SerializationKeys.molecules)
    aCoder.encode(cHsnCode, forKey: SerializationKeys.cHsnCode)
    aCoder.encode(cMfgName, forKey: SerializationKeys.cMfgName)
    aCoder.encode(cGstCode, forKey: SerializationKeys.cGstCode)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
    aCoder.encode(nMrp, forKey: SerializationKeys.nMrp)
    aCoder.encode(cMfgCode, forKey: SerializationKeys.cMfgCode)
    aCoder.encode(cContainName, forKey: SerializationKeys.cContainName)
  }

}
