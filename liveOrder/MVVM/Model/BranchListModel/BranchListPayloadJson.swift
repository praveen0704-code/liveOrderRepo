//
//  PayloadJson.swift
//
//  Created by PraveenMac on 27/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BranchListPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let bItems = "items"
    static let page = "page"
  }

  // MARK: Properties
  public var bItems: [BranchListItems]?
  public var page: BranchListPage?

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
    if let items = json[SerializationKeys.bItems].array { bItems = items.map { BranchListItems(json: $0) } }
    page = BranchListPage(json: json[SerializationKeys.page])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = bItems { dictionary[SerializationKeys.bItems] = value.map { $0.dictionaryRepresentation() } }
    if let value = page { dictionary[SerializationKeys.page] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.bItems = aDecoder.decodeObject(forKey: SerializationKeys.bItems) as? [BranchListItems]
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? BranchListPage
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(bItems, forKey: SerializationKeys.bItems)
    aCoder.encode(page, forKey: SerializationKeys.page)
  }

}
