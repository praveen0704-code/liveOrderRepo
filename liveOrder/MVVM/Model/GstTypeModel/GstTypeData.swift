//
//  Data.swift
//
//  Created by Data Prime on 26/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GstTypeData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let nId = "n_id"
    static let cGstType = "c_gst_type"
  }

  // MARK: Properties
  public var nId: Int?
  public var cGstType: String?

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
    nId = json[SerializationKeys.nId].int
    cGstType = json[SerializationKeys.cGstType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = nId { dictionary[SerializationKeys.nId] = value }
    if let value = cGstType { dictionary[SerializationKeys.cGstType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.nId = aDecoder.decodeObject(forKey: SerializationKeys.nId) as? Int
    self.cGstType = aDecoder.decodeObject(forKey: SerializationKeys.cGstType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(nId, forKey: SerializationKeys.nId)
    aCoder.encode(cGstType, forKey: SerializationKeys.cGstType)
  }

}
