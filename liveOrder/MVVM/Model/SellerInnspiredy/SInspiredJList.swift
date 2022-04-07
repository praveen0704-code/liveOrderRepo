//
//  JList.swift
//
//  Created by PraveenMac on 09/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SInspiredJList: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let cSellerCode = "c_seller_code"
      static let acSellerImages = "ac_seller_images"
      static let cSellerName = "c_seller_name"
    }

    // MARK: Properties
    public var cSellerCode: String?
    public var acSellerImages: [AcSellerImages]?
    public var cSellerName: String?

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
      cSellerCode = json[SerializationKeys.cSellerCode].string
      if let items = json[SerializationKeys.acSellerImages].array { acSellerImages = items.map { AcSellerImages(json: $0) } }
      cSellerName = json[SerializationKeys.cSellerName].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = cSellerCode { dictionary[SerializationKeys.cSellerCode] = value }
      if let value = acSellerImages { dictionary[SerializationKeys.acSellerImages] = value.map { $0.dictionaryRepresentation() } }
      if let value = cSellerName { dictionary[SerializationKeys.cSellerName] = value }
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.cSellerCode = aDecoder.decodeObject(forKey: SerializationKeys.cSellerCode) as? String
      self.acSellerImages = aDecoder.decodeObject(forKey: SerializationKeys.acSellerImages) as? [AcSellerImages]
      self.cSellerName = aDecoder.decodeObject(forKey: SerializationKeys.cSellerName) as? String
    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(cSellerCode, forKey: SerializationKeys.cSellerCode)
      aCoder.encode(acSellerImages, forKey: SerializationKeys.acSellerImages)
      aCoder.encode(cSellerName, forKey: SerializationKeys.cSellerName)
    }

  }
