//
//  UIViewControllerExtensions.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol ViewControllerExtensionMethodsProtocol {
    func hideProgress()
    func showProgress()
    func showGenericAlert(title: String, description: String, alertType: AlertType, btn1Title: String?, btn2Title: String?, isCrossBtnHidden: Bool, isBtn1Hidden: Bool, isBtn2Hidden: Bool, btn1ActionHandler: (() -> ())?, btn2ActionHandler: (() -> ())?)
    func showGenericAlert(title: String, description: String, alertType: AlertType, isCrossBtnHidden: Bool, iconName: String?, btn1Configurations: GenericAlertButtonConfigurations?, btn2Configurations: GenericAlertButtonConfigurations?, btn1ActionHandler: (() -> ())?, btn2ActionHandler: (() -> ())?)
}

extension UIViewController: ViewControllerExtensionMethodsProtocol, StoryboardIdentifiable {
    
    // MARK: Show/Hide Progress Methods
    // To show/hide progress we can integrate MBProgressHUD pod or can implement our own using activity indicator
    func showProgress() {
        
//        let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        
//        progressHud.label.textColor = UIConfiguration.WhiteColor
//        progressHud.bezelView.style = .solidColor
//        progressHud.bezelView.color = UIConfiguration.DarkGreyColor
//        progressHud.label.text = Constants.PleaseWaitMsg
    }
    
    func hideProgress() {
        
//        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showGenericAlert(title: String, description: String, alertType: AlertType, btn1Title: String? = Constants.Cancel.uppercased(), btn2Title: String? = Constants.OK.uppercased(), isCrossBtnHidden: Bool = true, isBtn1Hidden: Bool = true, isBtn2Hidden: Bool = false, btn1ActionHandler: (() -> ())? = nil, btn2ActionHandler: (() -> ())? = nil) {
        
        let storyboard = UIStoryboard(storyboard: .Common)
        let genericAlertController: GenericAlertViewController =  storyboard.instantiateViewController()
        genericAlertController.modalPresentationStyle = UIConfigurations.ModelPresentationStyle
        genericAlertController.modalTransitionStyle = UIConfigurations.AlertModeltransitionAnimation
        
        genericAlertController.configureHBLGenericAlert(title: title, description: description, alertType: alertType, btn1Title: btn1Title, btn2Title: btn2Title, isCrossBtnHidden: isCrossBtnHidden, isBtn1Hidden: isBtn1Hidden, isBtn2Hidden: isBtn2Hidden, btn1ActionHandler: btn1ActionHandler, btn2ActionHandler: btn2ActionHandler)
        
        self.present(genericAlertController, animated: true, completion: nil)
    }
    
    func showGenericAlert(title: String, description: String, alertType: AlertType, isCrossBtnHidden: Bool = true, iconName: String?, btn1Configurations: GenericAlertButtonConfigurations? = nil, btn2Configurations: GenericAlertButtonConfigurations? = nil, btn1ActionHandler: (() -> ())? = nil, btn2ActionHandler: (() -> ())? = nil) {
        
        let storyboard = UIStoryboard(storyboard: .Common)
        let genericAlertController: GenericAlertViewController =  storyboard.instantiateViewController()
        genericAlertController.modalPresentationStyle = UIConfigurations.ModelPresentationStyle
        genericAlertController.modalTransitionStyle = UIConfigurations.AlertModeltransitionAnimation
        
        genericAlertController.configureHBLGenericAlert(title: title, description: description, alertType: alertType, isCrossBtnHidden: isCrossBtnHidden,iconName: iconName, btn1Configurations: btn1Configurations, btn2Configurations: btn2Configurations, btn1ActionHandler: btn1ActionHandler, btn2ActionHandler: btn2ActionHandler)
        
        self.present(genericAlertController, animated: true, completion: nil)
    }
}
