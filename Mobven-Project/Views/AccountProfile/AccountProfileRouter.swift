//
//  AccountProfileRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import UIKit

protocol AccountProfileRoutingLogic: AnyObject {
    func routeToWeb()
}

protocol AccountProfileDataPassing: AnyObject {
    var dataStore: AccountProfileDataStore? { get }
}

final class AccountProfileRouter: AccountProfileRoutingLogic, AccountProfileDataPassing {
    weak var viewController: AccountProfileViewController?
    var dataStore: AccountProfileDataStore?

    func routeToWeb() {
        let storyboard = UIStoryboard(name: "AccountProfile", bundle: nil)
        let destinationView = storyboard.instantiateViewController(identifier: WebViewController.identifier)
        viewController?.present(destinationView, animated: true)
    }
}
