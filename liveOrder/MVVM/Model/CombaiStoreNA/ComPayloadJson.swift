//
//  PayloadJson.swift
//
//  Created by PraveenMac on 19/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ComPayloadJson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let jRegister = "j_register"
    static let jStore = "j_store"
  }

  // MARK: Properties
  public var jRegister: ComJRegister?
  public var jStore: ComJStore?

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
    jRegister = ComJRegister(json: json[SerializationKeys.jRegister])
    jStore = ComJStore(json: json[SerializationKeys.jStore])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = jRegister { dictionary[SerializationKeys.jRegister] = value.dictionaryRepresentation() }
    if let value = jStore { dictionary[SerializationKeys.jStore] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.jRegister = aDecoder.decodeObject(forKey: SerializationKeys.jRegister) as? ComJRegister
    self.jStore = aDecoder.decodeObject(forKey: SerializationKeys.jStore) as? ComJStore
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(jRegister, forKey: SerializationKeys.jRegister)
    aCoder.encode(jStore, forKey: SerializationKeys.jStore)
  }

}
