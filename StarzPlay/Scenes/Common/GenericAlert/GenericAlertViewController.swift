//
//  GenericAlertViewController.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit

protocol GenericAlertDisplayLogic: AnyObject
{
    func displaySomething(viewModel: GenericAlert.Something.ViewModel)
}

enum AlertType : String {
    case Success = "Success"
    case Failure = "Failure"
    case Warning = "Warning"
    case Info    = "Info"
    case Caution = "Caution"
}

class GenericAlertViewController: UIViewController, GenericAlertDisplayLogic
{
    var interactor: GenericAlertBusinessLogic?
    var router: (NSObjectProtocol & GenericAlertRoutingLogic & GenericAlertDataPassing)?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var imgVwAlertIcon: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    
    var btn1ActionHandler : (() -> ())?
    var btn2ActionHandler : (() -> ())?
    
    var dismissAlertOnBtn1Tap : Bool! = true
    var dismissAlertOnBtn2Tap : Bool! = true
    
    // Configurations properties
    var alertTitle : String!
    var alertDescription : String!
    
    var btn1Title : String?
    var btn2Title : String?
    
    var btn1Configurations : GenericAlertButtonConfigurations? = GenericAlertButtonConfigurations(borderColor: UIConfigurations.DarkBackgroundColor.cgColor, backgroundColor: UIConfigurations.LightBackgroundColor, title: Constants.Cancel.uppercased(), titleColor: UIConfigurations.SPDarkTextColor)
    var btn2Configurations : GenericAlertButtonConfigurations? = GenericAlertButtonConfigurations(title: Constants.OK.uppercased())
    
    var iconName: String?
    
    var isNormalAlertConfigurations : Bool = true
    
    var alertType : AlertType! = .Info
    
    var isBtn1Hidden = false
    var isBtn2Hidden = false
    
    var isCrossBtnHidden = true
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = GenericAlertInteractor()
        let presenter = GenericAlertPresenter()
        let router = GenericAlertRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        
        self.configureView()
    }
    
    // MARK: - Configure View
    fileprivate func configureView() {
        
        self.btnCross.isHidden = isCrossBtnHidden
        
        enableDisableButton1(isEnable: true)
        enableDisableButton2(isEnable: true)
        
        self.lblTitle.setupTextAppearance(textColor: UIConfigurations.SPDarkTextColor, tintColor: UIConfigurations.SPDarkTextColor, font: UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeHeading4))
        self.lblDescription.setupTextAppearance(textColor: UIConfigurations.SPDarkTextColor)
        self.mainView.setupButtonAppearance(cornerRaius: 2, backgroundColor: UIConfigurations.LightBackgroundColor)
        
        self.lblTitle.text = alertTitle
        self.lblDescription.text = alertDescription
        
        if let btn1Title = self.btn1Title {
            btn1Configurations?.title = btn1Title
        }
        
        if let btn2Title = self.btn2Title {
            btn2Configurations?.title = btn2Title
        }
        
        btn1Configurations?.isBtnHidden = isBtn1Hidden
        btn2Configurations?.isBtnHidden = isBtn2Hidden
        self.configureButton1(alertButtonConfigurations: btn1Configurations)
        self.configureButton2(alertButtonConfigurations: btn2Configurations)
        
        self.configureAlertIcon(alertType: alertType, iconName: iconName)
    }
    
    // MARK: - Configure Button1
    func configureButton1(alertButtonConfigurations: GenericAlertButtonConfigurations?) {
        
        guard let alertButtonConfigurations = alertButtonConfigurations else {
            return
        }
        
        self.btn1.isHidden = alertButtonConfigurations.isBtnHidden
        self.btn1.setupButtonAppearance(cornerRaius: alertButtonConfigurations.cornerRaius, borderWidth: alertButtonConfigurations.borderWidth, borderColor: alertButtonConfigurations.borderColor, backgroundColor: alertButtonConfigurations.backgroundColor)
        
        self.btn1.setTitle(alertButtonConfigurations.title, for: .normal)
        self.btn1.setTitleColor(alertButtonConfigurations.titleColor, for: .normal)
        self.btn1.tintColor = alertButtonConfigurations.titleColor
        self.btn1.titleLabel?.font = alertButtonConfigurations.font
        // update dismissAlert on button tap properties
        self.dismissAlertOnBtn1Tap = alertButtonConfigurations.dismissAlertOnButtonTap
    }
    
    // MARK: - Configure Button2
    func configureButton2(alertButtonConfigurations: GenericAlertButtonConfigurations?) {
        
        guard let alertButtonConfigurations = alertButtonConfigurations else {
            return
        }
        
        self.btn2.isHidden = alertButtonConfigurations.isBtnHidden
        self.btn2.setupButtonAppearance(cornerRaius: alertButtonConfigurations.cornerRaius, borderWidth: alertButtonConfigurations.borderWidth, borderColor: alertButtonConfigurations.borderColor, backgroundColor: alertButtonConfigurations.backgroundColor)
        self.btn2.setTitle(alertButtonConfigurations.title, for: .normal)
        self.btn2.setTitleColor(alertButtonConfigurations.titleColor, for: .normal)
        self.btn2.tintColor = alertButtonConfigurations.titleColor
        self.btn2.titleLabel?.font = alertButtonConfigurations.font
        // update dismissAlert on button tap properties
        self.dismissAlertOnBtn2Tap = alertButtonConfigurations.dismissAlertOnButtonTap
    }
    
    //MARK: - Configure Alert icon
    fileprivate func configureAlertIcon(alertType: AlertType, iconName: String? = "") {
        
        if iconName != nil && iconName?.count ?? 0 > 0 {
            if let icon = UIImage(named: iconName!) {
                self.imgVwAlertIcon.image = icon
            }
        } else {
            switch alertType {
            case .Success:
                self.imgVwAlertIcon.image = UIImage(named: "ic_alert_success")
            case .Failure:
                self.imgVwAlertIcon.image = UIImage(named: "ic_alert_warning")
            case .Warning:
                self.imgVwAlertIcon.image = UIImage(named: "ic_alert_warning")
            case .Caution:
                self.imgVwAlertIcon.image = UIImage(named: "ic_alert_warning")
            default:
                self.imgVwAlertIcon.image = UIImage(named: "ic_alert_success")
            }
        }
    }
    
    // MARK: - Enable/Disable Button1
    private func enableDisableButton1(isEnable: Bool) {
        
        self.btn1.isUserInteractionEnabled = isEnable
    }
    
    // MARK: - Enable/Disable Button1
    private func enableDisableButton2(isEnable: Bool) {
        
        self.btn2.isUserInteractionEnabled = isEnable
    }
    
    // MARK:- Show Alert
    func configureHBLGenericAlert(title: String, description: String, alertType: AlertType, btn1Title: String? = Constants.Cancel.uppercased(), btn2Title: String? = Constants.OK.uppercased(), isCrossBtnHidden: Bool = true, isBtn1Hidden: Bool = true, isBtn2Hidden: Bool = false, btn1ActionHandler: (() -> ())? = nil, btn2ActionHandler: (() -> ())? = nil) {
        
        self.alertTitle = title
        self.alertDescription = description
        
        self.btn1Title = btn1Title
        self.btn2Title = btn2Title
        
        self.btn1ActionHandler = btn1ActionHandler
        self.btn2ActionHandler = btn2ActionHandler
        
        self.alertType = alertType
        
        self.isBtn1Hidden = isBtn1Hidden
        self.isBtn2Hidden = isBtn2Hidden
        
        self.isCrossBtnHidden = isCrossBtnHidden
        
        self.isNormalAlertConfigurations = true
        
    }
    
    func configureHBLGenericAlert(title: String, description: String, alertType: AlertType, isCrossBtnHidden: Bool = true, iconName: String?, btn1Configurations: GenericAlertButtonConfigurations? = nil , btn2Configurations: GenericAlertButtonConfigurations? = nil, btn1ActionHandler: (() -> ())? = nil, btn2ActionHandler: (() -> ())? = nil) {
        
        self.alertTitle = title
        self.alertDescription = description
        
        self.btn1ActionHandler = btn1ActionHandler
        self.btn2ActionHandler = btn2ActionHandler
        
        self.btn1Configurations = btn1Configurations
        self.btn2Configurations = btn2Configurations
        
        self.alertType = alertType
        
        self.isCrossBtnHidden = isCrossBtnHidden
        
        self.isNormalAlertConfigurations = false
        
    }
    
    // MARK: - IBActions
    
    @IBAction func btnCrossTapped(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn1Tapped(_ sender: UIButton) {
        
        if dismissAlertOnBtn1Tap {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.btn1ActionHandler?()
    }
    
    @IBAction func btn2Tapped(_ sender: UIButton) {
        
        if dismissAlertOnBtn2Tap {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.btn2ActionHandler?()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = GenericAlert.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: GenericAlert.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

struct GenericAlertButtonConfigurations {
    
    var cornerRaius: CGFloat
    var borderWidth: CGFloat
    var borderColor: CGColor?
    var backgroundColor: UIColor?
    var title: String?
    var titleColor : UIColor?
    var font: UIFont?
    var dismissAlertOnButtonTap : Bool! = true
    var isBtnHidden = false
    
    init(cornerRaius: CGFloat = 2, borderWidth: CGFloat = 1, borderColor: CGColor? = UIConfigurations.DarkBackgroundColor.cgColor, backgroundColor: UIColor? = UIConfigurations.DarkBackgroundColor, title: String?, titleColor : UIColor? = UIConfigurations.SPLightTextColor, font: UIFont? = UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeMedium), isBtnHidden: Bool = false, dismissAlertOnButtonTap : Bool? = true) {
        
        self.isBtnHidden = isBtnHidden
        self.cornerRaius = cornerRaius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.title = title
        self.titleColor = titleColor
        self.font = font
        self.dismissAlertOnButtonTap = dismissAlertOnButtonTap
        
    }
}
