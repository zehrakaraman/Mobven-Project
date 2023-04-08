//
//  WelcomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol WelcomeDisplayLogic: AnyObject {
    
}

final class WelcomeViewController: UIViewController {
    static let identifier = "WelcomeViewController"
    
    var interactor: WelcomeBusinessLogic?
    var router: (WelcomeRoutingLogic & WelcomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        router?.routeToRegister()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        router?.routeToLogin()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension WelcomeViewController: WelcomeDisplayLogic {
    
}
