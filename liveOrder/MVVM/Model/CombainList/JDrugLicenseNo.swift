//
//  JDrugLicenseNo.swift
//
//  Created by PraveenMac on 16/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class JDrugLicenseNo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cAreaCode = "c_area_code"
    static let cGstNumber = "c_gst_number"
    static let cFirmName = "c_firm_name"
    static let cAddressNo1 = "c_address_no1"
    static let cDrugLicenseNo = "c_drug_license_no"
    static let cStateCode = "c_state_code"
    static let cAreaName = "c_area_name"
    static let cCityName = "c_city_name"
    static let cCityCode = "c_city_code"
    static let cPincode = "c_pincode"
    static let cAddressNo2 = "c_address_no2"
    static let cStateName = "c_state_name"
    static let cBrCode = "c_br_code"
  }

  // MARK: Properties
  public var cAreaCode: String?
  public var cGstNumber: String?
  public var cFirmName: String?
  public var cAddressNo1: String?
  public var cDrugLicenseNo: String?
  public var cStateCode: String?
  public var cAreaName: String?
  public var cCityName: String?
  public var cCityCode: String?
  public var cPincode: String?
  public var cAddressNo2: String?
  public var cStateName: String?
  public var cBrCode: String?

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
    cGstNumber = json[SerializationKeys.cGstNumber].string
    cFirmName = json[SerializationKeys.cFirmName].string
    cAddressNo1 = json[SerializationKeys.cAddressNo1].string
    cDrugLicenseNo = json[SerializationKeys.cDrugLicenseNo].string
    cStateCode = json[SerializationKeys.cStateCode].string
    cAreaName = json[SerializationKeys.cAreaName].string
    cCityName = json[SerializationKeys.cCityName].string
    cCityCode = json[SerializationKeys.cCityCode].string
    cPincode = json[SerializationKeys.cPincode].string
    cAddressNo2 = json[SerializationKeys.cAddressNo2].string
    cStateName = json[SerializationKeys.cStateName].string
    cBrCode = json[SerializationKeys.cBrCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cAreaCode { dictionary[SerializationKeys.cAreaCode] = value }
    if let value = cGstNumber { dictionary[SerializationKeys.cGstNumber] = value }
    if let value = cFirmName { dictionary[SerializationKeys.cFirmName] = value }
    if let value = cAddressNo1 { dictionary[SerializationKeys.cAddressNo1] = value }
    if let value = cDrugLicenseNo { dictionary[SerializationKeys.cDrugLicenseNo] = value }
    if let value = cStateCode { dictionary[SerializationKeys.cStateCode] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cCityCode { dictionary[SerializationKeys.cCityCode] = value }
    if let value = cPincode { dictionary[SerializationKeys.cPincode] = value }
    if let value = cAddressNo2 { dictionary[SerializationKeys.cAddressNo2] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    if let value = cBrCode { dictionary[SerializationKeys.cBrCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cAreaCode = aDecoder.decodeObject(forKey: SerializationKeys.cAreaCode) as? String
    self.cGstNumber = aDecoder.decodeObject(forKey: SerializationKeys.cGstNumber) as? String
    self.cFirmName = aDecoder.decodeObject(forKey: SerializationKeys.cFirmName) as? String
    self.cAddressNo1 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo1) as? String
    self.cDrugLicenseNo = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo) as? String
    self.cStateCode = aDecoder.decodeObject(forKey: SerializationKeys.cStateCode) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cCityCode = aDecoder.decodeObject(forKey: SerializationKeys.cCityCode) as? String
    self.cPincode = aDecoder.decodeObject(forKey: SerializationKeys.cPincode) as? String
    self.cAddressNo2 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo2) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
    self.cBrCode = aDecoder.decodeObject(forKey: SerializationKeys.cBrCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cAreaCode, forKey: SerializationKeys.cAreaCode)
    aCoder.encode(cGstNumber, forKey: SerializationKeys.cGstNumber)
    aCoder.encode(cFirmName, forKey: SerializationKeys.cFirmName)
    aCoder.encode(cAddressNo1, forKey: SerializationKeys.cAddressNo1)
    aCoder.encode(cDrugLicenseNo, forKey: SerializationKeys.cDrugLicenseNo)
    aCoder.encode(cStateCode, forKey: SerializationKeys.cStateCode)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cCityCode, forKey: SerializationKeys.cCityCode)
    aCoder.encode(cPincode, forKey: SerializationKeys.cPincode)
    aCoder.encode(cAddressNo2, forKey: SerializationKeys.cAddressNo2)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
    aCoder.encode(cBrCode, forKey: SerializationKeys.cBrCode)
  }

}
