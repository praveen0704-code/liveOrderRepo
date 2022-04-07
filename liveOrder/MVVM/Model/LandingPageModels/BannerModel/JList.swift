//
//  JList.swift
//
//  Created by PraveenMac on 30/09/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class JList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cBannerId = "c_banner_id"
    static let cBannerImageUrl = "c_banner_image_url"
    static let cRedirectUrl = "c_redirect_url"
    static let cType = "c_type"
  }

  // MARK: Properties
  public var cBannerId: String?
  public var cBannerImageUrl: String?
  public var cRedirectUrl: String?
  public var cType: String?

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
    cBannerId = json[SerializationKeys.cBannerId].string
    cBannerImageUrl = json[SerializationKeys.cBannerImageUrl].string
    cRedirectUrl = json[SerializationKeys.cRedirectUrl].string
    cType = json[SerializationKeys.cType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cBannerId { dictionary[SerializationKeys.cBannerId] = value }
    if let value = cBannerImageUrl { dictionary[SerializationKeys.cBannerImageUrl] = value }
    if let value = cRedirectUrl { dictionary[SerializationKeys.cRedirectUrl] = value }
    if let value = cType { dictionary[SerializationKeys.cType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cBannerId = aDecoder.decodeObject(forKey: SerializationKeys.cBannerId) as? String
    self.cBannerImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.cBannerImageUrl) as? String
    self.cRedirectUrl = aDecoder.decodeObject(forKey: SerializationKeys.cRedirectUrl) as? String
    self.cType = aDecoder.decodeObject(forKey: SerializationKeys.cType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cBannerId, forKey: SerializationKeys.cBannerId)
    aCoder.encode(cBannerImageUrl, forKey: SerializationKeys.cBannerImageUrl)
    aCoder.encode(cRedirectUrl, forKey: SerializationKeys.cRedirectUrl)
    aCoder.encode(cType, forKey: SerializationKeys.cType)
  }

}
