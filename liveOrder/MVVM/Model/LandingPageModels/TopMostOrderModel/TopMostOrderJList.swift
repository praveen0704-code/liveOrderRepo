//
//  JList.swift
//
//  Created by Data Prime on 13/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TopMostOrderJList: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let acThumbnailImages = "ac_thumbnail_images"
      static let cItemCode = "c_item_code"
      static let cWatchlistStatus = "c_watchlist_status"
      static let cContains = "c_contains"
      static let cScheme = "c_scheme"
      static let cShortBookStatus = "c_short_book_status"
      static let cItemName = "c_item_name"
      static let cPackName = "c_pack_name"
      static let nMrp = "n_mrp"
      static let cDiscountStatus = "c_discount_status"
      static let cPackTypeName = "c_pack_type_name"
    }

    // MARK: Properties
    public var acThumbnailImages: [TopMostAcThumbnailImages]?
    public var cItemCode: String?
    public var cWatchlistStatus: String?
    public var cContains: String?
    public var cScheme: String?
    public var cShortBookStatus: String?
    public var cItemName: String?
    public var cPackName: String?
    public var nMrp: Float?
    public var cDiscountStatus: String?
    public var cPackTypeName: String?

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
      if let items = json[SerializationKeys.acThumbnailImages].array { acThumbnailImages = items.map { TopMostAcThumbnailImages(json: $0) } }
      cItemCode = json[SerializationKeys.cItemCode].string
      cWatchlistStatus = json[SerializationKeys.cWatchlistStatus].string
      cContains = json[SerializationKeys.cContains].string
      cScheme = json[SerializationKeys.cScheme].string
      cShortBookStatus = json[SerializationKeys.cShortBookStatus].string
      cItemName = json[SerializationKeys.cItemName].string
      cPackName = json[SerializationKeys.cPackName].string
      nMrp = json[SerializationKeys.nMrp].float
      cDiscountStatus = json[SerializationKeys.cDiscountStatus].string
        cPackTypeName = json[SerializationKeys.cPackTypeName].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = acThumbnailImages { dictionary[SerializationKeys.acThumbnailImages] = value.map { $0.dictionaryRepresentation() } }
      if let value = cItemCode { dictionary[SerializationKeys.cItemCode] = value }
      if let value = cWatchlistStatus { dictionary[SerializationKeys.cWatchlistStatus] = value }
      if let value = cContains { dictionary[SerializationKeys.cContains] = value }
      if let value = cScheme { dictionary[SerializationKeys.cScheme] = value }
      if let value = cShortBookStatus { dictionary[SerializationKeys.cShortBookStatus] = value }
      if let value = cItemName { dictionary[SerializationKeys.cItemName] = value }
      if let value = cPackName { dictionary[SerializationKeys.cPackName] = value }
      if let value = nMrp { dictionary[SerializationKeys.nMrp] = value }
      if let value = cDiscountStatus { dictionary[SerializationKeys.cDiscountStatus] = value }
        if let value = cPackTypeName { dictionary[SerializationKeys.cPackTypeName] = value }

        
      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.acThumbnailImages = aDecoder.decodeObject(forKey: SerializationKeys.acThumbnailImages) as? [TopMostAcThumbnailImages]
      self.cItemCode = aDecoder.decodeObject(forKey: SerializationKeys.cItemCode) as? String
      self.cWatchlistStatus = aDecoder.decodeObject(forKey: SerializationKeys.cWatchlistStatus) as? String
      self.cContains = aDecoder.decodeObject(forKey: SerializationKeys.cContains) as? String
      self.cScheme = aDecoder.decodeObject(forKey: SerializationKeys.cScheme) as? String
      self.cShortBookStatus = aDecoder.decodeObject(forKey: SerializationKeys.cShortBookStatus) as? String
      self.cItemName = aDecoder.decodeObject(forKey: SerializationKeys.cItemName) as? String
      self.cPackName = aDecoder.decodeObject(forKey: SerializationKeys.cPackName) as? String
      self.nMrp = aDecoder.decodeObject(forKey: SerializationKeys.nMrp) as? Float
      self.cDiscountStatus = aDecoder.decodeObject(forKey: SerializationKeys.cDiscountStatus) as? String
        self.cPackTypeName = aDecoder.decodeObject(forKey: SerializationKeys.cPackTypeName) as? String
    }
    

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(acThumbnailImages, forKey: SerializationKeys.acThumbnailImages)
      aCoder.encode(cItemCode, forKey: SerializationKeys.cItemCode)
      aCoder.encode(cWatchlistStatus, forKey: SerializationKeys.cWatchlistStatus)
      aCoder.encode(cContains, forKey: SerializationKeys.cContains)
      aCoder.encode(cScheme, forKey: SerializationKeys.cScheme)
      aCoder.encode(cShortBookStatus, forKey: SerializationKeys.cShortBookStatus)
      aCoder.encode(cItemName, forKey: SerializationKeys.cItemName)
      aCoder.encode(cPackName, forKey: SerializationKeys.cPackName)
      aCoder.encode(nMrp, forKey: SerializationKeys.nMrp)
      aCoder.encode(cDiscountStatus, forKey: SerializationKeys.cDiscountStatus)
        aCoder.encode(cPackTypeName, forKey: SerializationKeys.cPackTypeName)

    }

}
