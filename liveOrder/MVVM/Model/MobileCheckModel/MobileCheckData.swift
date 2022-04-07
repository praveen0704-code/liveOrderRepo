//
//  Data.swift
//
//  Created by Data Prime on 23/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MobileCheckData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cMobileNo = "c_mobile_no"
    static let cType = "c_type"
  }

  // MARK: Properties
  public var cMobileNo: String?
  public var cType: String?

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
    cMobileNo = json[SerializationKeys.cMobileNo].string
    cType = json[SerializationKeys.cType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cMobileNo { dictionary[SerializationKeys.cMobileNo] = value }
    if let value = cType { dictionary[SerializationKeys.cType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cMobileNo = aDecoder.decodeObject(forKey: SerializationKeys.cMobileNo) as? String
    self.cType = aDecoder.decodeObject(forKey: SerializationKeys.cType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cMobileNo, forKey: SerializationKeys.cMobileNo)
    aCoder.encode(cType, forKey: SerializationKeys.cType)
  }

}
