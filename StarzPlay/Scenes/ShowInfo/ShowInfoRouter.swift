//
//  ShowInfoRouter.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//  Copyright (c) 2024 Aqeel Ahmed. All rights reserved.
//

import UIKit

@objc protocol ShowInfoRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowInfoDataPassing
{
    var dataStore: ShowInfoDataStore? { get }
}

class ShowInfoRouter: NSObject, ShowInfoRoutingLogic, ShowInfoDataPassing
{
    weak var viewController: ShowInfoViewController?
    var dataStore: ShowInfoDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ShowInfoViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ShowInfoDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
