//
//  JList.swift
//
//  Created by Data Prime on 01/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ShopMfgJList: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let cManufactureCode = "c_manufacture_code"
      static let acImages = "ac_images"
      static let cManufactureName = "c_manufacture_name"
      static let acThumbnailImages = "ac_thumbnail_images"
    }

    // MARK: Properties
    public var cManufactureCode: String?
    public var acImages: [ShopMFAcImages]?
    public var cManufactureName: String?
    public var acThumbnailImages: [ShopMFAcThumbnailImages]?

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
      cManufactureCode = json[SerializationKeys.cManufactureCode].string
      if let items = json[SerializationKeys.acImages].array { acImages = items.map { ShopMFAcImages(json: $0) } }
      cManufactureName = json[SerializationKeys.cManufactureName].string
      if let items = json[SerializationKeys.acThumbnailImages].array { acThumbnailImages = items.map { ShopMFAcThumbnailImages(json: $0) } }
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = cManufactureCode { dictionary[SerializationKeys.cManufactureCode] = value }
      if let value = acImages { dictionary[SerializationKeys.acImages] = value.map { $0.dictionaryRepresentation() } }
      if let value = cManufactureName { dictionary[SerializationKeys.cManufactureName] = value }
      if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value.map { $0.dictionaryRepresentation() } }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.cManufactureCode = aDecoder.decodeObject(forKey: SerializationKeys.cManufactureCode) as? String
      self.acImages = aDecoder.decodeObject(forKey: SerializationKeys.acImages) as? [ShopMFAcImages]
      self.cManufactureName = aDecoder.decodeObject(forKey: SerializationKeys.cManufactureName) as? String
      self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? [ShopMFAcThumbnailImages]
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(cManufactureCode, forKey: SerializationKeys.cManufactureCode)
      aCoder.encode(acImages, forKey: SerializationKeys.acImages)
      aCoder.encode(cManufactureName, forKey: SerializationKeys.cManufactureName)
      aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
    }

}
