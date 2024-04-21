//
//  BuildConfiguration.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 19/04/2024.
//

import Foundation

// For now there are only two configurations i.e. Debug and Release but for production ready application we can add staging/QA/UAT and so the values will be changed accordingly
enum Environment: String {
    
    case debug = "Debug"
    case staging = "Staging"
    case release = "Release"
}


class BuildConfiguration {
    
    static let shared = BuildConfiguration()
    var environment: Environment
    
    public var baseURL: String {
        
        switch environment {
        case .debug:    //Develop
            return "https://api.themoviedb.org/3"
        case .staging:  //For UAT
            return "https://api.themoviedb.org/3"
        case .release:  //Production
            return "https://api.themoviedb.org/3"
        }
    }
    
    public var tmdbAPIKey: String {
        
        switch environment {
        case .debug:
            return "ecef14eac236a5d4ec6ac3a4a4761e8f"
        case .staging:
            return "ecef14eac236a5d4ec6ac3a4a4761e8f"
        case .release:
            return "ecef14eac236a5d4ec6ac3a4a4761e8f"
        }
    }
    
    // If there is need to attach port manually with baseURL
    public var port: String {
        
        switch environment {
        case .debug:
            return ""
        case .staging:
            return ""
        case .release:
            return ""
        }
    }
    
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String
        environment = Environment(rawValue: currentConfiguration ?? "")!
    }
}
