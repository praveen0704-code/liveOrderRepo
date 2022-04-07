//
//  JList.swift
//
//  Created by Data Prime on 14/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class searchMoleculeJList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cMoleculeName = "c_molecule_name"
    static let cMoleculeCode = "c_molecule_code"
  }

  // MARK: Properties
  public var cMoleculeName: String?
  public var cMoleculeCode: String?

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
    cMoleculeName = json[SerializationKeys.cMoleculeName].string
    cMoleculeCode = json[SerializationKeys.cMoleculeCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cMoleculeName { dictionary[SerializationKeys.cMoleculeName] = value }
    if let value = cMoleculeCode { dictionary[SerializationKeys.cMoleculeCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cMoleculeName = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeName) as? String
    self.cMoleculeCode = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cMoleculeName, forKey: SerializationKeys.cMoleculeName)
    aCoder.encode(cMoleculeCode, forKey: SerializationKeys.cMoleculeCode)
  }

}
