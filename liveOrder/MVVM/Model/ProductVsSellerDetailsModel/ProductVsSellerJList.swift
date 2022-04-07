//
//  JList.swift
//
//  Created by PraveenMac on 27/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductVsSellerJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let acThumbnailImages = "ac_thumbnail_images"
    static let cItemCode = "c_item_code"
    static let cCartCode = "c_cart_code"
    static let cItemName = "c_item_name"
    static let cPackName = "c_pack_name"
    static let nSellerRate = "n_seller_rate"
    static let cOfferStatus = "c_offer_status"
    static let cBuyerCode = "c_buyer_code"
    static let cSellerName = "c_seller_name"
    static let nMrp = "n_mrp"
    static let cSellerCode = "c_seller_code"
    static let cContains = "c_contains"
    static let nSellerStock = "n_seller_stock"
    static let cSellerItemCode = "c_seller_item_code"
    static let cCartStatus = "c_cart_status"
    static let nQty = "n_qty"
    static let cSchemes = "c_schemes"
    static let sellerPriorityStatus = "seller_priority_status"
  }

  // MARK: Properties
  public var acThumbnailImages: [ProductVsSellerAcThumbnailImages]?
  public var cItemCode: String?
  public var cCartCode: String?
  public var cItemName: String?
  public var cPackName: String?
  public var nSellerRate: Float?
  public var cOfferStatus: String?
  public var cBuyerCode: String?
  public var cSellerName: String?
  public var nMrp: Float?
  public var cSellerCode: String?
  public var cContains: String?
  public var nSellerStock: Int?
  public var cSellerItemCode: String?
  public var cCartStatus: String?
  public var nQty: Int?
  public var cSchemes: String?
  public var sellerPriorityStatus: String?

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
    if let items = json[SerializationKeys.acThumbnailImages].array { acThumbnailImages = items.map { ProductVsSellerAcThumbnailImages(json: $0) } }
    cItemCode = json[SerializationKeys.cItemCode].string
    cCartCode = json[SerializationKeys.cCartCode].string
    cItemName = json[SerializationKeys.cItemName].string
    cPackName = json[SerializationKeys.cPackName].string
    nSellerRate = json[SerializationKeys.nSellerRate].float
    cOfferStatus = json[SerializationKeys.cOfferStatus].string
    cBuyerCode = json[SerializationKeys.cBuyerCode].string
    cSellerName = json[SerializationKeys.cSellerName].string
    nMrp = json[SerializationKeys.nMrp].float
    cSellerCode = json[SerializationKeys.cSellerCode].string
    cContains = json[SerializationKeys.cContains].string
    nSellerStock = json[SerializationKeys.nSellerStock].int
    cSellerItemCode = json[SerializationKeys.cSellerItemCode].string
    cCartStatus = json[SerializationKeys.cCartStatus].string
    nQty = json[SerializationKeys.nQty].int
    cSchemes = json[SerializationKeys.cSchemes].string
    sellerPriorityStatus = json[SerializationKeys.sellerPriorityStatus].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value.map { $0.dictionaryRepresentation() } }
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    if let value = cCartCode { dictionary[SerializationKeys.cCartCode] = value }
    if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
    if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
    if let value = nSellerRate { dictionary[SerializationKeys.nSellerRate] = value }
    if let value = cOfferStatus { dictionary[SerializationKeys.cOfferStatus] = value }
    if let value = cBuyerCode { dictionary[SerializationKeys.cBuyerCode] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    if let value = nMrp { dictionary[SerializationKeys.nMrp] = value }
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cContains { dictionary[SerializationKeys.cContains] = value }
    if let value = nSellerStock { dictionary[SerializationKeys.nSellerStock] = value }
    if let value = cSellerItemCode { dictionary[SerializationKeys.cSellerItemCode] = value }
    if let value = cCartStatus { dictionary[SerializationKeys.cCartStatus] = value }
    if let value = nQty { dictionary[SerializationKeys.nQty] = value }
    if let value = cSchemes { dictionary[SerializationKeys.cSchemes] = value }
    if let value = sellerPriorityStatus { dictionary[SerializationKeys.sellerPriorityStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? [ProductVsSellerAcThumbnailImages]
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
    self.cCartCode = aDecoder.decodeObject(forKey: SerializationKeys.cCartCode) as? String
    self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
    self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
    self.nSellerRate = aDecoder.decodeObject(forKey: SerializationKeys.nSellerRate) as? Float
    self.cOfferStatus = aDecoder.decodeObject(forKey: SerializationKeys.cOfferStatus) as? String
    self.cBuyerCode = aDecoder.decodeObject(forKey: SerializationKeys.cBuyerCode) as? String
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    self.nMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMrp) as? Float
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cContains = aDecoder.decodeObject(forKey: SerializationKeys.cContains) as? String
    self.nSellerStock = aDecoder.decodeObject(forKey: SerializationKeys.nSellerStock) as? Int
    self.cSellerItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerItemCode) as? String
    self.cCartStatus = aDecoder.decodeObject(forKey: SerializationKeys.cCartStatus) as? String
    self.nQty = aDecoder.decodeObject(forKey: SerializationKeys.nQty) as? Int
    self.cSchemes = aDecoder.decodeObject(forKey: SerializationKeys.cSchemes) as? String
    self.sellerPriorityStatus = aDecoder.decodeObject(forKey: SerializationKeys.sellerPriorityStatus) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
    aCoder.encode(cCartCode, forKey: SerializationKeys.cCartCode)
    aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
    aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
    aCoder.encode(nSellerRate, forKey: SerializationKeys.nSellerRate)
    aCoder.encode(cOfferStatus, forKey: SerializationKeys.cOfferStatus)
    aCoder.encode(cBuyerCode, forKey: SerializationKeys.cBuyerCode)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    aCoder.encode(nMrp, forKey: SerializationKeys.nMrp)
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cContains, forKey: SerializationKeys.cContains)
    aCoder.encode(nSellerStock, forKey: SerializationKeys.nSellerStock)
    aCoder.encode(cSellerItemCode, forKey: SerializationKeys.cSellerItemCode)
    aCoder.encode(cCartStatus, forKey: SerializationKeys.cCartStatus)
    aCoder.encode(nQty, forKey: SerializationKeys.nQty)
    aCoder.encode(cSchemes, forKey: SerializationKeys.cSchemes)
    aCoder.encode(sellerPriorityStatus, forKey: SerializationKeys.sellerPriorityStatus)
  }

}
