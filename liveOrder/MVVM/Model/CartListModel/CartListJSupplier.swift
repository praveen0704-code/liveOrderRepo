//
//  JSupplier.swift
//
//  Created by PraveenMac on 09/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CartListJSupplier: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let cSellerCode = "c_seller_code"
      static let nSellerGstAmount = "n_seller_gst_amount"
      static let nSellerCartCount = "n_seller_cart_count"
      static let nSellerDiscountAmount = "n_seller_discount_amount"
      static let jItems = "j_items"
      static let nSellerItemAmount = "n_seller_item_amount"
      static let cBuyerCode = "c_buyer_code"
      static let cSellerName = "c_seller_name"
      static let nSellerNetAmount = "n_seller_net_amount"
    }

    // MARK: Properties
    public var cSellerCode: String?
    public var nSellerGstAmount: Float?
    public var nSellerCartCount: Int?
    public var nSellerDiscountAmount: Int?
    public var jItems: [CartListJItems]?
    public var nSellerItemAmount: Int?
    public var cBuyerCode: String?
    public var cSellerName: String?
    public var nSellerNetAmount: Float?

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
      nSellerGstAmount = json[SerializationKeys.nSellerGstAmount].float
      nSellerCartCount = json[SerializationKeys.nSellerCartCount].int
      nSellerDiscountAmount = json[SerializationKeys.nSellerDiscountAmount].int
      if let items = json[SerializationKeys.jItems].array { jItems = items.map { CartListJItems(json: $0) } }
      nSellerItemAmount = json[SerializationKeys.nSellerItemAmount].int
      cBuyerCode = json[SerializationKeys.cBuyerCode].string
      cSellerName = json[SerializationKeys.cSellerName].string
      nSellerNetAmount = json[SerializationKeys.nSellerNetAmount].float
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
      if let value = nSellerGstAmount { dictionary[SerializationKeys.nSellerGstAmount] = value }
      if let value = nSellerCartCount { dictionary[SerializationKeys.nSellerCartCount] = value }
      if let value = nSellerDiscountAmount { dictionary[SerializationKeys.nSellerDiscountAmount] = value }
      if let value = jItems { dictionary[SerializationKeys.jItems] = value.map { $0.dictionaryRepresentation() } }
      if let value = nSellerItemAmount { dictionary[SerializationKeys.nSellerItemAmount] = value }
      if let value = cBuyerCode { dictionary[SerializationKeys.cBuyerCode] = value }
      if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
      if let value = nSellerNetAmount { dictionary[SerializationKeys.nSellerNetAmount] = value }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
      self.nSellerGstAmount = aDecoder.decodeObject(forKey: SerializationKeys.nSellerGstAmount) as? Float
      self.nSellerCartCount = aDecoder.decodeObject(forKey: SerializationKeys.nSellerCartCount) as? Int
      self.nSellerDiscountAmount = aDecoder.decodeObject(forKey: SerializationKeys.nSellerDiscountAmount) as? Int
      self.jItems = aDecoder.decodeObject(forKey: SerializationKeys.jItems) as? [CartListJItems]
      self.nSellerItemAmount = aDecoder.decodeObject(forKey: SerializationKeys.nSellerItemAmount) as? Int
      self.cBuyerCode = aDecoder.decodeObject(forKey: SerializationKeys.cBuyerCode) as? String
      self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
      self.nSellerNetAmount = aDecoder.decodeObject(forKey: SerializationKeys.nSellerNetAmount) as? Float
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
      aCoder.encode(nSellerGstAmount, forKey: SerializationKeys.nSellerGstAmount)
      aCoder.encode(nSellerCartCount, forKey: SerializationKeys.nSellerCartCount)
      aCoder.encode(nSellerDiscountAmount, forKey: SerializationKeys.nSellerDiscountAmount)
      aCoder.encode(jItems, forKey: SerializationKeys.jItems)
      aCoder.encode(nSellerItemAmount, forKey: SerializationKeys.nSellerItemAmount)
      aCoder.encode(cBuyerCode, forKey: SerializationKeys.cBuyerCode)
      aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
      aCoder.encode(nSellerNetAmount, forKey: SerializationKeys.nSellerNetAmount)
    }
}
