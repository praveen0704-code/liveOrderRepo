//
//  Data.swift
//
//  Created by PraveenMac on 22/03/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DistributerData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let jEmailId = "j_email_id"
    static let cDistributorName = "c_distributor_name"
    static let cDistributorId = "c_distributor_id"
  }

  // MARK: Properties
  public var jEmailId: [String]?
  public var cDistributorName: String?
  public var cDistributorId: String?

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
    if let items = json[SerializationKeys.jEmailId].array { jEmailId = items.map { $0.stringValue } }
    cDistributorName = json[SerializationKeys.cDistributorName].string
    cDistributorId = json[SerializationKeys.cDistributorId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = jEmailId { dictionary[SerializationKeys.jEmailId] = value }
    if let value = cDistributorName { dictionary[SerializationKeys.cDistributorName] = value }
    if let value = cDistributorId { dictionary[SerializationKeys.cDistributorId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.jEmailId = aDecoder.decodeObject(forKey: SerializationKeys.jEmailId) as? [String]
    self.cDistributorName = aDecoder.decodeObject(forKey: SerializationKeys.cDistributorName) as? String
    self.cDistributorId = aDecoder.decodeObject(forKey: SerializationKeys.cDistributorId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(jEmailId, forKey: SerializationKeys.jEmailId)
    aCoder.encode(cDistributorName, forKey: SerializationKeys.cDistributorName)
    aCoder.encode(cDistributorId, forKey: SerializationKeys.cDistributorId)
  }

}
