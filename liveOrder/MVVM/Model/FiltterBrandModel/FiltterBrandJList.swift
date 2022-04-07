//
//  JList.swift
//
//  Created by Data Prime on 27/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class FiltterBrandJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cBrandCode = "c_brand_code"
    static let cBrandName = "c_brand_name"
  }

  // MARK: Properties
  public var cBrandCode: String?
  public var cBrandName: String?

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
    cBrandCode = json[SerializationKeys.cBrandCode].string
    cBrandName = json[SerializationKeys.cBrandName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cBrandCode { dictionary[SerializationKeys.cBrandCode] = value }
    if let value = cBrandName { dictionary[SerializationKeys.cBrandName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cBrandCode = aDecoder.decodeObject(forKey: SerializationKeys.cBrandCode) as? String
    self.cBrandName = aDecoder.decodeObject(forKey: SerializationKeys.cBrandName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cBrandCode, forKey: SerializationKeys.cBrandCode)
    aCoder.encode(cBrandName, forKey: SerializationKeys.cBrandName)
  }

}
