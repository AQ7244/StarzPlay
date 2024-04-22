//
//  GeneralUtility.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import Foundation
import UIKit

protocol GeneralUtilityProtocol {
    
    static func stubbedResponse(_ filename: String) -> Data!
    static func getAppKeyWindow() -> UIWindow?
    static func isNetworkAvaliable() -> Bool
}

class GeneralUtility: GeneralUtilityProtocol {
    
    // MARK: Get Stub Response
    static func stubbedResponse(_ filename: String) -> Data! {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { fatalError("path could not be found") }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    
    //
    static func getAppKeyWindow() -> UIWindow? {
        
        if #available(iOS 13.0, *) {
            
            var keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            if keyWindow == nil {
                
                keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundInactive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            }
            
            return keyWindow
            
        } else {
            // Fallback on earlier versions
            return UIApplication.shared.keyWindow
        }
    }
    
    // MARK: Network Methods
    // For actual implementation of this method, need to integrate ReachabilitySwift pod to check internet connection
    static func isNetworkAvaliable() -> Bool {
//        do {
//            switch try Reachability().connection {
//            case .none:
//                return false
//            case .unavailable:
//                return false
//            default:
//                return true
//            }
//            
//        } catch {
//            print(error)
//            return true
//        }
        return true
    }
}

public func println(object: Any) {
#if DEBUG
    print(object)
#endif
}
