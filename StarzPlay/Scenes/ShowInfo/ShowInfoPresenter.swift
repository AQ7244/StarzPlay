//
//  ShowInfoPresenter.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol ShowInfoPresentationLogic
{
    func presentShowInfo(response: ShowInfo.Show.Response)
    func presentSeasonInfo(response: ShowInfo.Season.Response)
    func presentEpisodeInfo(response: ShowInfo.Episode.Response)
}

class ShowInfoPresenter: ShowInfoPresentationLogic
{
    weak var viewController: ShowInfoDisplayLogic?
    
    // MARK: Present Show Info
    func presentShowInfo(response: ShowInfo.Show.Response)
    {
        let viewModel = ShowInfo.Show.ViewModel(success: response.success, error: response.error, showInfo: response.showInfo)
        viewController?.displayShowInfo(viewModel: viewModel)
    }
    
    // MARK: Present Season Info
    func presentSeasonInfo(response: ShowInfo.Season.Response)
    {
        let viewModel = ShowInfo.Season.ViewModel(success: response.success, error: response.error, seasonInfo: response.seasonInfo)
        viewController?.displaySeasonInfo(viewModel: viewModel)
    }
    
    // MARK: Present Episode Info
    func presentEpisodeInfo(response: ShowInfo.Episode.Response)
    {
        let viewModel = ShowInfo.Episode.ViewModel(success: response.success, error: response.error, episodeInfo: response.episodeInfo)
        viewController?.displayEpisodeInfo(viewModel: viewModel)
    }
}
