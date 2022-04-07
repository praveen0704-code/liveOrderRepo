//
//  Data.swift
//
//  Created by Data Prime on 24/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class WLItemCodeData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cItemCode = "c_item_code"
  }

  // MARK: Properties
  public var cItemCode: String?

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
    cItemCode = json[SerializationKeys.cItemCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
  }

}
