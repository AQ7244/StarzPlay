//
//  GenericAlertInteractor.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol GenericAlertBusinessLogic
{
    func doSomething(request: GenericAlert.Something.Request)
}

protocol GenericAlertDataStore
{
    //var name: String { get set }
}

class GenericAlertInteractor: GenericAlertBusinessLogic, GenericAlertDataStore
{
    var presenter: GenericAlertPresentationLogic?
    var worker: GenericAlertWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: GenericAlert.Something.Request)
    {
        worker = GenericAlertWorker()
        worker?.doSomeWork()
        
        let response = GenericAlert.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
