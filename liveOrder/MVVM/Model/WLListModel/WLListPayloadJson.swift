//
//  PayloadJson.swift
//
//  Created by Data Prime on 27/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class WLListPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let data = "data"
    static let nTotal = "n_total"
    static let nNextPage = "n_next_page"
  }

  // MARK: Properties
  public var data: [WLListData]?
  public var nTotal: Int?
  public var nNextPage: Int?

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
    if let items = json[SerializationKeys.data].array { data = items.map { WLListData(json: $0) } }
    nTotal = json[SerializationKeys.nTotal].int
    nNextPage = json[SerializationKeys.nNextPage].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = nTotal { dictionary[SerializationKeys.nTotal] = value }
    if let value = nNextPage { dictionary[SerializationKeys.nNextPage] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [WLListData]
    self.nTotal = aDecoder.decodeObject(forKey: SerializationKeys.nTotal) as? Int
    self.nNextPage = aDecoder.decodeObject(forKey: SerializationKeys.nNextPage) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(nTotal, forKey: SerializationKeys.nTotal)
    aCoder.encode(nNextPage, forKey: SerializationKeys.nNextPage)
  }

}
