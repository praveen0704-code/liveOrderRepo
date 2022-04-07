//
//  Molecules.swift
//
//  Created by Data Prime on 14/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ItemByMolCodeMolecules: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cAntidote = "c_antidote"
    static let cDrugName = "c_drug_name"
    static let cDosageForms = "c_dosage_forms"
    static let cAvailableDoses = "c_available_doses"
    static let cIndications = "c_indications"
    static let cContraindications = "c_contraindications"
    static let cSchedule = "c_schedule"
    static let cMoleculeCode = "c_molecule_code"
    static let cTherapeuticClass = "c_therapeutic_class"
    static let cMoleculeName = "c_molecule_name"
    static let cPregnancyCategory = "c_pregnancy_category"
    static let cReferences = "c_references"
  }

  // MARK: Properties
  public var cAntidote: String?
  public var cDrugName: String?
  public var cDosageForms: String?
  public var cAvailableDoses: String?
  public var cIndications: String?
  public var cContraindications: String?
  public var cSchedule: String?
  public var cMoleculeCode: String?
  public var cTherapeuticClass: String?
  public var cMoleculeName: String?
  public var cPregnancyCategory: String?
  public var cReferences: String?

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
    cAntidote = json[SerializationKeys.cAntidote].string
    cDrugName = json[SerializationKeys.cDrugName].string
    cDosageForms = json[SerializationKeys.cDosageForms].string
    cAvailableDoses = json[SerializationKeys.cAvailableDoses].string
    cIndications = json[SerializationKeys.cIndications].string
    cContraindications = json[SerializationKeys.cContraindications].string
    cSchedule = json[SerializationKeys.cSchedule].string
    cMoleculeCode = json[SerializationKeys.cMoleculeCode].string
    cTherapeuticClass = json[SerializationKeys.cTherapeuticClass].string
    cMoleculeName = json[SerializationKeys.cMoleculeName].string
    cPregnancyCategory = json[SerializationKeys.cPregnancyCategory].string
    cReferences = json[SerializationKeys.cReferences].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cAntidote { dictionary[SerializationKeys.cAntidote] = value }
    if let value = cDrugName { dictionary[SerializationKeys.cDrugName] = value }
    if let value = cDosageForms { dictionary[SerializationKeys.cDosageForms] = value }
    if let value = cAvailableDoses { dictionary[SerializationKeys.cAvailableDoses] = value }
    if let value = cIndications { dictionary[SerializationKeys.cIndications] = value }
    if let value = cContraindications { dictionary[SerializationKeys.cContraindications] = value }
    if let value = cSchedule { dictionary[SerializationKeys.cSchedule] = value }
    if let value = cMoleculeCode { dictionary[SerializationKeys.cMoleculeCode] = value }
    if let value = cTherapeuticClass { dictionary[SerializationKeys.cTherapeuticClass] = value }
    if let value = cMoleculeName { dictionary[SerializationKeys.cMoleculeName] = value }
    if let value = cPregnancyCategory { dictionary[SerializationKeys.cPregnancyCategory] = value }
    if let value = cReferences { dictionary[SerializationKeys.cReferences] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cAntidote = aDecoder.decodeObject(forKey: SerializationKeys.cAntidote) as? String
    self.cDrugName = aDecoder.decodeObject(forKey: SerializationKeys.cDrugName) as? String
    self.cDosageForms = aDecoder.decodeObject(forKey: SerializationKeys.cDosageForms) as? String
    self.cAvailableDoses = aDecoder.decodeObject(forKey: SerializationKeys.cAvailableDoses) as? String
    self.cIndications = aDecoder.decodeObject(forKey: SerializationKeys.cIndications) as? String
    self.cContraindications = aDecoder.decodeObject(forKey: SerializationKeys.cContraindications) as? String
    self.cSchedule = aDecoder.decodeObject(forKey: SerializationKeys.cSchedule) as? String
    self.cMoleculeCode = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeCode) as? String
    self.cTherapeuticClass = aDecoder.decodeObject(forKey: SerializationKeys.cTherapeuticClass) as? String
    self.cMoleculeName = aDecoder.decodeObject(forKey: SerializationKeys.cMoleculeName) as? String
    self.cPregnancyCategory = aDecoder.decodeObject(forKey: SerializationKeys.cPregnancyCategory) as? String
    self.cReferences = aDecoder.decodeObject(forKey: SerializationKeys.cReferences) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cAntidote, forKey: SerializationKeys.cAntidote)
    aCoder.encode(cDrugName, forKey: SerializationKeys.cDrugName)
    aCoder.encode(cDosageForms, forKey: SerializationKeys.cDosageForms)
    aCoder.encode(cAvailableDoses, forKey: SerializationKeys.cAvailableDoses)
    aCoder.encode(cIndications, forKey: SerializationKeys.cIndications)
    aCoder.encode(cContraindications, forKey: SerializationKeys.cContraindications)
    aCoder.encode(cSchedule, forKey: SerializationKeys.cSchedule)
    aCoder.encode(cMoleculeCode, forKey: SerializationKeys.cMoleculeCode)
    aCoder.encode(cTherapeuticClass, forKey: SerializationKeys.cTherapeuticClass)
    aCoder.encode(cMoleculeName, forKey: SerializationKeys.cMoleculeName)
    aCoder.encode(cPregnancyCategory, forKey: SerializationKeys.cPregnancyCategory)
    aCoder.encode(cReferences, forKey: SerializationKeys.cReferences)
  }

}
