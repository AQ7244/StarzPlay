//
//  ShowInfoPresenter.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//  Copyright (c) 2024 Aqeel Ahmed. All rights reserved.
//

import UIKit

protocol ShowInfoPresentationLogic
{
    func presentSomething(response: ShowInfo.Something.Response)
}

class ShowInfoPresenter: ShowInfoPresentationLogic
{
    weak var viewController: ShowInfoDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: ShowInfo.Something.Response)
    {
        let viewModel = ShowInfo.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
