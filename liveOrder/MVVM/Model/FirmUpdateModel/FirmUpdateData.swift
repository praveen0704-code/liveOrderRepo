//
//  Data.swift
//
//  Created by Data Prime on 03/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class FirmUpdateData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cStoreCombineStatus = "c_store_combine_status"
    static let cLcUserActiveStatus = "c_lc_user_active_status"
    static let cUpdateStatus = "c_update_status"
  }

  // MARK: Properties
  public var cStoreCombineStatus: String?
  public var cLcUserActiveStatus: String?
  public var cUpdateStatus: String?

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
    cStoreCombineStatus = json[SerializationKeys.cStoreCombineStatus].string
    cLcUserActiveStatus = json[SerializationKeys.cLcUserActiveStatus].string
    cUpdateStatus = json[SerializationKeys.cUpdateStatus].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cStoreCombineStatus { dictionary[SerializationKeys.cStoreCombineStatus] = value }
    if let value = cLcUserActiveStatus { dictionary[SerializationKeys.cLcUserActiveStatus] = value }
    if let value = cUpdateStatus { dictionary[SerializationKeys.cUpdateStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cStoreCombineStatus = aDecoder.decodeObject(forKey: SerializationKeys.cStoreCombineStatus) as? String
    self.cLcUserActiveStatus = aDecoder.decodeObject(forKey: SerializationKeys.cLcUserActiveStatus) as? String
    self.cUpdateStatus = aDecoder.decodeObject(forKey: SerializationKeys.cUpdateStatus) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cStoreCombineStatus, forKey: SerializationKeys.cStoreCombineStatus)
    aCoder.encode(cLcUserActiveStatus, forKey: SerializationKeys.cLcUserActiveStatus)
    aCoder.encode(cUpdateStatus, forKey: SerializationKeys.cUpdateStatus)
  }

}
