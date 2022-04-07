//
//  JList.swift
//
//  Created by Data Prime on 27/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class FiltterMfcJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cMfcName = "c_mfc_name"
    static let cMfcCode = "c_mfc_code"
  }

  // MARK: Properties
  public var cMfcName: String?
  public var cMfcCode: String?

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
    cMfcName = json[SerializationKeys.cMfcName].string
    cMfcCode = json[SerializationKeys.cMfcCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cMfcName { dictionary[SerializationKeys.cMfcName] = value }
    if let value = cMfcCode { dictionary[SerializationKeys.cMfcCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cMfcName = aDecoder.decodeObject(forKey: SerializationKeys.cMfcName) as? String
    self.cMfcCode = aDecoder.decodeObject(forKey: SerializationKeys.cMfcCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cMfcName, forKey: SerializationKeys.cMfcName)
    aCoder.encode(cMfcCode, forKey: SerializationKeys.cMfcCode)
  }

}
