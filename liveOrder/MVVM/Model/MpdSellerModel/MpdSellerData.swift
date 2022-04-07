//
//  Data.swift
//
//  Created by Data Prime on 26/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MpdSellerData: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let cSellerCode = "c_seller_code"
      static let cPendingCredit = "c_pending_credit"
      static let cPriority = "c_priority"
      static let nProductScheme = "n_product_scheme"
      static let cBuyerCode = "c_buyer_code"
      static let cSellerName = "c_seller_name"
    }

    // MARK: Properties
    public var cSellerCode: String?
    public var cPendingCredit: String?
    public var cPriority: String?
    public var nProductScheme: String?
    public var cBuyerCode: String?
    public var cSellerName: String?

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
      cPendingCredit = json[SerializationKeys.cPendingCredit].string
      cPriority = json[SerializationKeys.cPriority].string
      nProductScheme = json[SerializationKeys.nProductScheme].string
      cBuyerCode = json[SerializationKeys.cBuyerCode].string
      cSellerName = json[SerializationKeys.cSellerName].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
      if let value = cPendingCredit { dictionary[SerializationKeys.cPendingCredit] = value }
      if let value = cPriority { dictionary[SerializationKeys.cPriority] = value }
      if let value = nProductScheme { dictionary[SerializationKeys.nProductScheme] = value }
      if let value = cBuyerCode { dictionary[SerializationKeys.cBuyerCode] = value }
      if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
      self.cPendingCredit = aDecoder.decodeObject(forKey: SerializationKeys.cPendingCredit) as? String
      self.cPriority = aDecoder.decodeObject(forKey: SerializationKeys.cPriority) as? String
      self.nProductScheme = aDecoder.decodeObject(forKey: SerializationKeys.nProductScheme) as? String
      self.cBuyerCode = aDecoder.decodeObject(forKey: SerializationKeys.cBuyerCode) as? String
      self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
      aCoder.encode(cPendingCredit, forKey: SerializationKeys.cPendingCredit)
      aCoder.encode(cPriority, forKey: SerializationKeys.cPriority)
      aCoder.encode(nProductScheme, forKey: SerializationKeys.nProductScheme)
      aCoder.encode(cBuyerCode, forKey: SerializationKeys.cBuyerCode)
      aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    }
}
