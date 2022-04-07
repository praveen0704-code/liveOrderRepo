//
//  BaseClass.swift
//
//  Created by PraveenMac on 18/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AWBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let payloadClass = "payloadClass"
    static let messages = "messages"
    static let requestId = "requestId"
    static let appStatusCode = "appStatusCode"
    static let apiCall = "apiCall"
  }

  // MARK: Properties
  public var payloadClass: String?
  public var messages: [String]?
  public var requestId: String?
  public var appStatusCode: Int?
  public var apiCall: String?

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
    payloadClass = json[SerializationKeys.payloadClass].string
    if let items = json[SerializationKeys.messages].array { messages = items.map { $0.stringValue } }
    requestId = json[SerializationKeys.requestId].string
    appStatusCode = json[SerializationKeys.appStatusCode].int
    apiCall = json[SerializationKeys.apiCall].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = payloadClass { dictionary[SerializationKeys.payloadClass] = value }
    if let value = messages { dictionary[SerializationKeys.messages] = value }
    if let value = requestId { dictionary[SerializationKeys.requestId] = value }
    if let value = appStatusCode { dictionary[SerializationKeys.appStatusCode] = value }
    if let value = apiCall { dictionary[SerializationKeys.apiCall] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.payloadClass = aDecoder.decodeObject(forKey: SerializationKeys.payloadClass) as? String
    self.messages = aDecoder.decodeObject(forKey: SerializationKeys.messages) as? [String]
    self.requestId = aDecoder.decodeObject(forKey: SerializationKeys.requestId) as? String
    self.appStatusCode = aDecoder.decodeObject(forKey: SerializationKeys.appStatusCode) as? Int
    self.apiCall = aDecoder.decodeObject(forKey: SerializationKeys.apiCall) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(payloadClass, forKey: SerializationKeys.payloadClass)
    aCoder.encode(messages, forKey: SerializationKeys.messages)
    aCoder.encode(requestId, forKey: SerializationKeys.requestId)
    aCoder.encode(appStatusCode, forKey: SerializationKeys.appStatusCode)
    aCoder.encode(apiCall, forKey: SerializationKeys.apiCall)
  }

}
