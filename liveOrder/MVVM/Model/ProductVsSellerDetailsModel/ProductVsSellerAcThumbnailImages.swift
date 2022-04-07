//
//  AcThumbnailImages.swift
//
//  Created by PraveenMac on 27/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductVsSellerAcThumbnailImages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cThumbnailImage = "c_thumbnail_image"
  }

  // MARK: Properties
  public var cThumbnailImage: String?

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
    cThumbnailImage = json[SerializationKeys.cThumbnailImage].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cThumbnailImage { dictionary[SerializationKeys.cThumbnailImage] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cThumbnailImage = aDecoder.decodeObject(forKey: SerializationKeys.cThumbnailImage) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cThumbnailImage, forKey: SerializationKeys.cThumbnailImage)
  }

}
