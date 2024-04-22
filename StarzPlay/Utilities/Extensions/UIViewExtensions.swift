//
//  UIViewExtensions.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

import Foundation
import UIKit

extension UIView {
    
    func setupButtonAppearance(cornerRaius: CGFloat, borderWidth: CGFloat = 1.0 , borderColor: CGColor? = UIColor.clear.cgColor, backgroundColor: UIColor? = UIConfigurations.DarkBackgroundColor) {
        
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRaius
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}
