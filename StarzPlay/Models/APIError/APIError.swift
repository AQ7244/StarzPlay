//
//  APIError.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import Foundation

// MARK: - APIError
struct APIError: Codable, Error {
    var status, statusTitle: String?
    var result: String?
    var message, messageCode: String?
    var errorCode: Int?
    
    init(status: String?, statusTitle: String?, message: String?, messageCode: String?) {
        self.status = status
        self.statusTitle = statusTitle
        self.message = message
        self.messageCode = messageCode
        self.errorCode = Int(messageCode ?? "")
    }
    
    init(status: String?, statusTitle: String?, message: String?, messageCode: String?, errorCode: Int?) {
        self.init(status: status, statusTitle: statusTitle, message: message, messageCode: messageCode)
        self.errorCode = errorCode
    }
}
