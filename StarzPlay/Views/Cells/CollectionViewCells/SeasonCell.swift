//
//  SeasonCell.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

class SeasonCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSeasonNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureSeasonCell(seasons: [Seasons]?, row: Int) {
        
        guard let seasons = seasons else { return}
        let currentSeason = seasons[row]
        lblSeasonNumber.text = "SEASON \(currentSeason.seasonNumber ?? 0)"
    }
    
}
