//
//  APIConfig.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

import Foundation

struct APIConfig {
    
    // MARK: - BaseUrl -
    
    static func getBaseUrl() -> String {
        return "\(BuildConfiguration.shared.baseURL)\(BuildConfiguration.shared.port)"
    }
    
    // MARK: - Enable/disbale API Logs -
    static let debug = BuildConfiguration.shared.environment != .release //Production
    
    // MARK: Endpoints
    static let GetShowInfoEndpoint = "/tv/\(Constants.PlaceholderShowId)"
    static let GetSeasonInfoEndpoint = "/tv/\(Constants.PlaceholderShowId)/season/\(Constants.PlaceholderSeasonNo)"
    static let GetEpisodeInfoEndpoint = "/tv/\(Constants.PlaceholderShowId)/season/\(Constants.PlaceholderSeasonNo)/episode/\(Constants.PlaceholderEpisodeNo)"
}
