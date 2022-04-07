//
//  Constant.swift
//  liveOrder
//
//  Created by Data Prime on 15/09/21.
//

import Foundation
import UIKit

class Constant : NSObject {
    
    static let SharedInstance = Constant()
    
    static func getRedColor() -> UIColor {
        return UIColor.red
    }
    
    static func getDarkGrayColor() -> UIColor {
        return UIColor.darkGray
    }
    
    static func getLightGrayColor() -> UIColor {
        return UIColor.lightGray
    }
    
    static func getPickerBGColor() -> UIColor {
        return UIColor(red: 255/255, green: 165/255, blue: 76/255, alpha: 1)
    }
    
    static func getToolBarBGColor() -> UIColor {
        return UIColor.appprimary.lighter(by: 5.0)!
    }
    
    static func getToolBarTintColor() -> UIColor {
        return UIColor.appprimary
    }
    
    static func getAlertViewTintColor() -> UIColor {
        return UIColor(red: 244/255, green: 123/255, blue: 32/255, alpha: 1)
    }
    
    static func getAlertViewBackGroungColor() -> UIColor {
        return UIColor.orange
    }
    
    static func getTextFieldIconImageSize() -> UIImageView {
        return UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    static func getPickerViewSize() -> UIPickerView {
        return UIPickerView(frame:CGRect(x: 0, y: 0, width: Constant.getDeviceFrame().width, height: 216))
    }
    
    static func getDatePickerSize() -> UIDatePicker {
        return UIDatePicker(frame:CGRect(x: 0, y: 0, width: Constant.getDeviceFrame().width, height: 216))
    }
    
    static func getDeviceFrame() -> CGRect {
        return UIScreen.main.bounds
    }
    
    static func getWarning() -> UIColor {
        return UIColor(red: 240/255, green: 173/255, blue: 78/255, alpha: 0.6)
    }
    
    // MARK: -Tab bar
    static var initialPage = 0
    static var tabBarHeight = 50
    static var tabbarfontsize = 11
   
}




