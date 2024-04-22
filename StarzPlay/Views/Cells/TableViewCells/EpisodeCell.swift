//
//  EpisodeCell.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var lblSeasonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblSeasonName.setupTextAppearance(textColor: UIConfigurations.SPLightTextColor, tintColor: UIConfigurations.SPLightTextColor, font: UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeMedium))
        self.lblSeasonName.textAlignment = .left
        self.lblSeasonName.minimumScaleFactor = 0.7
    }

    func configureEpisodeCell(episode: Episodes?) {
        
        guard let currentEpisode = episode else { return }
        
        let episodeName = currentEpisode.name ?? ""
        lblSeasonName.text = episodeName
        
        if let episodeNumber = currentEpisode.episodeNumber {
            
            lblSeasonName.text = "E \(episodeNumber) - \(episodeName)"
        }
        
    }
}
