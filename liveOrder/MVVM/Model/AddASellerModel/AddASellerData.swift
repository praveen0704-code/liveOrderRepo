//
//  Data.swift
//
//  Created by Data Prime on 02/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AddASellerData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cAreaCode = "c_area_code"
    static let cAddressNo1 = "c_address_no1"
    static let cDrugLicenseNo = "c_drug_license_no"
    static let cStateCode = "c_state_code"
    static let cSellerName = "c_seller_name"
    static let cDrugLicenseNoExpiryDate = "c_drug_license_no_expiry_date"
    static let cSellerCode = "c_seller_code"
    static let cCityName = "c_city_name"
    static let cContactPersonName = "c_contact_person_name"
    static let cAreaName = "c_area_name"
    static let cCityCode = "c_city_code"
    static let cPincode = "c_pincode"
    static let cAddressNo2 = "c_address_no2"
    static let cMobileNo = "c_mobile_no"
    static let cStateName = "c_state_name"
  }

  // MARK: Properties
  public var cAreaCode: String?
  public var cAddressNo1: String?
  public var cDrugLicenseNo: String?
  public var cStateCode: String?
  public var cSellerName: String?
  public var cDrugLicenseNoExpiryDate: String?
  public var cSellerCode: String?
  public var cCityName: String?
  public var cContactPersonName: String?
  public var cAreaName: String?
  public var cCityCode: String?
  public var cPincode: String?
  public var cAddressNo2: String?
  public var cMobileNo: String?
  public var cStateName: String?

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
    cAreaCode = json[SerializationKeys.cAreaCode].string
    cAddressNo1 = json[SerializationKeys.cAddressNo1].string
    cDrugLicenseNo = json[SerializationKeys.cDrugLicenseNo].string
    cStateCode = json[SerializationKeys.cStateCode].string
    cSellerName = json[SerializationKeys.cSellerName].string
    cDrugLicenseNoExpiryDate = json[SerializationKeys.cDrugLicenseNoExpiryDate].string
    cSellerCode = json[SerializationKeys.cSellerCode].string
    cCityName = json[SerializationKeys.cCityName].string
    cContactPersonName = json[SerializationKeys.cContactPersonName].string
    cAreaName = json[SerializationKeys.cAreaName].string
    cCityCode = json[SerializationKeys.cCityCode].string
    cPincode = json[SerializationKeys.cPincode].string
    cAddressNo2 = json[SerializationKeys.cAddressNo2].string
    cMobileNo = json[SerializationKeys.cMobileNo].string
    cStateName = json[SerializationKeys.cStateName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cAreaCode { dictionary[SerializationKeys.cAreaCode] = value }
    if let value = cAddressNo1 { dictionary[SerializationKeys.cAddressNo1] = value }
    if let value = cDrugLicenseNo { dictionary[SerializationKeys.cDrugLicenseNo] = value }
    if let value = cStateCode { dictionary[SerializationKeys.cStateCode] = value }
    if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
    if let value = cDrugLicenseNoExpiryDate { dictionary[SerializationKeys.cDrugLicenseNoExpiryDate] = value }
    if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cContactPersonName { dictionary[SerializationKeys.cContactPersonName] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
    if let value = cCityCode { dictionary[SerializationKeys.cCityCode] = value }
    if let value = cPincode { dictionary[SerializationKeys.cPincode] = value }
    if let value = cAddressNo2 { dictionary[SerializationKeys.cAddressNo2] = value }
    if let value = cMobileNo { dictionary[SerializationKeys.cMobileNo] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cAreaCode = aDecoder.decodeObject(forKey: SerializationKeys.cAreaCode) as? String
    self.cAddressNo1 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo1) as? String
    self.cDrugLicenseNo = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo) as? String
    self.cStateCode = aDecoder.decodeObject(forKey: SerializationKeys.cStateCode) as? String
    self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    self.cDrugLicenseNoExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNoExpiryDate) as? String
    self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cContactPersonName = aDecoder.decodeObject(forKey: SerializationKeys.cContactPersonName) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
    self.cCityCode = aDecoder.decodeObject(forKey: SerializationKeys.cCityCode) as? String
    self.cPincode = aDecoder.decodeObject(forKey: SerializationKeys.cPincode) as? String
    self.cAddressNo2 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo2) as? String
    self.cMobileNo = aDecoder.decodeObject(forKey: SerializationKeys.cMobileNo) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cAreaCode, forKey: SerializationKeys.cAreaCode)
    aCoder.encode(cAddressNo1, forKey: SerializationKeys.cAddressNo1)
    aCoder.encode(cDrugLicenseNo, forKey: SerializationKeys.cDrugLicenseNo)
    aCoder.encode(cStateCode, forKey: SerializationKeys.cStateCode)
    aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    aCoder.encode(cDrugLicenseNoExpiryDate, forKey: SerializationKeys.cDrugLicenseNoExpiryDate)
    aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cContactPersonName, forKey: SerializationKeys.cContactPersonName)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
    aCoder.encode(cCityCode, forKey: SerializationKeys.cCityCode)
    aCoder.encode(cPincode, forKey: SerializationKeys.cPincode)
    aCoder.encode(cAddressNo2, forKey: SerializationKeys.cAddressNo2)
    aCoder.encode(cMobileNo, forKey: SerializationKeys.cMobileNo)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
  }

}
