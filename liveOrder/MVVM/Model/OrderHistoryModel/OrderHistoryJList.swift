//
//  JList.swift
//
//  Created by Data Prime on 03/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class OrderHistoryJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cOrderId = "c_order_id"
    static let cSellerLogoImage = "c_seller_logo_image"
    static let cSellerCode = "c_seller_code"
    static let cTotalOrderAmount = "c_total_order_amount"
    static let cOrderStatus = "c_order_status"
    static let cOrderedDate = "c_ordered_date"
    static let cPaymentStatus = "c_payment_status"
    static let jDownloadLink = "j_download_link"
    static let cDeliveryLocation = "c_delivery_location"
    static let cNoOfItemsOrdered = "c_no_of_items_ordered"
    static let cOutstandingAmount = "c_outstanding_amount"
    static let cSellerName = "c_seller_name"
  }

  // MARK: Properties
  public var cOrderId: String?
  public var cSellerLogoImage: String?
  public var cSellerCode: String?
  public var cTotalOrderAmount: String?
  public var cOrderStatus: String?
  public var cOrderedDate: String?
  public var cPaymentStatus: String?
  public var jDownloadLink: [Any]?
  public var cDeliveryLocation: String?
  public var cNoOfItemsOrdered: String?
  public var cOutstandingAmount: String?
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
    cOrderId = json[SerializationKeys.cOrderId].string
    cSellerLogoImage = json[SerializationKeys.cSellerLogoImage].string
    cSellerCode = json[SerializationKeys.cSellerCode].string
    cTotalOrderAmount = json[SerializationKeys.cTotalOrderAmount].string
    cOrderStatus = json[SerializationKeys.cOrderStatus].string
    cOrderedDate = json[SerializationKeys.cOrderedDate].string
    cPaymentStatus = json[SerializationKeys.cPaymentStatus].string
    if let items = json[SerializationKeys.jDownloadLink].array { jDownloadLink = items.map { $0.object} }
    cDeliveryLocation = json[SerializationKeys.cDeliveryLocation].string
    cNoOfItemsOrdered = json[SerializationKeys.cNoOfItemsOrdered].string
    cOutstandingAmount = json[SerializationKeys.cOutstandingAmount].string
    cSellerName = json[SerializationKeys.cSellerName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cOrderId { dictionary[SerializationKeys.cOrderId] = value }
    if let value = cSellerLogoImage { dictionary[SerializationKeys.cSellerLogoImage] = value }
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cTotalOrderAmount { dictionary[SerializationKeys.cTotalOrderAmount] = value }
    if let value = cOrderStatus { dictionary[SerializationKeys.cOrderStatus] = value }
    if let value = cOrderedDate { dictionary[SerializationKeys.cOrderedDate] = value }
    if let value = cPaymentStatus { dictionary[SerializationKeys.cPaymentStatus] = value }
    if let value = jDownloadLink { dictionary[SerializationKeys.jDownloadLink] = value }
    if let value = cDeliveryLocation { dictionary[SerializationKeys.cDeliveryLocation] = value }
    if let value = cNoOfItemsOrdered { dictionary[SerializationKeys.cNoOfItemsOrdered] = value }
    if let value = cOutstandingAmount { dictionary[SerializationKeys.cOutstandingAmount] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cOrderId = aDecoder.decodeObject(forKey: SerializationKeys.cOrderId) as? String
    self.cSellerLogoImage = aDecoder.decodeObject(forKey: SerializationKeys.cSellerLogoImage) as? String
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cTotalOrderAmount = aDecoder.decodeObject(forKey: SerializationKeys.cTotalOrderAmount) as? String
    self.cOrderStatus = aDecoder.decodeObject(forKey: SerializationKeys.cOrderStatus) as? String
    self.cOrderedDate = aDecoder.decodeObject(forKey: SerializationKeys.cOrderedDate) as? String
    self.cPaymentStatus = aDecoder.decodeObject(forKey: SerializationKeys.cPaymentStatus) as? String
    self.jDownloadLink = aDecoder.decodeObject(forKey: SerializationKeys.jDownloadLink) as? [Any]
    self.cDeliveryLocation = aDecoder.decodeObject(forKey: SerializationKeys.cDeliveryLocation) as? String
    self.cNoOfItemsOrdered = aDecoder.decodeObject(forKey: SerializationKeys.cNoOfItemsOrdered) as? String
    self.cOutstandingAmount = aDecoder.decodeObject(forKey: SerializationKeys.cOutstandingAmount) as? String
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cOrderId, forKey: SerializationKeys.cOrderId)
    aCoder.encode(cSellerLogoImage, forKey: SerializationKeys.cSellerLogoImage)
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cTotalOrderAmount, forKey: SerializationKeys.cTotalOrderAmount)
    aCoder.encode(cOrderStatus, forKey: SerializationKeys.cOrderStatus)
    aCoder.encode(cOrderedDate, forKey: SerializationKeys.cOrderedDate)
    aCoder.encode(cPaymentStatus, forKey: SerializationKeys.cPaymentStatus)
    aCoder.encode(jDownloadLink, forKey: SerializationKeys.jDownloadLink)
    aCoder.encode(cDeliveryLocation, forKey: SerializationKeys.cDeliveryLocation)
    aCoder.encode(cNoOfItemsOrdered, forKey: SerializationKeys.cNoOfItemsOrdered)
    aCoder.encode(cOutstandingAmount, forKey: SerializationKeys.cOutstandingAmount)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
  }

}
