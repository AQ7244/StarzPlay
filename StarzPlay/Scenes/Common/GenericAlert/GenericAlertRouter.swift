//
//  GenericAlertRouter.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

@objc protocol GenericAlertRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol GenericAlertDataPassing
{
    var dataStore: GenericAlertDataStore? { get }
}

class GenericAlertRouter: NSObject, GenericAlertRoutingLogic, GenericAlertDataPassing
{
    weak var viewController: GenericAlertViewController?
    var dataStore: GenericAlertDataStore?
    
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
    
    //func navigateToSomewhere(source: GenericAlertViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: GenericAlertDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
