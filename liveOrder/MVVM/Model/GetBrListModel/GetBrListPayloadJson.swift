//
//  PayloadJson.swift
//
//  Created by Data Prime on 22/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GetBrListPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let items = "items"
    static let page = "page"
  }

  // MARK: Properties
  public var items: [GetBrListItems]?
  public var page: GetBrListPage?

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
      if let item = json[SerializationKeys.items].array { items = item.map { GetBrListItems(json: $0) } }
    page = GetBrListPage(json: json[SerializationKeys.page])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = items { dictionary[SerializationKeys.items] = value.map { $0.dictionaryRepresentation() } }
    if let value = page { dictionary[SerializationKeys.page] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.items = aDecoder.decodeObject(forKey: SerializationKeys.items) as? [GetBrListItems]
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? GetBrListPage
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(items, forKey: SerializationKeys.items)
    aCoder.encode(page, forKey: SerializationKeys.page)
  }

}
