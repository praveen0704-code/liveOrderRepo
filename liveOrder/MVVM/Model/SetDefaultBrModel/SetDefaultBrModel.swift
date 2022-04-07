//
//  SetDefaultBrModel.swift
//
//  Created by Data Prime on 23/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SetDefaultBrModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let payloadJson = "payloadJson"
    static let headers = "headers"
    static let messages = "messages"
    static let apiCall = "apiCall"
    static let appStatusCode = "appStatusCode"
    static let payloadClass = "payloadClass"
    static let requestId = "requestId"
  }

  // MARK: Properties
  public var payloadJson: PayloadJson?
  public var headers: Headers?
  public var messages: [String]?
  public var apiCall: String?
  public var appStatusCode: Int?
  public var payloadClass: String?
  public var requestId: String?

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
    payloadJson = PayloadJson(json: json[SerializationKeys.payloadJson])
    headers = Headers(json: json[SerializationKeys.headers])
    if let items = json[SerializationKeys.messages].array { messages = items.map { $0.stringValue } }
    apiCall = json[SerializationKeys.apiCall].string
    appStatusCode = json[SerializationKeys.appStatusCode].int
    payloadClass = json[SerializationKeys.payloadClass].string
    requestId = json[SerializationKeys.requestId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = payloadJson { dictionary[SerializationKeys.payloadJson] = value.dictionaryRepresentation() }
    if let value = headers { dictionary[SerializationKeys.headers] = value.dictionaryRepresentation() }
    if let value = messages { dictionary[SerializationKeys.messages] = value }
    if let value = apiCall { dictionary[SerializationKeys.apiCall] = value }
    if let value = appStatusCode { dictionary[SerializationKeys.appStatusCode] = value }
    if let value = payloadClass { dictionary[SerializationKeys.payloadClass] = value }
    if let value = requestId { dictionary[SerializationKeys.requestId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.payloadJson = aDecoder.decodeObject(forKey: SerializationKeys.payloadJson) as? PayloadJson
    self.headers = aDecoder.decodeObject(forKey: SerializationKeys.headers) as? Headers
    self.messages = aDecoder.decodeObject(forKey: SerializationKeys.messages) as? [String]
    self.apiCall = aDecoder.decodeObject(forKey: SerializationKeys.apiCall) as? String
    self.appStatusCode = aDecoder.decodeObject(forKey: SerializationKeys.appStatusCode) as? Int
    self.payloadClass = aDecoder.decodeObject(forKey: SerializationKeys.payloadClass) as? String
    self.requestId = aDecoder.decodeObject(forKey: SerializationKeys.requestId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(payloadJson, forKey: SerializationKeys.payloadJson)
    aCoder.encode(headers, forKey: SerializationKeys.headers)
    aCoder.encode(messages, forKey: SerializationKeys.messages)
    aCoder.encode(apiCall, forKey: SerializationKeys.apiCall)
    aCoder.encode(appStatusCode, forKey: SerializationKeys.appStatusCode)
    aCoder.encode(payloadClass, forKey: SerializationKeys.payloadClass)
    aCoder.encode(requestId, forKey: SerializationKeys.requestId)
  }

}
