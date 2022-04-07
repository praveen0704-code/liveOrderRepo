//
//  Data.swift
//
//  Created by Data Prime on 24/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PinWiseStateData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cCityName = "c_city_name"
    static let cStateCode = "c_state_code"
    static let cStateName = "c_state_name"
    static let jAreaList = "j_area_list"
    static let cCityCode = "c_city_code"
  }

  // MARK: Properties
  public var cCityName: String?
  public var cStateCode: String?
  public var cStateName: String?
  public var jAreaList: [PinWiseStateJAreaList]?
  public var cCityCode: String?

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
    cCityName = json[SerializationKeys.cCityName].string
    cStateCode = json[SerializationKeys.cStateCode].string
    cStateName = json[SerializationKeys.cStateName].string
    if let items = json[SerializationKeys.jAreaList].array { jAreaList = items.map { PinWiseStateJAreaList(json: $0) } }
    cCityCode = json[SerializationKeys.cCityCode].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cCityName { dictionary[SerializationKeys.cCityName] = value }
    if let value = cStateCode { dictionary[SerializationKeys.cStateCode] = value }
    if let value = cStateName { dictionary[SerializationKeys.cStateName] = value }
    if let value = jAreaList { dictionary[SerializationKeys.jAreaList] = value.map { $0.dictionaryRepresentation() } }
    if let value = cCityCode { dictionary[SerializationKeys.cCityCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cCityName = aDecoder.decodeObject(forKey: SerializationKeys.cCityName) as? String
    self.cStateCode = aDecoder.decodeObject(forKey: SerializationKeys.cStateCode) as? String
    self.cStateName = aDecoder.decodeObject(forKey: SerializationKeys.cStateName) as? String
    self.jAreaList = aDecoder.decodeObject(forKey: SerializationKeys.jAreaList) as? [PinWiseStateJAreaList]
    self.cCityCode = aDecoder.decodeObject(forKey: SerializationKeys.cCityCode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cCityName, forKey: SerializationKeys.cCityName)
    aCoder.encode(cStateCode, forKey: SerializationKeys.cStateCode)
    aCoder.encode(cStateName, forKey: SerializationKeys.cStateName)
    aCoder.encode(jAreaList, forKey: SerializationKeys.jAreaList)
    aCoder.encode(cCityCode, forKey: SerializationKeys.cCityCode)
  }

}
