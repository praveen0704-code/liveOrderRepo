//
//  JItems.swift
//
//  Created by PraveenMac on 09/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CartListJItems: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let acThumbnailImages = "ac_thumbnail_images"
      static let cItemCode = "c_item_code"
      static let nPackSize = "n_pack_size"
      static let cCombineCode = "c_combine_code"
      static let nGstAmount = "n_gst_amount"
      static let cItemName = "c_item_name"
      static let cPackName = "c_pack_name"
      static let nDiscountAmount = "n_discount_amount"
      static let cnMrp = "n_mrp"
      static let cSchemeQty = "c_scheme_qty"
      static let nDiscountPercentage = "n_discount_percentage"
      static let cSellerItemCode = "c_seller_item_code"
      static let nQty = "n_qty"
      static let nTotal = "n_total"
      static let cSaleRate = "c_sale_rate"
      static let cGstCode = "c_gst_code"
      static let cContainName = "c_contain_name"
    }

    // MARK: Properties
    public var acThumbnailImages: String?
    public var cItemCode: String?
    public var nPackSize: Int?
    public var cCombineCode: String?
    public var nGstAmount: Float?
    public var cItemName: String?
    public var cPackName: String?
    public var nDiscountAmount: Int?
    public var cnMrp: Float?
    public var cSchemeQty: String?
    public var nDiscountPercentage: Int?
    public var cSellerItemCode: String?
    public var nQty: Int?
    public var nTotal: Float?
    public var cSaleRate: Float?
    public var cGstCode: String?
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
      acThumbnailImages = json[SerializationKeys.acThumbnailImages].string
      cItemCode = json[SerializationKeys.cItemCode].string
      nPackSize = json[SerializationKeys.nPackSize].int
      cCombineCode = json[SerializationKeys.cCombineCode].string
      nGstAmount = json[SerializationKeys.nGstAmount].float
      cItemName = json[SerializationKeys.cItemName].string
      cPackName = json[SerializationKeys.cPackName].string
      nDiscountAmount = json[SerializationKeys.nDiscountAmount].int
      cnMrp = json[SerializationKeys.cnMrp].float
      cSchemeQty = json[SerializationKeys.cSchemeQty].string
      nDiscountPercentage = json[SerializationKeys.nDiscountPercentage].int
      cSellerItemCode = json[SerializationKeys.cSellerItemCode].string
      nQty = json[SerializationKeys.nQty].int
      nTotal = json[SerializationKeys.nTotal].float
      cSaleRate = json[SerializationKeys.cSaleRate].float
      cGstCode = json[SerializationKeys.cGstCode].string
      cContainName = json[SerializationKeys.cContainName].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value }
      if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
      if let value = nPackSize { dictionary[SerializationKeys.nPackSize] = value }
      if let value = cCombineCode { dictionary[SerializationKeys.cCombineCode] = value }
      if let value = nGstAmount { dictionary[SerializationKeys.nGstAmount] = value }
      if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
      if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
      if let value = nDiscountAmount { dictionary[SerializationKeys.nDiscountAmount] = value }
      if let value = cnMrp { dictionary[SerializationKeys.cnMrp] = value }
      if let value = cSchemeQty { dictionary[SerializationKeys.cSchemeQty] = value }
      if let value = nDiscountPercentage { dictionary[SerializationKeys.nDiscountPercentage] = value }
      if let value = cSellerItemCode { dictionary[SerializationKeys.cSellerItemCode] = value }
      if let value = nQty { dictionary[SerializationKeys.nQty] = value }
      if let value = nTotal { dictionary[SerializationKeys.nTotal] = value }
      if let value = cSaleRate { dictionary[SerializationKeys.cSaleRate] = value }
      if let value = cGstCode { dictionary[SerializationKeys.cGstCode] = value }
      if let value = cContainName { dictionary[SerializationKeys.cContainName] = value }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? String
      self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
      self.nPackSize = aDecoder.decodeObject(forKey: SerializationKeys.nPackSize) as? Int
      self.cCombineCode = aDecoder.decodeObject(forKey: SerializationKeys.cCombineCode) as? String
      self.nGstAmount = aDecoder.decodeObject(forKey: SerializationKeys.nGstAmount) as? Float
      self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
      self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
      self.nDiscountAmount = aDecoder.decodeObject(forKey: SerializationKeys.nDiscountAmount) as? Int
      self.cnMrp = aDecoder.decodeObject(forKey: SerializationKeys.cnMrp) as? Float
      self.cSchemeQty = aDecoder.decodeObject(forKey: SerializationKeys.cSchemeQty) as? String
      self.nDiscountPercentage = aDecoder.decodeObject(forKey: SerializationKeys.nDiscountPercentage) as? Int
      self.cSellerItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerItemCode) as? String
      self.nQty = aDecoder.decodeObject(forKey: SerializationKeys.nQty) as? Int
      self.nTotal = aDecoder.decodeObject(forKey: SerializationKeys.nTotal) as? Float
      self.cSaleRate = aDecoder.decodeObject(forKey: SerializationKeys.cSaleRate) as? Float
      self.cGstCode = aDecoder.decodeObject(forKey: SerializationKeys.cGstCode) as? String
      self.cContainName = aDecoder.decodeObject(forKey: SerializationKeys.cContainName) as? String
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
      aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
      aCoder.encode(nPackSize, forKey: SerializationKeys.nPackSize)
      aCoder.encode(cCombineCode, forKey: SerializationKeys.cCombineCode)
      aCoder.encode(nGstAmount, forKey: SerializationKeys.nGstAmount)
      aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
      aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
      aCoder.encode(nDiscountAmount, forKey: SerializationKeys.nDiscountAmount)
      aCoder.encode(cnMrp, forKey: SerializationKeys.cnMrp)
      aCoder.encode(cSchemeQty, forKey: SerializationKeys.cSchemeQty)
      aCoder.encode(nDiscountPercentage, forKey: SerializationKeys.nDiscountPercentage)
      aCoder.encode(cSellerItemCode, forKey: SerializationKeys.cSellerItemCode)
      aCoder.encode(nQty, forKey: SerializationKeys.nQty)
      aCoder.encode(nTotal, forKey: SerializationKeys.nTotal)
      aCoder.encode(cSaleRate, forKey: SerializationKeys.cSaleRate)
      aCoder.encode(cGstCode, forKey: SerializationKeys.cGstCode)
      aCoder.encode(cContainName, forKey: SerializationKeys.cContainName)
    }


}
