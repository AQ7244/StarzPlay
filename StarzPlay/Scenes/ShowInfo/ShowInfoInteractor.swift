//
//  ShowInfoInteractor.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//  Copyright (c) 2024 Aqeel Ahmed. All rights reserved.
//

import UIKit

protocol ShowInfoBusinessLogic
{
    func doSomething(request: ShowInfo.Something.Request)
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
    
    // MARK: Do something
    
    func doSomething(request: ShowInfo.Something.Request)
    {
        worker = ShowInfoWorker()
        worker?.doSomeWork()
        
        let response = ShowInfo.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
