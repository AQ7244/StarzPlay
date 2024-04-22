//
//  EpisodeModel.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

import Foundation

// MARK: - EpisodeModel
struct EpisodeModel: Codable {
    
    let airDate: String?
    let crew: [Crew]?
    let episodeNumber: Int?
    let guestStars: [Crew]?
    let name, overview: String?
    let id: Int?
    let productionCode: String?
    let runtime, seasonNumber: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        
        case airDate = "air_date"
        case crew
        case episodeNumber = "episode_number"
        case guestStars = "guest_stars"
        case name, overview, id
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
