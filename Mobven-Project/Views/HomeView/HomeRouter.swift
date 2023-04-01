//
//  HomeRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 18.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToAccountProfile()
    func routeToChat(index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func routeToAccountProfile() {
        let storyboard = UIStoryboard(name: "AccountProfile", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: AccountProfileViewController.identifier) as! AccountProfileViewController
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    func routeToChat(index: Int) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        destinationView.router?.dataStore?.authorizedUser = dataStore?.authorizedUser
        destinationView.router?.dataStore?.user = viewController?.usersViewModel?[index]
        viewController?.navigationController?.pushViewController(destinationView, animated: true)
    }
}
