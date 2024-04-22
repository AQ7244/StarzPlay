//
//  APIManager.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import Foundation
import Moya
import Alamofire

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}


protocol GeneralAPI {
    
    static func callApi<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type, test: Bool, sslPinningEnabled: Bool, showActivityIndicator: Bool, debugMode: Bool, completion: @escaping ((Result<U, APIError>) -> Void))
}

struct APIManager: GeneralAPI {
    
    /// Generic function to call API endpoints using moya and decodable protocol
    ///
    /// - Parameters:
    ///   - target: The network moya target endpoint to call
    ///   - dataReturnType: The typpe of data that is expected to parse from endpoint response
    ///   - test: Boolean that help toggle real network call or simple mock data to be returned by moya
    ///   - debugMode: Toggle the verbose mode of moya
    /// - Returns: A completion closure containing the dataReturnType set in function params
    
    static func callApi<Target, ReturnedObject>(_ target: Target, dataReturnType: ReturnedObject.Type, test: Bool = false, sslPinningEnabled: Bool = false, showActivityIndicator: Bool = true, debugMode: Bool = false, completion: @escaping ((Result<ReturnedObject, APIError>) -> Void)) where Target: Moya.TargetType, ReturnedObject: Decodable {
        
        if GeneralUtility.isNetworkAvaliable() {
            if showActivityIndicator {
                GeneralUtility.getAppKeyWindow()?.rootViewController?.showProgress()
            }
            
            let provider = test ? (MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub)) :
                (debugMode ? MoyaProvider<Target>(session: DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))]) : MoyaProvider<Target>(session: DefaultAlamofireManager.sharedManager))
  
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    
                    let decoder = JSONDecoder()
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        let results = try decoder.decode(ReturnedObject.self, from: response.data)
                        completion(.success(results))
                        
                    } catch {
                        
                        do {
                            
                            var apiError = try decoder.decode(APIError.self, from: response.data)
                            apiError.errorCode = Int(apiError.messageCode ?? "")
                            completion(.failure(apiError))
                            
                        } catch {
                            let apiError = APIError.init(status: Constants.Oops, statusTitle: Constants.Oops, message: Constants.GeneralFailureMessage, messageCode: "\(response.statusCode)")
                            completion(.failure(apiError))
                        }
                    }
                case let .failure(error):
                    let apiError = APIError.init(status: Constants.Failure, statusTitle: Constants.Failure, message: Constants.GeneralFailureMessage, messageCode: "\(error.errorCode)")
                    completion(.failure(apiError))
                }
                
                if showActivityIndicator {
                    GeneralUtility.getAppKeyWindow()?.rootViewController?.hideProgress()
                }
            }
        } else {
            // Show internet not available alert
            DispatchQueue.main.async {
                GeneralUtility.getAppKeyWindow()?.rootViewController?.showGenericAlert(title: AlertType.Warning.rawValue, description: Constants.ErrorInternetConnection, alertType: .Warning, isBtn1Hidden: true)
            }
        }
    }
}

class DefaultAlamofireManager: Alamofire.Session {
    
    static let sharedManager: DefaultAlamofireManager = {
        
        var policies: [String: ServerTrustManager]?
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
