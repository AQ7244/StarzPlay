//
//  ShowInfoInteractor.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol ShowInfoBusinessLogic
{
    func getShowInfo(request: ShowInfo.Show.Request)
    func getSeasonInfo(request: ShowInfo.Season.Request)
    func getEpisodeInfo(request: ShowInfo.Episode.Request)
}

protocol ShowInfoDataStore
{
    //var name: String { get set }
}

class ShowInfoInteractor: ShowInfoBusinessLogic, ShowInfoDataStore
{
    var presenter: ShowInfoPresentationLogic?
    var worker: ShowInfoWorker?
    //var name: String = ""
    
    // MARK: Get Show Info
    func getShowInfo(request: ShowInfo.Show.Request)
    {
        worker = ShowInfoWorker()
        
        worker?.getShowInfo(request: request, completion: { [weak self] result in
            
            switch result {
                
            case .success(let showInfo):
                let response = ShowInfo.Show.Response(success: true, error: nil, showInfo: showInfo)
                self?.presenter?.presentShowInfo(response: response)
                
            case .failure(let apiError):
                let response = ShowInfo.Show.Response(success: true, error: apiError, showInfo: nil)
                self?.presenter?.presentShowInfo(response: response)
            }
        })
    }
    
    // MARK: Get Season Info
    func getSeasonInfo(request: ShowInfo.Season.Request)
    {
        worker = ShowInfoWorker()
        
        worker?.getSeasonInfo(request: request, completion: { [weak self] result in
            
            switch result {
                
            case .success(let seasonInfo):
                let response = ShowInfo.Season.Response(success: true, error: nil, seasonInfo: seasonInfo)
                self?.presenter?.presentSeasonInfo(response: response)
                
            case .failure(let apiError):
                let response = ShowInfo.Season.Response(success: true, error: apiError, seasonInfo: nil)
                self?.presenter?.presentSeasonInfo(response: response)
            }
        })
    }
    
    // MARK: Episode Info
    func getEpisodeInfo(request: ShowInfo.Episode.Request)
    {
        worker = ShowInfoWorker()
        
        worker?.getEpisodeInfo(request: request, completion: { [weak self] result in
            
            switch result {
                
            case .success(let episodeInfo):
                let response = ShowInfo.Episode.Response(success: true, error: nil, episodeInfo: episodeInfo)
                self?.presenter?.presentEpisodeInfo(response: response)
                
            case .failure(let apiError):
                let response = ShowInfo.Episode.Response(success: true, error: apiError, episodeInfo: nil)
                self?.presenter?.presentEpisodeInfo(response: response)
            }
        })
    }
}
