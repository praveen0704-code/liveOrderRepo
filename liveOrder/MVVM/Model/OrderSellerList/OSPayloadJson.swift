//
//  PayloadJson.swift
//
//  Created by PraveenMac on 29/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class OSPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let page = "page"
    static let data = "data"
  }

  // MARK: Properties
  public var page: OSPage?
  public var data: [OSData]?

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
    page = OSPage(json: json[SerializationKeys.page])
    if let items = json[SerializationKeys.data].array { data = items.map { OSData(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = page { dictionary[SerializationKeys.page] = value.dictionaryRepresentation() }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? OSPage
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [OSData]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(data, forKey: SerializationKeys.data)
  }

}
