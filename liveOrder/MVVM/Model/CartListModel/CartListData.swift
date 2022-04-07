//
//  Data.swift
//
//  Created by PraveenMac on 09/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CartListData: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let nNetAmount = "n_net_amount"
      static let cCartCode = "c_cart_code"
      static let nNetGst = "n_net_gst"
      static let nFirmId = "n_firm_id"
      static let nDeliverToBranchId = "n_deliver_to_branch_id"
      static let nCartItemCount = "n_cart_item_count"
      static let nBranchId = "n_branch_id"
      static let jSupplier = "j_supplier"
      static let nUserId = "n_user_id"
    }

    // MARK: Properties
    public var nNetAmount: Int?
    public var cCartCode: String?
    public var nNetGst: Float?
    public var nFirmId: Int?
    public var nDeliverToBranchId: Int?
    public var nCartItemCount: Int?
    public var nBranchId: Int?
    public var jSupplier: [CartListJSupplier]?
    public var nUserId: Int?

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
      nNetAmount = json[SerializationKeys.nNetAmount].int
      cCartCode = json[SerializationKeys.cCartCode].string
      nNetGst = json[SerializationKeys.nNetGst].float
      nFirmId = json[SerializationKeys.nFirmId].int
      nDeliverToBranchId = json[SerializationKeys.nDeliverToBranchId].int
      nCartItemCount = json[SerializationKeys.nCartItemCount].int
      nBranchId = json[SerializationKeys.nBranchId].int
      if let items = json[SerializationKeys.jSupplier].array { jSupplier = items.map { CartListJSupplier(json: $0) } }
      nUserId = json[SerializationKeys.nUserId].int
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = nNetAmount { dictionary[SerializationKeys.nNetAmount] = value }
      if let value = cCartCode { dictionary[SerializationKeys.cCartCode] = value }
      if let value = nNetGst { dictionary[SerializationKeys.nNetGst] = value }
      if let value = nFirmId { dictionary[SerializationKeys.nFirmId] = value }
      if let value = nDeliverToBranchId { dictionary[SerializationKeys.nDeliverToBranchId] = value }
      if let value = nCartItemCount { dictionary[SerializationKeys.nCartItemCount] = value }
      if let value = nBranchId { dictionary[SerializationKeys.nBranchId] = value }
      if let value = jSupplier { dictionary[SerializationKeys.jSupplier] = value.map { $0.dictionaryRepresentation() } }
      if let value = nUserId { dictionary[SerializationKeys.nUserId] = value }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.nNetAmount = aDecoder.decodeObject(forKey: SerializationKeys.nNetAmount) as? Int
      self.cCartCode = aDecoder.decodeObject(forKey: SerializationKeys.cCartCode) as? String
      self.nNetGst = aDecoder.decodeObject(forKey: SerializationKeys.nNetGst) as? Float
      self.nFirmId = aDecoder.decodeObject(forKey: SerializationKeys.nFirmId) as? Int
      self.nDeliverToBranchId = aDecoder.decodeObject(forKey: SerializationKeys.nDeliverToBranchId) as? Int
      self.nCartItemCount = aDecoder.decodeObject(forKey: SerializationKeys.nCartItemCount) as? Int
      self.nBranchId = aDecoder.decodeObject(forKey: SerializationKeys.nBranchId) as? Int
      self.jSupplier = aDecoder.decodeObject(forKey: SerializationKeys.jSupplier) as? [CartListJSupplier]
      self.nUserId = aDecoder.decodeObject(forKey: SerializationKeys.nUserId) as? Int
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(nNetAmount, forKey: SerializationKeys.nNetAmount)
      aCoder.encode(cCartCode, forKey: SerializationKeys.cCartCode)
      aCoder.encode(nNetGst, forKey: SerializationKeys.nNetGst)
      aCoder.encode(nFirmId, forKey: SerializationKeys.nFirmId)
      aCoder.encode(nDeliverToBranchId, forKey: SerializationKeys.nDeliverToBranchId)
      aCoder.encode(nCartItemCount, forKey: SerializationKeys.nCartItemCount)
      aCoder.encode(nBranchId, forKey: SerializationKeys.nBranchId)
      aCoder.encode(jSupplier, forKey: SerializationKeys.jSupplier)
      aCoder.encode(nUserId, forKey: SerializationKeys.nUserId)
    }
}
