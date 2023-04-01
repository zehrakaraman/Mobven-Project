//
//  LoginRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func routeToHome()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        destinationView.router?.dataStore?.authorizedUser = dataStore?.loginResponse?.body
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
}
