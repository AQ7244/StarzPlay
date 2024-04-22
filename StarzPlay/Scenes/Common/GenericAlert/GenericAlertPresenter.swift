//
//  GenericAlertPresenter.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol GenericAlertPresentationLogic
{
    func presentSomething(response: GenericAlert.Something.Response)
}

class GenericAlertPresenter: GenericAlertPresentationLogic
{
    weak var viewController: GenericAlertDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: GenericAlert.Something.Response)
    {
        let viewModel = GenericAlert.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
