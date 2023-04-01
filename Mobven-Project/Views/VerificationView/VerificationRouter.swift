//
//  VerificationRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol VerificationRoutingLogic: AnyObject {
    func routeToLogin()
}

protocol VerificationDataPassing: AnyObject {
    var dataStore: VerificationDataStore? { get }
}

final class VerificationRouter: VerificationRoutingLogic, VerificationDataPassing {
    
    weak var viewController: VerificationViewController?
    var dataStore: VerificationDataStore?
    
    func routeToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as! LoginViewController
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
}
