//
//  UIConfigurations.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import Foundation
import UIKit

@objc class UIConfigurations: NSObject {
    
    // MARK: Theme Colors
    static let LightBackgroundColor: UIColor = UIColor(named: "LightBackgroundColor") ?? UIColor.white
    static let DarkBackgroundColor: UIColor = UIColor(named: "DarkBackgroundColor") ?? UIColor.black
    static let FadeTextColor: UIColor = UIColor(named: "FadeTextColor") ?? UIColor.lightGray
    static let SPLightTextColor: UIColor = UIColor(named: "SPLightTextColor") ?? UIColor.white
    static let SPDarkTextColor: UIColor = UIColor(named: "SPDarkTextColor") ?? UIColor.black
    
    //MARK: Font Sizes
    static let kFontSizeHeading1 : CGFloat = 30
    static let kFontSizeHeading2 : CGFloat = 24
    static let kFontSizeHeading3 : CGFloat = 22
    static let kFontSizeHeading4 : CGFloat = 20
    static let kFontSizeHeading5 : CGFloat = 18
    static let kFontSizeLarge : CGFloat = 16
    static let kFontSizeMedium : CGFloat = 14
    static let kFontSizeSmall : CGFloat = 12
    static let kFontSizeExtraSmall : CGFloat = 10
    
    // MARK: GET UI FONT
    class func getUIFontRegular(fontSize: CGFloat = 12.0) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    class func getUIFontMedium(fontSize: CGFloat = 12.0) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    class func getUIFontBold(fontSize: CGFloat = 12.0) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    // MARK: Model Transition Style
    static let ModelPresentationStyle: UIModalPresentationStyle = .overCurrentContext
    static let ModelTransitionAnimation: UIModalTransitionStyle = .coverVertical
    static let AlertModeltransitionAnimation: UIModalTransitionStyle = .crossDissolve
}
