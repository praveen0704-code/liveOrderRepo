//
//  Data.swift
//
//  Created by PraveenMac on 29/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CASaveData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cUpdateStatus = "c_update_status"
    static let cStoreCombineStatus = "c_store_combine_status"
    static let cLcUserStatus = "c_lc_user_status"
    static let cLcUserActiveStatus = "c_lc_user_active_status"
    static let jRegister = "j_register"
  }

  // MARK: Properties
  public var cUpdateStatus: String?
  public var cStoreCombineStatus: String?
  public var cLcUserStatus: String?
  public var cLcUserActiveStatus: String?
  public var jRegister: CASaveJRegister?

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
    cUpdateStatus = json[SerializationKeys.cUpdateStatus].string
    cStoreCombineStatus = json[SerializationKeys.cStoreCombineStatus].string
    cLcUserStatus = json[SerializationKeys.cLcUserStatus].string
    cLcUserActiveStatus = json[SerializationKeys.cLcUserActiveStatus].string
    jRegister = CASaveJRegister(json: json[SerializationKeys.jRegister])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cUpdateStatus { dictionary[SerializationKeys.cUpdateStatus] = value }
    if let value = cStoreCombineStatus { dictionary[SerializationKeys.cStoreCombineStatus] = value }
    if let value = cLcUserStatus { dictionary[SerializationKeys.cLcUserStatus] = value }
    if let value = cLcUserActiveStatus { dictionary[SerializationKeys.cLcUserActiveStatus] = value }
    if let value = jRegister { dictionary[SerializationKeys.jRegister] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cUpdateStatus = aDecoder.decodeObject(forKey: SerializationKeys.cUpdateStatus) as? String
    self.cStoreCombineStatus = aDecoder.decodeObject(forKey: SerializationKeys.cStoreCombineStatus) as? String
    self.cLcUserStatus = aDecoder.decodeObject(forKey: SerializationKeys.cLcUserStatus) as? String
    self.cLcUserActiveStatus = aDecoder.decodeObject(forKey: SerializationKeys.cLcUserActiveStatus) as? String
    self.jRegister = aDecoder.decodeObject(forKey: SerializationKeys.jRegister) as? CASaveJRegister
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cUpdateStatus, forKey: SerializationKeys.cUpdateStatus)
    aCoder.encode(cStoreCombineStatus, forKey: SerializationKeys.cStoreCombineStatus)
    aCoder.encode(cLcUserStatus, forKey: SerializationKeys.cLcUserStatus)
    aCoder.encode(cLcUserActiveStatus, forKey: SerializationKeys.cLcUserActiveStatus)
    aCoder.encode(jRegister, forKey: SerializationKeys.jRegister)
  }

}
