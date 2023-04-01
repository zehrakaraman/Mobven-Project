//
//  WelcomeRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol WelcomeRoutingLogic: AnyObject {
    func routeToRegister()
    func routeToLogin()
}

protocol WelcomeDataPassing: AnyObject {
    var dataStore: WelcomeDataStore? { get }
}

final class WelcomeRouter: WelcomeRoutingLogic, WelcomeDataPassing {
    
    weak var viewController: WelcomeViewController?
    var dataStore: WelcomeDataStore?
    
    func routeToRegister() {
        let storyBoard = UIStoryboard(name: "Register", bundle: nil)
        let destinationView = storyBoard.instantiateViewController(withIdentifier: RegisterViewController.identifier) as! RegisterViewController
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    func routeToLogin() {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let destinationView = storyBoard.instantiateViewController(withIdentifier: LoginViewController.identifier) as! LoginViewController
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
}
