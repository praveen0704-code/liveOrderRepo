//
//  JAreaList.swift
//
//  Created by Data Prime on 24/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PinWiseStateJAreaList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cAreaCode = "c_area_code"
    static let cAreaName = "c_area_name"
  }

  // MARK: Properties
  public var cAreaCode: String?
  public var cAreaName: String?

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
    cAreaName = json[SerializationKeys.cAreaName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cAreaCode { dictionary[SerializationKeys.cAreaCode] = value }
    if let value = cAreaName { dictionary[SerializationKeys.cAreaName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cAreaCode = aDecoder.decodeObject(forKey: SerializationKeys.cAreaCode) as? String
    self.cAreaName = aDecoder.decodeObject(forKey: SerializationKeys.cAreaName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cAreaCode, forKey: SerializationKeys.cAreaCode)
    aCoder.encode(cAreaName, forKey: SerializationKeys.cAreaName)
  }

}
