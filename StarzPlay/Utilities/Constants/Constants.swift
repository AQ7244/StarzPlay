//
//  Constants.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: General
    static let Oops = "Oops..!"
    static let Cancel = "Cancel"
    static let Success = "Success"
//    static let Error = "Error"
    static let Alert = "Alert!"
    static let Failure = "Failure"
    static let OK = "Ok"
    
    // MARK: Messages
    static let GeneralFailureMessage = "Something went wrong, please try again later."
    static let ErrorInternetConnection = "Internet connection appears to be offline."
    static let UnableToFetchShowInfo = "Unable to Fetch Show Info, please try again later."
    static let UnableToFetchSeasonInfo = "Unable to Fetch Season Info, please try again later."
    static let UnableToFetchEpisodeInfo = "Unable to Fetch Episode Info, please try again later."
    
    //MARK: API Constants
    static let PlaceholderShowId = ":ShowId"
    static let PlaceholderSeasonNo = ":SeasonNo"
    static let PlaceholderEpisodeNo = ":EpisodeNo"
    static let BillionsShowId = 62852
}
