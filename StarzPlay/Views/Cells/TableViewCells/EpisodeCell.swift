//
//  EpisodeCell.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var seasonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureEpisodeCell(episode: Episodes?) {
        
        guard let currentEpisode = episode else { return }
        seasonNameLabel.text = currentEpisode.name
        
    }
}
