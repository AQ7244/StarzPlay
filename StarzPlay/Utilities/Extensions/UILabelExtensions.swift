//
//  UILabelExtensions.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

import Foundation
import UIKit

extension UILabel {
    
    func setupTextAppearance(textColor: UIColor = UIConfigurations.SPDarkTextColor, tintColor: UIColor = UIConfigurations.SPDarkTextColor, font: UIFont = UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeMedium)) {
        self.textColor = textColor
        self.tintColor = tintColor
        self.font = font
    }
}
