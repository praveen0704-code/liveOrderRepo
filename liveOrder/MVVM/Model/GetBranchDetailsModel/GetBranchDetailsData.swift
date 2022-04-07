//
//  Data.swift
//
//  Created by Data Prime on 05/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GetBranchDetailsData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cElectricityBillImg = "c_electricity_bill_img"
    static let cTanNo = "c_tan_no"
    static let cTanNoImg = "c_tan_no_img"
    static let cAuthorityLetter = "c_authority_letter"
    static let cBankStatementImg = "c_bank_statement_img"
    static let cDrugLicenseNo2Img = "c_drug_license_no2_img"
    static let cBankStatement = "c_bank_statement"
    static let cDrugLicenseNo2ExpiryDate = "c_drug_license_no2_expiry_date"
    static let cDrugLicenseNo1ExpiryDate = "c_drug_license_no1_expiry_date"
    static let cAreaName = "c_area_name"
    static let cPanNoImg = "c_pan_no_img"
    static let cFirmImg = "c_firm_img"
    static let cItPanNo = "c_it_pan_no"
    static let cType = "c_type"
    static let cPincode = "c_pincode"
    static let cAddressNo2 = "c_address_no2"
    static let cPanNo = "c_pan_no"
    static let cMobileNo = "c_mobile_no"
    static let cBrCode = "c_br_code"
    static let cDrugLicenseNo1Img = "c_drug_license_no1_img"
    static let cItPanNoImg = "c_it_pan_no_img"
    static let cDrugLicenseNo1 = "c_drug_license_no1"
    static let cGstNumber = "c_gst_number"
    static let cFirmName = "c_firm_name"
    static let cNarcoticNoImg = "c_narcotic_no_img"
    static let cPartnershipDeedImg = "c_partnership_deed_img"
    static let cDrugLicenseNo3ExpiryDate = "c_drug_license_no3_expiry_date"
    static let cAddressNo1 = "c_address_no1"
    static let cDrugLicenseNo2 = "c_drug_license_no2"
    static let cStateCode = "c_state_code"
    static let cElectricityBill = "c_electricity_bill"
    static let cPartnershipDeed = "c_partnership_deed"
    static let cRentAgreementImg = "c_rent_agreement_img"
    static let cRentAgreement = "c_rent_agreement"
    static let cCityName = "c_city_name"
    static let cAuthorityLetterImg = "c_authority_letter_img"
    static let cContactPersonName = "c_contact_person_name"
    static let cNarcoticNo = "c_narcotic_no"
    static let cDrugLicenseNo3 = "c_drug_license_no3"
    static let cCityCode = "c_city_code"
    static let cGstType = "c_gst_type"
    static let cStateName = "c_state_name"
  }

  // MARK: Properties
  public var cElectricityBillImg: String?
  public var cTanNo: String?
  public var cTanNoImg: String?
  public var cAuthorityLetter: String?
  public var cBankStatementImg: String?
  public var cDrugLicenseNo2Img: String?
  public var cBankStatement: String?
  public var cDrugLicenseNo2ExpiryDate: String?
  public var cDrugLicenseNo1ExpiryDate: String?
  public var cAreaName: String?
  public var cPanNoImg: String?
  public var cFirmImg: String?
  public var cItPanNo: String?
  public var cType: String?
  public var cPincode: String?
  public var cAddressNo2: String?
  public var cPanNo: String?
  public var cMobileNo: String?
  public var cBrCode: String?
  public var cDrugLicenseNo1Img: String?
  public var cItPanNoImg: String?
  public var cDrugLicenseNo1: String?
  public var cGstNumber: String?
  public var cFirmName: String?
  public var cNarcoticNoImg: String?
  public var cPartnershipDeedImg: String?
  public var cDrugLicenseNo3ExpiryDate: String?
  public var cAddressNo1: String?
  public var cDrugLicenseNo2: String?
  public var cStateCode: String?
  public var cElectricityBill: String?
  public var cPartnershipDeed: String?
  public var cRentAgreementImg: String?
  public var cRentAgreement: String?
  public var cCityName: String?
  public var cAuthorityLetterImg: String?
  public var cContactPersonName: String?
  public var cNarcoticNo: String?
  public var cDrugLicenseNo3: String?
  public var cCityCode: String?
  public var cGstType: String?
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
    cElectricityBillImg = json[SerializationKeys.cElectricityBillImg].string
    cTanNo = json[SerializationKeys.cTanNo].string
    cTanNoImg = json[SerializationKeys.cTanNoImg].string
    cAuthorityLetter = json[SerializationKeys.cAuthorityLetter].string
    cBankStatementImg = json[SerializationKeys.cBankStatementImg].string
    cDrugLicenseNo2Img = json[SerializationKeys.cDrugLicenseNo2Img].string
    cBankStatement = json[SerializationKeys.cBankStatement].string
    cDrugLicenseNo2ExpiryDate = json[SerializationKeys.cDrugLicenseNo2ExpiryDate].string
    cDrugLicenseNo1ExpiryDate = json[SerializationKeys.cDrugLicenseNo1ExpiryDate].string
    cAreaName = json[SerializationKeys.cAreaName].string
    cPanNoImg = json[SerializationKeys.cPanNoImg].string
    cFirmImg = json[SerializationKeys.cFirmImg].string
    cItPanNo = json[SerializationKeys.cItPanNo].string
    cType = json[SerializationKeys.cType].string
    cPincode = json[SerializationKeys.cPincode].string
    cAddressNo2 = json[SerializationKeys.cAddressNo2].string
    cPanNo = json[SerializationKeys.cPanNo].string
    cMobileNo = json[SerializationKeys.cMobileNo].string
    cBrCode = json[SerializationKeys.cBrCode].string
    cDrugLicenseNo1Img = json[SerializationKeys.cDrugLicenseNo1Img].string
    cItPanNoImg = json[SerializationKeys.cItPanNoImg].string
    cDrugLicenseNo1 = json[SerializationKeys.cDrugLicenseNo1].string
    cGstNumber = json[SerializationKeys.cGstNumber].string
    cFirmName = json[SerializationKeys.cFirmName].string
    cNarcoticNoImg = json[SerializationKeys.cNarcoticNoImg].string
    cPartnershipDeedImg = json[SerializationKeys.cPartnershipDeedImg].string
    cDrugLicenseNo3ExpiryDate = json[SerializationKeys.cDrugLicenseNo3ExpiryDate].string
    cAddressNo1 = json[SerializationKeys.cAddressNo1].string
    cDrugLicenseNo2 = json[SerializationKeys.cDrugLicenseNo2].string
    cStateCode = json[SerializationKeys.cStateCode].string
    cElectricityBill = json[SerializationKeys.cElectricityBill].string
    cPartnershipDeed = json[SerializationKeys.cPartnershipDeed].string
    cRentAgreementImg = json[SerializationKeys.cRentAgreementImg].string
    cRentAgreement = json[SerializationKeys.cRentAgreement].string
    cCityName = json[SerializationKeys.cCityName].string
    cAuthorityLetterImg = json[SerializationKeys.cAuthorityLetterImg].string
    cContactPersonName = json[SerializationKeys.cContactPersonName].string
    cNarcoticNo = json[SerializationKeys.cNarcoticNo].string
    cDrugLicenseNo3 = json[SerializationKeys.cDrugLicenseNo3].string
    cCityCode = json[SerializationKeys.cCityCode].string
    cGstType = json[SerializationKeys.cGstType].string
    cStateName = json[SerializationKeys.cStateName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cElectricityBillImg { dictionary[SerializationKeys.cElectricityBillImg] = value }
    if let value = cTanNo { dictionary[SerializationKeys.cTanNo] = value }
    if let value = cTanNoImg { dictionary[SerializationKeys.cTanNoImg] = value }
    if let value = cAuthorityLetter { dictionary[SerializationKeys.cAuthorityLetter] = value }
    if let value = cBankStatementImg { dictionary[SerializationKeys.cBankStatementImg] = value }
    if let value = cDrugLicenseNo2Img { dictionary[SerializationKeys.cDrugLicenseNo2Img] = value }
    if let value = cBankStatement { dictionary[SerializationKeys.cBankStatement] = value }
    if let value = cDrugLicenseNo2ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo2ExpiryDate] = value }
    if let value = cDrugLicenseNo1ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo1ExpiryDate] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
    if let value = cPanNoImg { dictionary[SerializationKeys.cPanNoImg] = value }
    if let value = cFirmImg { dictionary[SerializationKeys.cFirmImg] = value }
    if let value = cItPanNo { dictionary[SerializationKeys.cItPanNo] = value }
    if let value = cType { dictionary[SerializationKeys.cType] = value }
    if let value = cPincode { dictionary[SerializationKeys.cPincode] = value }
    if let value = cAddressNo2 { dictionary[SerializationKeys.cAddressNo2] = value }
    if let value = cPanNo { dictionary[SerializationKeys.cPanNo] = value }
    if let value = cMobileNo { dictionary[SerializationKeys.cMobileNo] = value }
    if let value = cBrCode { dictionary[SerializationKeys.cBrCode] = value }
    if let value = cDrugLicenseNo1Img { dictionary[SerializationKeys.cDrugLicenseNo1Img] = value }
    if let value = cItPanNoImg { dictionary[SerializationKeys.cItPanNoImg] = value }
    if let value = cDrugLicenseNo1 { dictionary[SerializationKeys.cDrugLicenseNo1] = value }
    if let value = cGstNumber { dictionary[SerializationKeys.cGstNumber] = value }
    if let value = cFirmName { dictionary[SerializationKeys.cFirmName] = value }
    if let value = cNarcoticNoImg { dictionary[SerializationKeys.cNarcoticNoImg] = value }
    if let value = cPartnershipDeedImg { dictionary[SerializationKeys.cPartnershipDeedImg] = value }
    if let value = cDrugLicenseNo3ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo3ExpiryDate] = value }
    if let value = cAddressNo1 { dictionary[SerializationKeys.cAddressNo1] = value }
    if let value = cDrugLicenseNo2 { dictionary[SerializationKeys.cDrugLicenseNo2] = value }
    if let value = cStateCode { dictionary[SerializationKeys.cStateCode] = value }
    if let value = cElectricityBill { dictionary[SerializationKeys.cElectricityBill] = value }
    if let value = cPartnershipDeed { dictionary[SerializationKeys.cPartnershipDeed] = value }
    if let value = cRentAgreementImg { dictionary[SerializationKeys.cRentAgreementImg] = value }
    if let value = cRentAgreement { dictionary[SerializationKeys.cRentAgreement] = value }
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cAuthorityLetterImg { dictionary[SerializationKeys.cAuthorityLetterImg] = value }
    if let value = cContactPersonName { dictionary[SerializationKeys.cContactPersonName] = value }
    if let value = cNarcoticNo { dictionary[SerializationKeys.cNarcoticNo] = value }
    if let value = cDrugLicenseNo3 { dictionary[SerializationKeys.cDrugLicenseNo3] = value }
    if let value = cCityCode { dictionary[SerializationKeys.cCityCode] = value }
    if let value = cGstType { dictionary[SerializationKeys.cGstType] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cElectricityBillImg = aDecoder.decodeObject(forKey: SerializationKeys.cElectricityBillImg) as? String
    self.cTanNo = aDecoder.decodeObject(forKey: SerializationKeys.cTanNo) as? String
    self.cTanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cTanNoImg) as? String
    self.cAuthorityLetter = aDecoder.decodeObject(forKey: SerializationKeys.cAuthorityLetter) as? String
    self.cBankStatementImg = aDecoder.decodeObject(forKey: SerializationKeys.cBankStatementImg) as? String
    self.cDrugLicenseNo2Img = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo2Img) as? String
    self.cBankStatement = aDecoder.decodeObject(forKey: SerializationKeys.cBankStatement) as? String
    self.cDrugLicenseNo2ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo2ExpiryDate) as? String
    self.cDrugLicenseNo1ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo1ExpiryDate) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
    self.cPanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cPanNoImg) as? String
    self.cFirmImg = aDecoder.decodeObject(forKey: SerializationKeys.cFirmImg) as? String
    self.cItPanNo = aDecoder.decodeObject(forKey: SerializationKeys.cItPanNo) as? String
    self.cType = aDecoder.decodeObject(forKey: SerializationKeys.cType) as? String
    self.cPincode = aDecoder.decodeObject(forKey: SerializationKeys.cPincode) as? String
    self.cAddressNo2 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo2) as? String
    self.cPanNo = aDecoder.decodeObject(forKey: SerializationKeys.cPanNo) as? String
    self.cMobileNo = aDecoder.decodeObject(forKey: SerializationKeys.cMobileNo) as? String
    self.cBrCode = aDecoder.decodeObject(forKey: SerializationKeys.cBrCode) as? String
    self.cDrugLicenseNo1Img = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo1Img) as? String
    self.cItPanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cItPanNoImg) as? String
    self.cDrugLicenseNo1 = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo1) as? String
    self.cGstNumber = aDecoder.decodeObject(forKey: SerializationKeys.cGstNumber) as? String
    self.cFirmName = aDecoder.decodeObject(forKey: SerializationKeys.cFirmName) as? String
    self.cNarcoticNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cNarcoticNoImg) as? String
    self.cPartnershipDeedImg = aDecoder.decodeObject(forKey: SerializationKeys.cPartnershipDeedImg) as? String
    self.cDrugLicenseNo3ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo3ExpiryDate) as? String
    self.cAddressNo1 = aDecoder.decodeObject(forKey: SerializationKeys.cAddressNo1) as? String
    self.cDrugLicenseNo2 = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo2) as? String
    self.cStateCode = aDecoder.decodeObject(forKey: SerializationKeys.cStateCode) as? String
    self.cElectricityBill = aDecoder.decodeObject(forKey: SerializationKeys.cElectricityBill) as? String
    self.cPartnershipDeed = aDecoder.decodeObject(forKey: SerializationKeys.cPartnershipDeed) as? String
    self.cRentAgreementImg = aDecoder.decodeObject(forKey: SerializationKeys.cRentAgreementImg) as? String
    self.cRentAgreement = aDecoder.decodeObject(forKey: SerializationKeys.cRentAgreement) as? String
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cAuthorityLetterImg = aDecoder.decodeObject(forKey: SerializationKeys.cAuthorityLetterImg) as? String
    self.cContactPersonName = aDecoder.decodeObject(forKey: SerializationKeys.cContactPersonName) as? String
    self.cNarcoticNo = aDecoder.decodeObject(forKey: SerializationKeys.cNarcoticNo) as? String
    self.cDrugLicenseNo3 = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo3) as? String
    self.cCityCode = aDecoder.decodeObject(forKey: SerializationKeys.cCityCode) as? String
    self.cGstType = aDecoder.decodeObject(forKey: SerializationKeys.cGstType) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cElectricityBillImg, forKey: SerializationKeys.cElectricityBillImg)
    aCoder.encode(cTanNo, forKey: SerializationKeys.cTanNo)
    aCoder.encode(cTanNoImg, forKey: SerializationKeys.cTanNoImg)
    aCoder.encode(cAuthorityLetter, forKey: SerializationKeys.cAuthorityLetter)
    aCoder.encode(cBankStatementImg, forKey: SerializationKeys.cBankStatementImg)
    aCoder.encode(cDrugLicenseNo2Img, forKey: SerializationKeys.cDrugLicenseNo2Img)
    aCoder.encode(cBankStatement, forKey: SerializationKeys.cBankStatement)
    aCoder.encode(cDrugLicenseNo2ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo2ExpiryDate)
    aCoder.encode(cDrugLicenseNo1ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo1ExpiryDate)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
    aCoder.encode(cPanNoImg, forKey: SerializationKeys.cPanNoImg)
    aCoder.encode(cFirmImg, forKey: SerializationKeys.cFirmImg)
    aCoder.encode(cItPanNo, forKey: SerializationKeys.cItPanNo)
    aCoder.encode(cType, forKey: SerializationKeys.cType)
    aCoder.encode(cPincode, forKey: SerializationKeys.cPincode)
    aCoder.encode(cAddressNo2, forKey: SerializationKeys.cAddressNo2)
    aCoder.encode(cPanNo, forKey: SerializationKeys.cPanNo)
    aCoder.encode(cMobileNo, forKey: SerializationKeys.cMobileNo)
    aCoder.encode(cBrCode, forKey: SerializationKeys.cBrCode)
    aCoder.encode(cDrugLicenseNo1Img, forKey: SerializationKeys.cDrugLicenseNo1Img)
    aCoder.encode(cItPanNoImg, forKey: SerializationKeys.cItPanNoImg)
    aCoder.encode(cDrugLicenseNo1, forKey: SerializationKeys.cDrugLicenseNo1)
    aCoder.encode(cGstNumber, forKey: SerializationKeys.cGstNumber)
    aCoder.encode(cFirmName, forKey: SerializationKeys.cFirmName)
    aCoder.encode(cNarcoticNoImg, forKey: SerializationKeys.cNarcoticNoImg)
    aCoder.encode(cPartnershipDeedImg, forKey: SerializationKeys.cPartnershipDeedImg)
    aCoder.encode(cDrugLicenseNo3ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo3ExpiryDate)
    aCoder.encode(cAddressNo1, forKey: SerializationKeys.cAddressNo1)
    aCoder.encode(cDrugLicenseNo2, forKey: SerializationKeys.cDrugLicenseNo2)
    aCoder.encode(cStateCode, forKey: SerializationKeys.cStateCode)
    aCoder.encode(cElectricityBill, forKey: SerializationKeys.cElectricityBill)
    aCoder.encode(cPartnershipDeed, forKey: SerializationKeys.cPartnershipDeed)
    aCoder.encode(cRentAgreementImg, forKey: SerializationKeys.cRentAgreementImg)
    aCoder.encode(cRentAgreement, forKey: SerializationKeys.cRentAgreement)
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cAuthorityLetterImg, forKey: SerializationKeys.cAuthorityLetterImg)
    aCoder.encode(cContactPersonName, forKey: SerializationKeys.cContactPersonName)
    aCoder.encode(cNarcoticNo, forKey: SerializationKeys.cNarcoticNo)
    aCoder.encode(cDrugLicenseNo3, forKey: SerializationKeys.cDrugLicenseNo3)
    aCoder.encode(cCityCode, forKey: SerializationKeys.cCityCode)
    aCoder.encode(cGstType, forKey: SerializationKeys.cGstType)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
  }

}
