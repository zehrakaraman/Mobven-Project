//
//  RegisterRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol RegisterRoutingLogic: AnyObject {
    func routeToVerification()
}

protocol RegisterDataPassing: AnyObject {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    func routeToVerification() {
        let storyboard = UIStoryboard(name: "Verification", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: VerificationViewController.identifier) as! VerificationViewController
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
    
}
