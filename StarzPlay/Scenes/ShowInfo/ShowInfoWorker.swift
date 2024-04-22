//
//  ShowInfoWorker.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

class ShowInfoWorker
{
    // MARK: Get Show Info
    func getShowInfo(request: ShowInfo.Show.Request, completion: @escaping ((Result<ShowBase,APIError>) -> Void)) {
        
        let target = APIService.getShowInfo(request: request)
        APIManager.callApi(target, dataReturnType: ShowBase.self, test: request.test, sslPinningEnabled: request.sslPinningEnabled, showActivityIndicator: request.showActivityIndicator, debugMode: APIConfig.debug, completion: { result in
            
            switch result {
            case .success(let showInfo):
                
                completion(.success(showInfo))
                
            case .failure(let apiError):
                
                completion(.failure(apiError))
            }
        })
    }
    
    // MARK: Get Season Info
    func getSeasonInfo(request: ShowInfo.Season.Request, completion: @escaping ((Result<SeasonModel,APIError>) -> Void)) {
        
        let target = APIService.getSeasonInfo(request: request)
        APIManager.callApi(target, dataReturnType: SeasonModel.self, test: request.test, sslPinningEnabled: request.sslPinningEnabled, showActivityIndicator: request.showActivityIndicator, debugMode: APIConfig.debug, completion: { result in
            
            switch result {
            case .success(let seasonInfo):
                
                completion(.success(seasonInfo))
                
            case .failure(let apiError):
                
                completion(.failure(apiError))
            }
        })
    }
    
    // MARK: Get Episode Info
    func getEpisodeInfo(request: ShowInfo.Episode.Request, completion: @escaping ((Result<EpisodeModel,APIError>) -> Void)) {
        
        let target = APIService.getEpisodeInfo(request: request)
        APIManager.callApi(target, dataReturnType: EpisodeModel.self, test: request.test, sslPinningEnabled: request.sslPinningEnabled, showActivityIndicator: request.showActivityIndicator, debugMode: APIConfig.debug, completion: { result in
            
            switch result {
            case .success(let episodeInfo):
                
                completion(.success(episodeInfo))
                
            case .failure(let apiError):
                
                completion(.failure(apiError))
            }
        })
    }
}
