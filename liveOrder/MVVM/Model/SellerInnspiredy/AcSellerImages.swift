//
//  AcSellerImages.swift
//
//  Created by PraveenMac on 26/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AcSellerImages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cSellerImage = "c_seller_image"
  }

  // MARK: Properties
  public var cSellerImage: String?

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
    cSellerImage = json[SerializationKeys.cSellerImage].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cSellerImage { dictionary[SerializationKeys.cSellerImage] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cSellerImage = aDecoder.decodeObject(forKey: SerializationKeys.cSellerImage) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cSellerImage, forKey: SerializationKeys.cSellerImage)
  }

}
