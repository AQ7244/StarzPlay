//
//  ShowInfoModels.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

enum ShowInfo
{
    // MARK: Use cases
    
    enum Show
    {
        struct Request
        {
            var showId: String?
            
            var test : Bool = false
            var sslPinningEnabled = false
            var showActivityIndicator = false
        }
        
        struct Response
        {
            var success: Bool?
            var error : APIError?
            var showInfo: ShowBase?
        }
        
        struct ViewModel
        {
            var success: Bool?
            var error : APIError?
            // I am adding whole model object in the ViewModel too but ideally it should contains the info only related to UI
            var showInfo: ShowBase?
        }
    }
    
    enum Season
    {
        struct Request
        {
            var showId: String?
            var seasonNumber: String?
            
            var test : Bool = false
            var sslPinningEnabled = false
            var showActivityIndicator = false
        }
        
        struct Response
        {
            var success: Bool?
            var error : APIError?
            var seasonInfo: SeasonModel?
        }
        
        struct ViewModel
        {
            var success: Bool?
            var error : APIError?
            // I am adding whole model object in the ViewModel too but ideally it should contains the info only related to UI
            var seasonInfo: SeasonModel?
        }
    }
    
    enum Episode
    {
        struct Request
        {
            var showId: String?
            var seasonNumber: String?
            var episodeNumber: String?
            
            var test : Bool = false
            var sslPinningEnabled = false
            var showActivityIndicator = false
        }
        
        struct Response
        {
            var success: Bool?
            var error : APIError?
            var episodeInfo: EpisodeModel?
        }
        
        struct ViewModel
        {
            var success: Bool?
            var error : APIError?
            // I am adding whole model object in the ViewModel too but ideally it should contains the info only related to UI
            var episodeInfo: EpisodeModel?
        }
    }
}
