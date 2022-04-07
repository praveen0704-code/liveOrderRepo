//
//  JMolecules.swift
//
//  Created by Data Prime on 04/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PDPJMolecules: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cDescription = "c_description"
    static let cUsage = "c_usage"
    static let cSideEffect = "c_side_effect"
    static let cMoleculeCode = "c_molecule_code"
    static let cNote = "c_note"
    static let cMoleculeName = "c_molecule_name"
    static let cContraIndications = "c_contra_indications"
  }

  // MARK: Properties
  public var cDescription: String?
  public var cUsage: String?
  public var cSideEffect: String?
  public var cMoleculeCode: String?
  public var cNote: String?
  public var cMoleculeName: String?
  public var cContraIndications: String?

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
    cDescription = json[SerializationKeys.cDescription].string
    cUsage = json[SerializationKeys.cUsage].string
    cSideEffect = json[SerializationKeys.cSideEffect].string
    cMoleculeCode = json[SerializationKeys.cMoleculeCode].string
    cNote = json[SerializationKeys.cNote].string
    cMoleculeName = json[SerializationKeys.cMoleculeName].string
    cContraIndications = json[SerializationKeys.cContraIndications].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cDescription { dictionary[SerializationKeys.cDescription] = value }
    if let value = cUsage { dictionary[SerializationKeys.cUsage] = value }
    if let value = cSideEffect { dictionary[SerializationKeys.cSideEffect] = value }
    if let value = cMoleculeCode { dictionary[SerializationKeys.cMoleculeCode] = value }
    if let value = cNote { dictionary[SerializationKeys.cNote] = value }
    if let value = cMoleculeName { dictionary[SerializationKeys.cMoleculeName] = value }
    if let value = cContraIndications { dictionary[SerializationKeys.cContraIndications] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cDescription = aDecoder.decodeObject(forKey: SerializationKeys.cDescription) as? String
    self.cUsage = aDecoder.decodeObject(forKey: SerializationKeys.cUsage) as? String
    self.cSideEffect = aDecoder.decodeObject(forKey: SerializationKeys.cSideEffect) as? String
    self.cMoleculeCode = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeCode) as? String
    self.cNote = aDecoder.decodeObject(forKey: SerializationKeys.cNote) as? String
    self.cMoleculeName = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeName) as? String
    self.cContraIndications = aDecoder.decodeObject(forKey: SerializationKeys.cContraIndications) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cDescription, forKey: SerializationKeys.cDescription)
    aCoder.encode(cUsage, forKey: SerializationKeys.cUsage)
    aCoder.encode(cSideEffect, forKey: SerializationKeys.cSideEffect)
    aCoder.encode(cMoleculeCode, forKey: SerializationKeys.cMoleculeCode)
    aCoder.encode(cNote, forKey: SerializationKeys.cNote)
    aCoder.encode(cMoleculeName, forKey: SerializationKeys.cMoleculeName)
    aCoder.encode(cContraIndications, forKey: SerializationKeys.cContraIndications)
  }

}
