//
//  SeasonCell.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

class SeasonCell: UICollectionViewCell {
    
    @IBOutlet weak var viewSelection: UIView!
    @IBOutlet weak var lblSeasonNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblSeasonNumber.setupTextAppearance(textColor: UIConfigurations.SPLightTextColor, tintColor: UIConfigurations.SPLightTextColor, font: UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeLarge))
        self.lblSeasonNumber.textAlignment = .center
        self.lblSeasonNumber.minimumScaleFactor = 0.7
    }
    
    func configureSeasonCell(seasons: [Seasons]?, row: Int, isSelected: Bool) {
        
        guard let seasons = seasons else { return}
        let currentSeason = seasons[row]
        lblSeasonNumber.text = "SEASON \(currentSeason.seasonNumber ?? 0)"
        
        if isSelected {
            
            self.lblSeasonNumber.setupTextAppearance(textColor: UIConfigurations.SPLightTextColor, tintColor: UIConfigurations.SPLightTextColor, font: UIConfigurations.getUIFontMedium(fontSize: UIConfigurations.kFontSizeLarge))
            self.viewSelection.backgroundColor = UIConfigurations.LightBackgroundColor
            
        } else {
            
            self.lblSeasonNumber.setupTextAppearance(textColor: UIConfigurations.FadeTextColor, tintColor: UIConfigurations.FadeTextColor, font: UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeLarge))
            self.viewSelection.backgroundColor = .clear
        }
    }
    
}
