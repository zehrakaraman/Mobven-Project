//
//  AccountProfileViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import UIKit

protocol AccountProfileDisplayLogic: AnyObject {
    
}

final class AccountProfileViewController: UIViewController {
    static let identifier = "AccountProfileViewController"
    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    
    var interactor: AccountProfileBusinessLogic?
    var router: (AccountProfileRoutingLogic & AccountProfileDataPassing)?
    
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
        
        guard var isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        darkModeSwitch.setOn(isDarkMode, animated: true)
        
        
        
        
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = AccountProfileInteractor()
        let presenter = AccountProfilePresenter()
        let router = AccountProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    @IBAction func switchDarkMode(_ sender: UISwitch) {
        guard var isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        
        if darkModeSwitch.isOn {
            isDarkMode = true
        } else {
            isDarkMode = false
        }
        
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene}).compactMap({ $0 }).first?.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
    
}

extension AccountProfileViewController: AccountProfileDisplayLogic {
    
}
