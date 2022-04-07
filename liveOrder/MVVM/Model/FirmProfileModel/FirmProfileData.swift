//
//  Data.swift
//
//  Created by Data Prime on 25/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class FirmProfileData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cElectricityBillImg = "c_electricity_bill_img"
    static let cTanNo = "c_tan_no"
    static let cDruglicenseNo2 = "c_druglicense_no2"
    static let cTanNoImg = "c_tan_no_img"
    static let cAuthorityLetter = "c_authority_letter"
    static let cBankStatementImg = "c_bank_statement_img"
    static let cDruglicenseNo3Img = "c_druglicense_no3_img"
    static let cC2code = "c_c2code"
    static let cBankStatement = "c_bank_statement"
    static let cDrugLicenseNo2ExpiryDate = "c_drug_license_no2_expiry_date"
    static let cFirmAddress2 = "c_firm_address2"
    static let cDrugLicenseNo1ExpiryDate = "c_drug_license_no1_expiry_date"
    static let cAreaName = "c_area_name"
    static let cStatus = "c_status"
    static let cLandmark = "c_landmark"
    static let cPanNoImg = "c_pan_no_img"
    static let cItPanNo = "c_it_pan_no"
    static let cFirmAddress1 = "c_firm_address1"
    static let cDruglicenseNo1Img = "c_druglicense_no1_img"
    static let cType = "c_type"
    static let cPincode = "c_pincode"
    static let cDruglicenseNo3 = "c_druglicense_no3"
    static let cPanNo = "c_pan_no"
    static let cMobileNo = "c_mobile_no"
    static let cAreaCode = "c_area_code"
    static let cItPanNoImg = "c_it_pan_no_img"
    static let cPartnershipDeedImg = "c_partnership_deed_img"
    static let cDruglicenseNo1 = "c_druglicense_no1"
    static let cNarcoticNoImg = "c_narcotic_no_img"
    static let cDrugLicenseNo3ExpiryDate = "c_drug_license_no3_expiry_date"
    static let cFirmContactPerson = "c_firm_contact_person"
    static let cDruglicenseNo2Img = "c_druglicense_no2_img"
    static let cStateCode = "c_state_code"
    static let cRentAgreement = "c_rent_agreement"
    static let cElectricityBill = "c_electricity_bill"
    static let cPartnershipDeed = "c_partnership_deed"
    static let cRentAgreementImg = "c_rent_agreement_img"
    static let cName = "c_name"
    static let cCityName = "c_city_name"
    static let cAuthorityLetterImg = "c_authority_letter_img"
    static let cGstNo = "c_gst_no"
    static let cNarcoticNo = "c_narcotic_no"
    static let cEmail = "c_email"
    static let cCityCode = "c_city_code"
    static let cImageUrl = "c_image_url"
    static let cGstType = "c_gst_type"
    static let cStateName = "c_state_name"
  }

  // MARK: Properties
  public var cElectricityBillImg: String?
  public var cTanNo: String?
  public var cDruglicenseNo2: String?
  public var cTanNoImg: String?
  public var cAuthorityLetter: String?
  public var cBankStatementImg: String?
  public var cDruglicenseNo3Img: String?
  public var cC2code: String?
  public var cBankStatement: String?
  public var cDrugLicenseNo2ExpiryDate: String?
  public var cFirmAddress2: String?
  public var cDrugLicenseNo1ExpiryDate: String?
  public var cAreaName: String?
  public var cStatus: String?
  public var cLandmark: String?
  public var cPanNoImg: String?
  public var cItPanNo: String?
  public var cFirmAddress1: String?
  public var cDruglicenseNo1Img: String?
  public var cType: String?
  public var cPincode: String?
  public var cDruglicenseNo3: String?
  public var cPanNo: String?
  public var cMobileNo: String?
  public var cAreaCode: String?
  public var cItPanNoImg: String?
  public var cPartnershipDeedImg: String?
  public var cDruglicenseNo1: String?
  public var cNarcoticNoImg: String?
  public var cDrugLicenseNo3ExpiryDate: String?
  public var cFirmContactPerson: String?
  public var cDruglicenseNo2Img: String?
  public var cStateCode: String?
  public var cRentAgreement: String?
  public var cElectricityBill: String?
  public var cPartnershipDeed: String?
  public var cRentAgreementImg: String?
  public var cName: String?
  public var cCityName: String?
  public var cAuthorityLetterImg: String?
  public var cGstNo: String?
  public var cNarcoticNo: String?
  public var cEmail: String?
  public var cCityCode: String?
  public var cImageUrl: String?
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
    cDruglicenseNo2 = json[SerializationKeys.cDruglicenseNo2].string
    cTanNoImg = json[SerializationKeys.cTanNoImg].string
    cAuthorityLetter = json[SerializationKeys.cAuthorityLetter].string
    cBankStatementImg = json[SerializationKeys.cBankStatementImg].string
    cDruglicenseNo3Img = json[SerializationKeys.cDruglicenseNo3Img].string
    cC2code = json[SerializationKeys.cC2code].string
    cBankStatement = json[SerializationKeys.cBankStatement].string
    cDrugLicenseNo2ExpiryDate = json[SerializationKeys.cDrugLicenseNo2ExpiryDate].string
    cFirmAddress2 = json[SerializationKeys.cFirmAddress2].string
    cDrugLicenseNo1ExpiryDate = json[SerializationKeys.cDrugLicenseNo1ExpiryDate].string
    cAreaName = json[SerializationKeys.cAreaName].string
    cStatus = json[SerializationKeys.cStatus].string
    cLandmark = json[SerializationKeys.cLandmark].string
    cPanNoImg = json[SerializationKeys.cPanNoImg].string
    cItPanNo = json[SerializationKeys.cItPanNo].string
    cFirmAddress1 = json[SerializationKeys.cFirmAddress1].string
    cDruglicenseNo1Img = json[SerializationKeys.cDruglicenseNo1Img].string
    cType = json[SerializationKeys.cType].string
    cPincode = json[SerializationKeys.cPincode].string
    cDruglicenseNo3 = json[SerializationKeys.cDruglicenseNo3].string
    cPanNo = json[SerializationKeys.cPanNo].string
    cMobileNo = json[SerializationKeys.cMobileNo].string
    cAreaCode = json[SerializationKeys.cAreaCode].string
    cItPanNoImg = json[SerializationKeys.cItPanNoImg].string
    cPartnershipDeedImg = json[SerializationKeys.cPartnershipDeedImg].string
    cDruglicenseNo1 = json[SerializationKeys.cDruglicenseNo1].string
    cNarcoticNoImg = json[SerializationKeys.cNarcoticNoImg].string
    cDrugLicenseNo3ExpiryDate = json[SerializationKeys.cDrugLicenseNo3ExpiryDate].string
    cFirmContactPerson = json[SerializationKeys.cFirmContactPerson].string
    cDruglicenseNo2Img = json[SerializationKeys.cDruglicenseNo2Img].string
    cStateCode = json[SerializationKeys.cStateCode].string
    cRentAgreement = json[SerializationKeys.cRentAgreement].string
    cElectricityBill = json[SerializationKeys.cElectricityBill].string
    cPartnershipDeed = json[SerializationKeys.cPartnershipDeed].string
    cRentAgreementImg = json[SerializationKeys.cRentAgreementImg].string
    cName = json[SerializationKeys.cName].string
    cCityName = json[SerializationKeys.cCityName].string
    cAuthorityLetterImg = json[SerializationKeys.cAuthorityLetterImg].string
    cGstNo = json[SerializationKeys.cGstNo].string
    cNarcoticNo = json[SerializationKeys.cNarcoticNo].string
    cEmail = json[SerializationKeys.cEmail].string
    cCityCode = json[SerializationKeys.cCityCode].string
    cImageUrl = json[SerializationKeys.cImageUrl].string
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
    if let value = cDruglicenseNo2 { dictionary[SerializationKeys.cDruglicenseNo2] = value }
    if let value = cTanNoImg { dictionary[SerializationKeys.cTanNoImg] = value }
    if let value = cAuthorityLetter { dictionary[SerializationKeys.cAuthorityLetter] = value }
    if let value = cBankStatementImg { dictionary[SerializationKeys.cBankStatementImg] = value }
    if let value = cDruglicenseNo3Img { dictionary[SerializationKeys.cDruglicenseNo3Img] = value }
    if let value = cC2code { dictionary[SerializationKeys.cC2code] = value }
    if let value = cBankStatement { dictionary[SerializationKeys.cBankStatement] = value }
    if let value = cDrugLicenseNo2ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo2ExpiryDate] = value }
    if let value = cFirmAddress2 { dictionary[SerializationKeys.cFirmAddress2] = value }
    if let value = cDrugLicenseNo1ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo1ExpiryDate] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
    if let value = cStatus { dictionary[SerializationKeys.cStatus] = value }
    if let value = cLandmark { dictionary[SerializationKeys.cLandmark] = value }
    if let value = cPanNoImg { dictionary[SerializationKeys.cPanNoImg] = value }
    if let value = cItPanNo { dictionary[SerializationKeys.cItPanNo] = value }
    if let value = cFirmAddress1 { dictionary[SerializationKeys.cFirmAddress1] = value }
    if let value = cDruglicenseNo1Img { dictionary[SerializationKeys.cDruglicenseNo1Img] = value }
    if let value = cType { dictionary[SerializationKeys.cType] = value }
    if let value = cPincode { dictionary[SerializationKeys.cPincode] = value }
    if let value = cDruglicenseNo3 { dictionary[SerializationKeys.cDruglicenseNo3] = value }
    if let value = cPanNo { dictionary[SerializationKeys.cPanNo] = value }
    if let value = cMobileNo { dictionary[SerializationKeys.cMobileNo] = value }
    if let value = cAreaCode { dictionary[SerializationKeys.cAreaCode] = value }
    if let value = cItPanNoImg { dictionary[SerializationKeys.cItPanNoImg] = value }
    if let value = cPartnershipDeedImg { dictionary[SerializationKeys.cPartnershipDeedImg] = value }
    if let value = cDruglicenseNo1 { dictionary[SerializationKeys.cDruglicenseNo1] = value }
    if let value = cNarcoticNoImg { dictionary[SerializationKeys.cNarcoticNoImg] = value }
    if let value = cDrugLicenseNo3ExpiryDate { dictionary[SerializationKeys.cDrugLicenseNo3ExpiryDate] = value }
    if let value = cFirmContactPerson { dictionary[SerializationKeys.cFirmContactPerson] = value }
    if let value = cDruglicenseNo2Img { dictionary[SerializationKeys.cDruglicenseNo2Img] = value }
    if let value = cStateCode { dictionary[SerializationKeys.cStateCode] = value }
    if let value = cRentAgreement { dictionary[SerializationKeys.cRentAgreement] = value }
    if let value = cElectricityBill { dictionary[SerializationKeys.cElectricityBill] = value }
    if let value = cPartnershipDeed { dictionary[SerializationKeys.cPartnershipDeed] = value }
    if let value = cRentAgreementImg { dictionary[SerializationKeys.cRentAgreementImg] = value }
    if let value = cName { dictionary[SerializationKeys.cName] = value }
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cAuthorityLetterImg { dictionary[SerializationKeys.cAuthorityLetterImg] = value }
    if let value = cGstNo { dictionary[SerializationKeys.cGstNo] = value }
    if let value = cNarcoticNo { dictionary[SerializationKeys.cNarcoticNo] = value }
    if let value = cEmail { dictionary[SerializationKeys.cEmail] = value }
    if let value = cCityCode { dictionary[SerializationKeys.cCityCode] = value }
    if let value = cImageUrl { dictionary[SerializationKeys.cImageUrl] = value }
    if let value = cGstType { dictionary[SerializationKeys.cGstType] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cElectricityBillImg = aDecoder.decodeObject(forKey: SerializationKeys.cElectricityBillImg) as? String
    self.cTanNo = aDecoder.decodeObject(forKey: SerializationKeys.cTanNo) as? String
    self.cDruglicenseNo2 = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo2) as? String
    self.cTanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cTanNoImg) as? String
    self.cAuthorityLetter = aDecoder.decodeObject(forKey: SerializationKeys.cAuthorityLetter) as? String
    self.cBankStatementImg = aDecoder.decodeObject(forKey: SerializationKeys.cBankStatementImg) as? String
    self.cDruglicenseNo3Img = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo3Img) as? String
    self.cC2code = aDecoder.decodeObject(forKey: SerializationKeys.cC2code) as? String
    self.cBankStatement = aDecoder.decodeObject(forKey: SerializationKeys.cBankStatement) as? String
    self.cDrugLicenseNo2ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo2ExpiryDate) as? String
    self.cFirmAddress2 = aDecoder.decodeObject(forKey: SerializationKeys.cFirmAddress2) as? String
    self.cDrugLicenseNo1ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo1ExpiryDate) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
    self.cStatus = aDecoder.decodeObject(forKey: SerializationKeys.cStatus) as? String
    self.cLandmark = aDecoder.decodeObject(forKey: SerializationKeys.cLandmark) as? String
    self.cPanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cPanNoImg) as? String
    self.cItPanNo = aDecoder.decodeObject(forKey: SerializationKeys.cItPanNo) as? String
    self.cFirmAddress1 = aDecoder.decodeObject(forKey: SerializationKeys.cFirmAddress1) as? String
    self.cDruglicenseNo1Img = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo1Img) as? String
    self.cType = aDecoder.decodeObject(forKey: SerializationKeys.cType) as? String
    self.cPincode = aDecoder.decodeObject(forKey: SerializationKeys.cPincode) as? String
    self.cDruglicenseNo3 = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo3) as? String
    self.cPanNo = aDecoder.decodeObject(forKey: SerializationKeys.cPanNo) as? String
    self.cMobileNo = aDecoder.decodeObject(forKey: SerializationKeys.cMobileNo) as? String
    self.cAreaCode = aDecoder.decodeObject(forKey: SerializationKeys.cAreaCode) as? String
    self.cItPanNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cItPanNoImg) as? String
    self.cPartnershipDeedImg = aDecoder.decodeObject(forKey: SerializationKeys.cPartnershipDeedImg) as? String
    self.cDruglicenseNo1 = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo1) as? String
    self.cNarcoticNoImg = aDecoder.decodeObject(forKey: SerializationKeys.cNarcoticNoImg) as? String
    self.cDrugLicenseNo3ExpiryDate = aDecoder.decodeObject(forKey: SerializationKeys.cDrugLicenseNo3ExpiryDate) as? String
    self.cFirmContactPerson = aDecoder.decodeObject(forKey: SerializationKeys.cFirmContactPerson) as? String
    self.cDruglicenseNo2Img = aDecoder.decodeObject(forKey: SerializationKeys.cDruglicenseNo2Img) as? String
    self.cStateCode = aDecoder.decodeObject(forKey: SerializationKeys.cStateCode) as? String
    self.cRentAgreement = aDecoder.decodeObject(forKey: SerializationKeys.cRentAgreement) as? String
    self.cElectricityBill = aDecoder.decodeObject(forKey: SerializationKeys.cElectricityBill) as? String
    self.cPartnershipDeed = aDecoder.decodeObject(forKey: SerializationKeys.cPartnershipDeed) as? String
    self.cRentAgreementImg = aDecoder.decodeObject(forKey: SerializationKeys.cRentAgreementImg) as? String
    self.cName = aDecoder.decodeObject(forKey: SerializationKeys.cName) as? String
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cAuthorityLetterImg = aDecoder.decodeObject(forKey: SerializationKeys.cAuthorityLetterImg) as? String
    self.cGstNo = aDecoder.decodeObject(forKey: SerializationKeys.cGstNo) as? String
    self.cNarcoticNo = aDecoder.decodeObject(forKey: SerializationKeys.cNarcoticNo) as? String
    self.cEmail = aDecoder.decodeObject(forKey: SerializationKeys.cEmail) as? String
    self.cCityCode = aDecoder.decodeObject(forKey: SerializationKeys.cCityCode) as? String
    self.cImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.cImageUrl) as? String
    self.cGstType = aDecoder.decodeObject(forKey: SerializationKeys.cGstType) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cElectricityBillImg, forKey: SerializationKeys.cElectricityBillImg)
    aCoder.encode(cTanNo, forKey: SerializationKeys.cTanNo)
    aCoder.encode(cDruglicenseNo2, forKey: SerializationKeys.cDruglicenseNo2)
    aCoder.encode(cTanNoImg, forKey: SerializationKeys.cTanNoImg)
    aCoder.encode(cAuthorityLetter, forKey: SerializationKeys.cAuthorityLetter)
    aCoder.encode(cBankStatementImg, forKey: SerializationKeys.cBankStatementImg)
    aCoder.encode(cDruglicenseNo3Img, forKey: SerializationKeys.cDruglicenseNo3Img)
    aCoder.encode(cC2code, forKey: SerializationKeys.cC2code)
    aCoder.encode(cBankStatement, forKey: SerializationKeys.cBankStatement)
    aCoder.encode(cDrugLicenseNo2ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo2ExpiryDate)
    aCoder.encode(cFirmAddress2, forKey: SerializationKeys.cFirmAddress2)
    aCoder.encode(cDrugLicenseNo1ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo1ExpiryDate)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
    aCoder.encode(cStatus, forKey: SerializationKeys.cStatus)
    aCoder.encode(cLandmark, forKey: SerializationKeys.cLandmark)
    aCoder.encode(cPanNoImg, forKey: SerializationKeys.cPanNoImg)
    aCoder.encode(cItPanNo, forKey: SerializationKeys.cItPanNo)
    aCoder.encode(cFirmAddress1, forKey: SerializationKeys.cFirmAddress1)
    aCoder.encode(cDruglicenseNo1Img, forKey: SerializationKeys.cDruglicenseNo1Img)
    aCoder.encode(cType, forKey: SerializationKeys.cType)
    aCoder.encode(cPincode, forKey: SerializationKeys.cPincode)
    aCoder.encode(cDruglicenseNo3, forKey: SerializationKeys.cDruglicenseNo3)
    aCoder.encode(cPanNo, forKey: SerializationKeys.cPanNo)
    aCoder.encode(cMobileNo, forKey: SerializationKeys.cMobileNo)
    aCoder.encode(cAreaCode, forKey: SerializationKeys.cAreaCode)
    aCoder.encode(cItPanNoImg, forKey: SerializationKeys.cItPanNoImg)
    aCoder.encode(cPartnershipDeedImg, forKey: SerializationKeys.cPartnershipDeedImg)
    aCoder.encode(cDruglicenseNo1, forKey: SerializationKeys.cDruglicenseNo1)
    aCoder.encode(cNarcoticNoImg, forKey: SerializationKeys.cNarcoticNoImg)
    aCoder.encode(cDrugLicenseNo3ExpiryDate, forKey: SerializationKeys.cDrugLicenseNo3ExpiryDate)
    aCoder.encode(cFirmContactPerson, forKey: SerializationKeys.cFirmContactPerson)
    aCoder.encode(cDruglicenseNo2Img, forKey: SerializationKeys.cDruglicenseNo2Img)
    aCoder.encode(cStateCode, forKey: SerializationKeys.cStateCode)
    aCoder.encode(cRentAgreement, forKey: SerializationKeys.cRentAgreement)
    aCoder.encode(cElectricityBill, forKey: SerializationKeys.cElectricityBill)
    aCoder.encode(cPartnershipDeed, forKey: SerializationKeys.cPartnershipDeed)
    aCoder.encode(cRentAgreementImg, forKey: SerializationKeys.cRentAgreementImg)
    aCoder.encode(cName, forKey: SerializationKeys.cName)
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cAuthorityLetterImg, forKey: SerializationKeys.cAuthorityLetterImg)
    aCoder.encode(cGstNo, forKey: SerializationKeys.cGstNo)
    aCoder.encode(cNarcoticNo, forKey: SerializationKeys.cNarcoticNo)
    aCoder.encode(cEmail, forKey: SerializationKeys.cEmail)
    aCoder.encode(cCityCode, forKey: SerializationKeys.cCityCode)
    aCoder.encode(cImageUrl, forKey: SerializationKeys.cImageUrl)
    aCoder.encode(cGstType, forKey: SerializationKeys.cGstType)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
  }

}
