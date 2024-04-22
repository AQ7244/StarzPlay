//
//  APIService.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

import Foundation
import Moya
import UIKit

// MARK: - APIService

enum APIService {
    
    case getShowInfo(request: ShowInfo.Show.Request)
    case getSeasonInfo(request: ShowInfo.Season.Request)
    case getEpisodeInfo(request: ShowInfo.Episode.Request)
}

extension APIService : TargetType {
    
    var baseURL: URL {
        
        switch self {
        
        case .getShowInfo:
            guard let url = URL(string: APIConfig.getBaseUrl()) else { fatalError("baseURL could not be configured.")}
            return url
            
        case .getSeasonInfo:
            guard let url = URL(string: APIConfig.getBaseUrl()) else { fatalError("baseURL could not be configured.")}
            return url
            
        case .getEpisodeInfo:
            guard let url = URL(string: APIConfig.getBaseUrl()) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    var path: String {
        
        switch self {
            
        case .getShowInfo(let request):
            return APIConfig.GetShowInfoEndpoint.replacingOccurrences(of: Constants.PlaceholderShowId, with: request.showId ?? "\(Constants.BillionsShowId)")
            
        case .getSeasonInfo(let request):
            return APIConfig.GetSeasonInfoEndpoint.replacingOccurrences(of: Constants.PlaceholderShowId, with: request.showId ?? "\(Constants.BillionsShowId)").replacingOccurrences(of: Constants.PlaceholderSeasonNo, with: request.seasonNumber ?? "1")
            
        case .getEpisodeInfo(let request):
            return APIConfig.GetEpisodeInfoEndpoint.replacingOccurrences(of: Constants.PlaceholderShowId, with: request.showId ?? "\(Constants.BillionsShowId)").replacingOccurrences(of: Constants.PlaceholderSeasonNo, with: request.seasonNumber ?? "1").replacingOccurrences(of: Constants.PlaceholderEpisodeNo, with: request.episodeNumber ?? "1")
        }
        
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .getShowInfo:
            return .get
            
        case .getSeasonInfo:
            return .get
            
        case .getEpisodeInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        
        switch self {
            
        case .getShowInfo:
            return GeneralUtility.stubbedResponse("GetShowInfo")
            
        case .getSeasonInfo:
            return GeneralUtility.stubbedResponse("GetSeasonInfo")
            
        case .getEpisodeInfo:
            return GeneralUtility.stubbedResponse("GetEpisodeInfo")
        }
    }
    
    var task: Task {
        
        switch self {
            
        case .getShowInfo, .getSeasonInfo, .getEpisodeInfo:
            var params: [String: Any] = [:]
            params = ["api_key": BuildConfiguration.shared.tmdbAPIKey]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        switch self {

        case .getShowInfo, .getSeasonInfo, .getEpisodeInfo:
            
            return ["Content-Type" : "application/json", "accept" : "application/json"]
            
//        case .signup:
//
//            return ["Content-Type" : "application/json", "accept" : "application/json", "Authorization" : "Bearer \(SharedManager.manager.getToken())"]
        }
    }
}

extension Encodable {
    
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
